import 'package:ai_chef/src/pages/recipe_details_page.dart';
import 'package:ai_chef/src/pages/saved_recipes_page.dart';
import 'package:ai_chef/src/view_models/recipe_generation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RecipeGenerationPage extends StatefulWidget {
  const RecipeGenerationPage({super.key});

  @override
  State<RecipeGenerationPage> createState() => _RecipeGenerationPageState();
}

class _RecipeGenerationPageState extends State<RecipeGenerationPage> {
  final _ingredientController = TextEditingController();
  final List<String> _ingredients = [];

  void _addIngredient() {
    if (_ingredientController.text.isNotEmpty) {
      setState(() {
        _ingredients.add(_ingredientController.text);
        _ingredientController.clear();
      });
    }
  }

  void _removeIngredient(String ingredient) {
    setState(() {
      _ingredients.remove(ingredient);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chef 🧑‍🍳🧑‍🍳'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SavedRecipesPage()),
              );
            },
            tooltip: 'Receitas Salvas',
          ),
        ],
      ),
      body: Consumer<RecipeGenerationViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitPouringHourGlassRefined(
                      color: theme.colorScheme.primary, size: 80.0),
                  const SizedBox(height: 20),
                  Text('A IA está cozinhando sua receita...',
                      style: theme.textTheme.bodyLarge),
                ],
              ),
            );
          }

          if (viewModel.state.isSuccess && viewModel.generatedRecipe != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeDetailPage(
                    recipe: viewModel.generatedRecipe!,
                    isFromGeneration: true,
                  ),
                ),
              ).then((_) => viewModel.reset());
            });
          }

          if (viewModel.state.isError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Erro: ${viewModel.errorMessage}'),
                  backgroundColor: Colors.red,
                ),
              );
              viewModel.reset();
            });
          }

          return newRecipeWidget();
        },
      ),
    );
  }

  Widget newRecipeWidget() {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Quais ingredientes você tem em casa?',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _ingredientController,
            decoration: InputDecoration(
              hintText: 'Ex: Frango, tomate, arroz...',
              suffixIcon: IconButton(
                icon:
                    Icon(Icons.add_circle, color: theme.colorScheme.secondary),
                onPressed: _addIngredient,
              ),
            ),
            onSubmitted: (_) => _addIngredient(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _ingredients.isEmpty
                ? Center(
                    child: Text('Adicione ingredientes para começar.',
                        style: TextStyle(
                            color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.6))))
                : Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: _ingredients
                        .map((ingredient) => Chip(
                              label: Text(ingredient),
                              onDeleted: () => _removeIngredient(ingredient),
                            ))
                        .toList(),
                  ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.auto_awesome),
            label: const Text('Gerar Receita'),
            onPressed: _ingredients.isEmpty
                ? null
                : () {
                    context
                        .read<RecipeGenerationViewModel>()
                        .generateRecipe(_ingredients);
                  },
          ),
        ],
      ),
    );
  }
}
