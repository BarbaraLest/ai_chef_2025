import 'package:ai_chef/src/enums/view_state_enum.dart';
import 'package:ai_chef/src/models/recipe_model.dart';
import 'package:ai_chef/src/services/interfaces/gemini_service_interface.dart';
import 'package:ai_chef/src/services/interfaces/recipe_service_interface.dart';
import 'package:flutter/material.dart';

class RecipeGenerationViewModel extends ChangeNotifier {
  final GeminiServiceInterface _geminiService;
  final RecipeServiceInterface _recipeService;

  RecipeGenerationViewModel({
    required GeminiServiceInterface geminiService,
    required RecipeServiceInterface recipeService,
  })  : _recipeService = recipeService,
        _geminiService = geminiService;

  ViewStateEnum _state = ViewStateEnum.idle;
  ViewStateEnum get state => _state;

  RecipeModel? _generatedRecipe;
  RecipeModel? get generatedRecipe => _generatedRecipe;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> generateRecipe(List<String> ingredients) async {
    _state = ViewStateEnum.loading;
    notifyListeners();

    try {
      _generatedRecipe = await _geminiService.generateRecipe(ingredients);
      _state = ViewStateEnum.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewStateEnum.error;
    }
    notifyListeners();
  }

  Future<void> saveGeneratedRecipe() async {
    if (_generatedRecipe != null) {
      try {
        await _recipeService.saveRecipe(_generatedRecipe!);
      } catch (e) {
        print("Erro ao salvar receita: $e");
      }
    }
  }

  void reset() {
    _state = ViewStateEnum.idle;
    _generatedRecipe = null;
    _errorMessage = null;
    notifyListeners();
  }
}
