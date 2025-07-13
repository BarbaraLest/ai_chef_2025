import 'package:ai_chef/src/datasources/gemini_remote_datasource.dart';
import 'package:ai_chef/src/datasources/local_db_datasource.dart';
import 'package:ai_chef/src/pages/recipe_generation_page.dart';
import 'package:ai_chef/src/services/gemini_service_impl.dart';
import 'package:ai_chef/src/services/interfaces/gemini_service_interface.dart';
import 'package:ai_chef/src/services/interfaces/recipe_service_interface.dart';
import 'package:ai_chef/src/services/recipe_service_impl.dart';
import 'package:ai_chef/src/view_models/recipe_edit_view_model.dart';
import 'package:ai_chef/src/view_models/recipe_generation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localDataSource = RecipeLocalDataSourceImpl();
  await localDataSource.initDb();

  runApp(MyApp(localDataSource: localDataSource));
}

class MyApp extends StatelessWidget {
  final LocalDBDataSource localDataSource;

  const MyApp({super.key, required this.localDataSource});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GeminiRemoteDataSource>(
          create: (_) => GeminiRemoteDataSourceImpl(client: http.Client()),
        ),
        Provider<LocalDBDataSource>(
          create: (_) => localDataSource,
        ),
        Provider<GeminiServiceInterface>(
          create: (context) => GeminiServiceImpl(
            remoteDataSource: context.read<GeminiRemoteDataSource>(),
          ),
        ),
        Provider<RecipeServiceInterface>(
          create: (context) => RecipeServiceImpl(
            localDataSource: context.read<LocalDBDataSource>(),
          ),
        ),
        ChangeNotifierProvider<RecipeGenerationViewModel>(
          create: (context) => RecipeGenerationViewModel(
              geminiService: context.read<GeminiServiceInterface>(),
              recipeService: context.read<RecipeServiceInterface>()),
        ),
        ChangeNotifierProvider<RecipeEditViewModel>(
          create: (context) => RecipeEditViewModel(
            recipeService: context.read<RecipeServiceInterface>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'AI Chef',
        theme: ThemeData(
          primaryColor: const Color(0xFFD7BDE2), // Lavanda Pastel
          scaffoldBackgroundColor: const Color(0xFFF8F7FF), // Branco Lilás
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFFD7BDE2), // Lavanda Pastel
            secondary: const Color(0xFFF7DC6F), // Amarelo Manteiga
            onPrimary: const Color(
                0xFF563D7C), // Texto Roxo Escuro sobre a cor primária
            onSecondary: const Color(
                0xFF563D7C), // Texto Roxo Escuro sobre a cor secundária
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 1,
            surfaceTintColor: Colors.transparent,
            titleTextStyle: TextStyle(
              color: Color(0xFF563D7C), // Roxo Escuro
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: Color(0xFF563D7C), // Roxo Escuro
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF7DC6F), // Amarelo Manteiga
              foregroundColor: const Color(0xFF563D7C), // Texto Roxo Escuro
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFFEAE6F3),
            hintStyle:
                TextStyle(color: const Color(0xFF563D7C).withOpacity(0.6)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFD7BDE2), width: 2),
            ),
          ),
          cardTheme: CardTheme(
            color: Colors.white,
            elevation: 2,
            shadowColor: const Color(0xFFD7BDE2).withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          chipTheme: ChipThemeData(
            backgroundColor: const Color(0xFFD7BDE2).withOpacity(0.4),
            labelStyle: const TextStyle(
                color: Color(0xFF563D7C), fontWeight: FontWeight.w500),
            deleteIconColor: const Color(0xFF563D7C).withOpacity(0.7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide.none,
            ),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Color(0xFF563D7C), fontSize: 16),
            bodyMedium: TextStyle(color: Color(0xFF563D7C), fontSize: 14),
            headlineMedium: TextStyle(
                color: Color(0xFF563D7C), fontWeight: FontWeight.bold),
            titleLarge: TextStyle(
                color: Color(0xFF563D7C), fontWeight: FontWeight.bold),
          ),
        ),
        home: const RecipeGenerationPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
