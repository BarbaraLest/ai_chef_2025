import 'package:ai_chef/src/datasources/local_db_datasource.dart';
import 'package:ai_chef/src/services/interfaces/recipe_service_interface.dart';

import '../models/recipe_model.dart';

class RecipeServiceImpl implements RecipeServiceInterface {
  final LocalDBDataSource localDataSource;

  RecipeServiceImpl({
    required this.localDataSource,
  });

  @override
  Future<void> saveRecipe(RecipeModel recipe) async {
    await localDataSource.cacheRecipe(recipe);
  }

  @override
  Future<List<RecipeModel>> getSavedRecipes() async {
    return await localDataSource.getSavedRecipes();
  }

  @override
  Future<void> updateRecipe(RecipeModel recipe) async {
    await localDataSource.updateRecipe(recipe);
  }
}
