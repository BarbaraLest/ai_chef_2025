import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/recipe_model.dart';

abstract class LocalDBDataSource {
  Future<void> initDb();
  Future<void> cacheRecipe(RecipeModel recipe);
  Future<List<RecipeModel>> getSavedRecipes();
  Future<void> updateRecipe(RecipeModel recipe);
}

class RecipeLocalDataSourceImpl implements LocalDBDataSource {
  Database? _database;
  static const String _tableName = 'recipes';

  @override
  Future<void> initDb() async {
    if (_database != null) return;
    String path = join(await getDatabasesPath(), 'recipes_database.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, ingredients TEXT, steps TEXT, nutritionalInfo TEXT)',
        );
      },
    );
  }

  @override
  Future<void> cacheRecipe(RecipeModel recipe) async {
    await _database!.insert(
      _tableName,
      recipe.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<RecipeModel>> getSavedRecipes() async {
    final List<Map<String, dynamic>> maps = await _database!.query(_tableName);
    return List.generate(maps.length, (i) {
      return RecipeModel.fromJson(maps[i]);
    });
  }

  @override
  Future<void> updateRecipe(RecipeModel recipe) async {
    await _database!.update(
      _tableName,
      recipe.toJson(),
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }
}
