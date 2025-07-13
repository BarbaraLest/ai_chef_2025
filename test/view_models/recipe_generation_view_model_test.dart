import 'package:ai_chef/src/enums/view_state_enum.dart';
import 'package:ai_chef/src/models/recipe_model.dart';
import 'package:ai_chef/src/services/interfaces/gemini_service_interface.dart';
import 'package:ai_chef/src/services/interfaces/recipe_service_interface.dart';
import 'package:ai_chef/src/view_models/recipe_generation_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recipe_generation_view_model_test.mocks.dart';

@GenerateMocks([GeminiServiceInterface, RecipeServiceInterface])
void main() {
  late MockGeminiServiceInterface mockGenerateRecipe;
  late MockRecipeServiceInterface mockRecipeService;
  late RecipeGenerationViewModel viewModel;

  setUp(() {
    mockGenerateRecipe = MockGeminiServiceInterface();
    mockRecipeService = MockRecipeServiceInterface();
    viewModel = RecipeGenerationViewModel(
      geminiService: mockGenerateRecipe,
      recipeService: mockRecipeService,
    );
  });

  const tRecipe = RecipeModel(
    title: 'Frango Teste',
    ingredients: '1kg de Frango',
    steps: 'Asse o frango',
    nutritionalInfo: 'Muitas calorias',
  );

  final tIngredients = ['Frango'];

  test(
    'ViewModel: Deve mudar o estado para loading e depois para success ao gerar receita',
    () async {
      // Arrange

      when(mockGenerateRecipe.generateRecipe(any))
          .thenAnswer((_) async => tRecipe);

      // Act
      final future = viewModel.generateRecipe(tIngredients);

      // Assert
      expect(viewModel.state, ViewStateEnum.loading);
      await future;
      expect(viewModel.state, ViewStateEnum.success);
      expect(viewModel.generatedRecipe, tRecipe);
    },
  );
}
