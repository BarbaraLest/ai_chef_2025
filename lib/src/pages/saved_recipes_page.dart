import 'package:ai_chef/src/pages/recipe_details_page.dart';
import 'package:ai_chef/src/view_models/recipe_edit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedRecipesPage extends StatefulWidget {
  const SavedRecipesPage({super.key});

  @override
  State<SavedRecipesPage> createState() => _SavedRecipesPageState();
}

class _SavedRecipesPageState extends State<SavedRecipesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeEditViewModel>().fetchSavedRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Receitas Salvas'),
      ),
      body: Consumer<RecipeEditViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.state.isError) {
            return Center(child: Text('Erro: ${viewModel.errorMessage}'));
          }
          if (viewModel.savedRecipes.isEmpty) {
            return const Center(
              child: Text(
                'Você ainda não salvou nenhuma receita.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: viewModel.savedRecipes.length,
            itemBuilder: (context, index) {
              final recipe = viewModel.savedRecipes[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(recipe.title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    recipe.ingredients,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailPage(recipe: recipe),
                      ),
                    ).then((_) {
                      viewModel.fetchSavedRecipes();
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
