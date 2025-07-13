import 'package:ai_chef/src/enums/view_state_enum.dart';
import 'package:ai_chef/src/models/recipe_model.dart';
import 'package:ai_chef/src/services/interfaces/recipe_service_interface.dart';
import 'package:flutter/material.dart';

class RecipeEditViewModel extends ChangeNotifier {
  final RecipeServiceInterface _recipeService;

  RecipeEditViewModel({
    required RecipeServiceInterface recipeService,
  }) : _recipeService = recipeService;

  ViewStateEnum _state = ViewStateEnum.idle;
  ViewStateEnum get state => _state;

  List<RecipeModel> _savedRecipes = [];
  List<RecipeModel> get savedRecipes => _savedRecipes;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchSavedRecipes() async {
    _state = ViewStateEnum.loading;
    notifyListeners();
    try {
      _savedRecipes = await _recipeService.getSavedRecipes();
      _state = ViewStateEnum.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewStateEnum.error;
    }
    notifyListeners();
  }

  Future<void> updateRecipe(RecipeModel recipe) async {
    try {
      await _recipeService.updateRecipe(recipe);
      final index = _savedRecipes.indexWhere((r) => r.id == recipe.id);
      if (index != -1) {
        _savedRecipes[index] = recipe;
      }
      notifyListeners();
    } catch (e) {
      print("Erro ao atualizar receita: $e");
    }
  }
}
