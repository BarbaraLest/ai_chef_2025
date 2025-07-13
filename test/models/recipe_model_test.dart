import 'package:ai_chef/src/models/recipe_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tRecipeModel = RecipeModel(
    title: 'Bolo de Cenoura da IA',
    ingredients: '3 cenouras\n2 ovos\n1 xícara de óleo',
    steps: '1. Bata tudo no liquidificador.\n2. Asse por 40 minutos.',
    nutritionalInfo: 'Calorias: 2500 kcal',
  );

  test(
    'Modelo: Deve ser uma subclasse da entidade Recipe',
    () {
      // Assert
      expect(tRecipeModel, isA<RecipeModel>());
    },
  );

  group('copyWith', () {
    test(
      'deve retornar uma cópia com os dados alterados',
      () {
        // Act
        final result = tRecipeModel.copyWith(id: 1).id;

        // Assert
        expect(result, 1);
      },
    );
  });

  group('toJson', () {
    test(
      'deve retornar um json de acordo com os dados do modelo',
      () {
        // Arrange
        const recipe = RecipeModel(
          title: 'Bolo de Cenoura da IA',
          ingredients: '',
          steps: '',
          nutritionalInfo: '',
        );

        // Act
        final result = recipe.toJson();

        // Assert
        expect(result, {
          'id': null,
          'title': 'Bolo de Cenoura da IA',
          'ingredients': '',
          'steps': '',
          'nutritionalInfo': '',
        });
      },
    );
  });
}
