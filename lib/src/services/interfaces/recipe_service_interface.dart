import 'package:ai_chef/src/models/recipe_model.dart';

abstract class RecipeServiceInterface {
  Future<void> saveRecipe(RecipeModel recipe);

  Future<List<RecipeModel>> getSavedRecipes();

  Future<void> updateRecipe(RecipeModel recipe);
}
