import 'package:ai_chef/src/models/recipe_model.dart';

abstract class GeminiServiceInterface {
  Future<RecipeModel> generateRecipe(List<String> ingredients);
}
