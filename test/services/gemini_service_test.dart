import 'package:ai_chef/src/datasources/gemini_remote_datasource.dart';
import 'package:ai_chef/src/models/recipe_model.dart';
import 'package:ai_chef/src/services/gemini_service_impl.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'gemini_service_test.mocks.dart';

@GenerateMocks([GeminiRemoteDataSource])
void main() {
  late MockGeminiRemoteDataSource mockDataSource;
  late GeminiServiceImpl service;

  setUp(() {
    mockDataSource = MockGeminiRemoteDataSource();
    service = GeminiServiceImpl(remoteDataSource: mockDataSource);
  });

  const tRecipe = RecipeModel(
      title: 'Teste',
      ingredients: 'Ingredientes',
      steps: 'Passos',
      nutritionalInfo: 'Info');
  final tIngredients = ['Tomate'];

  test(
    'UseCase: Deve obter receita do repositório',
    () async {
      // Arrange
      when(mockDataSource.generateRecipe(any)).thenAnswer((_) async => tRecipe);

      // Act
      final result = await service.generateRecipe(tIngredients);

      // Assert
      expect(result, tRecipe);
      verify(mockDataSource.generateRecipe(tIngredients));
      verifyNoMoreInteractions(mockDataSource);
    },
  );
}
