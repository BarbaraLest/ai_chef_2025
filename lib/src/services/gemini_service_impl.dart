import 'package:ai_chef/src/datasources/gemini_remote_datasource.dart';
import 'package:ai_chef/src/services/interfaces/gemini_service_interface.dart';

import '../models/recipe_model.dart';

class GeminiServiceImpl implements GeminiServiceInterface {
  final GeminiRemoteDataSource remoteDataSource;
  GeminiServiceImpl({
    required this.remoteDataSource,
  });

  @override
  Future<RecipeModel> generateRecipe(List<String> ingredients) async {
    return await remoteDataSource.generateRecipe(ingredients);
  }
}
