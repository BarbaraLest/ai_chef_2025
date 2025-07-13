import 'package:ai_chef/src/models/recipe_model.dart';
import 'package:ai_chef/src/view_models/recipe_edit_view_model.dart';
import 'package:ai_chef/src/view_models/recipe_generation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetailPage extends StatefulWidget {
  final RecipeModel recipe;
  final bool isFromGeneration;

  const RecipeDetailPage({
    super.key,
    required this.recipe,
    this.isFromGeneration = false,
  });

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _ingredientsController;
  late TextEditingController _stepsController;
  late TextEditingController _nutritionController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe.title);
    _ingredientsController =
        TextEditingController(text: widget.recipe.ingredients);
    _stepsController = TextEditingController(text: widget.recipe.steps);
    _nutritionController =
        TextEditingController(text: widget.recipe.nutritionalInfo);

    _isEditing = !widget.isFromGeneration;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    _nutritionController.dispose();
    super.dispose();
  }

  void _onSave() {
    final updatedRecipe = widget.recipe.copyWith(
      title: _titleController.text,
      ingredients: _ingredientsController.text,
      steps: _stepsController.text,
      nutritionalInfo: _nutritionController.text,
    );

    if (widget.isFromGeneration) {
      context.read<RecipeGenerationViewModel>().saveGeneratedRecipe().then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Receita salva com sucesso!'),
              backgroundColor: Colors.green),
        );
        Navigator.pop(context); // Volta para a tela de geração
      });
    } else {
      context.read<RecipeEditViewModel>().updateRecipe(updatedRecipe).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Alterações salvas!'),
              backgroundColor: Colors.green),
        );
        setState(() {
          _isEditing = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Receita' : _titleController.text),
        actions: [
          if (widget.isFromGeneration)
            TextButton.icon(
              style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.onPrimary),
              icon: const Icon(Icons.check_rounded),
              label: const Text('Salvar'),
              onPressed: _onSave,
            )
          else if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => setState(() => _isEditing = true),
              tooltip: 'Editar',
            )
          else
            TextButton.icon(
              icon: const Icon(Icons.check),
              style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.onPrimary),
              label: const Text(
                'Concluir',
              ),
              onPressed: _onSave,
            )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Título', theme),
            _buildEditableField(_titleController),
            const SizedBox(height: 20),
            _buildSectionTitle('Ingredientes', theme),
            _buildEditableField(_ingredientsController, maxLines: 10),
            const SizedBox(height: 20),
            _buildSectionTitle('Modo de Preparo', theme),
            _buildEditableField(_stepsController, maxLines: 15),
            const SizedBox(height: 20),
            _buildSectionTitle('Informações Nutricionais (Estimativa)', theme),
            _buildEditableField(_nutritionController, maxLines: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleLarge
          ?.copyWith(color: theme.colorScheme.primary, fontSize: 20),
    );
  }

  Widget _buildEditableField(TextEditingController controller,
      {int maxLines = 1}) {
    return _isEditing
        ? TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration:
                const InputDecoration(contentPadding: EdgeInsets.all(12)),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Text(
              controller.text,
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
          );
  }
}
