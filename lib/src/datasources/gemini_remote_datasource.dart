import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/recipe_model.dart';

abstract class GeminiRemoteDataSource {
  Future<RecipeModel> generateRecipe(List<String> ingredients);
}

class GeminiRemoteDataSourceImpl implements GeminiRemoteDataSource {
  final http.Client client;
  final String _apiKey = "GEMINI_API_KEY";
  final String _url =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

  GeminiRemoteDataSourceImpl({required this.client});

  @override
  Future<RecipeModel> generateRecipe(List<String> ingredients) async {
    final prompt = _buildPrompt(ingredients);

    try {
      final response = await client.post(
        Uri.parse('$_url?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        final text =
            decodedResponse['candidates'][0]['content']['parts'][0]['text'];
        return RecipeModel.fromAiResponse(text);
      } else {
        throw Exception(
            'Falha ao comunicar com a IA. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha ao gerar receita.');
    }
  }

  String _buildPrompt(List<String> ingredients) {
    return """
    Crie uma receita criativa usando os seguintes ingredientes: ${ingredients.join(', ')}.
    A resposta DEVE seguir ESTRITAMENTE o seguinte formato, usando os marcadores exatos:

    ###TITULO###
    [Nome criativo para a receita aqui]
    ###FIM-TITULO###

    ###INGREDIENTES###
    [Liste todos os ingredientes necessários, incluindo os que foram dados e outros que você queira adicionar. Use um por linha e descreva as medidas.]
    ###FIM-INGREDIENTES###

    ###PASSOS###
    [Descreva o modo de preparo em passos numerados.]
    ###FIM-PASSOS###

    ###NUTRICIONAL###
    [Faça uma estimativa das calorias totais do prato e, se possível, de macros como proteínas, carboidratos e gorduras.]
    ###FIM-NUTRICIONAL###
    """;
  }
}
