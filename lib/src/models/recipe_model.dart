import 'package:equatable/equatable.dart';

import 'package:flutter/foundation.dart';

class RecipeModel extends Equatable {
  final int? id;
  final String title;
  final String ingredients;
  final String steps;
  final String nutritionalInfo;

  const RecipeModel({
    required this.title,
    required this.ingredients,
    required this.steps,
    required this.nutritionalInfo,
    this.id,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      ingredients: json['ingredients'],
      steps: json['steps'],
      nutritionalInfo: json['nutritionalInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'ingredients': ingredients,
      'steps': steps,
      'nutritionalInfo': nutritionalInfo,
    };
  }

  RecipeModel copyWith({
    int? id,
    String? title,
    String? ingredients,
    String? steps,
    String? nutritionalInfo,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      nutritionalInfo: nutritionalInfo ?? this.nutritionalInfo,
    );
  }

  factory RecipeModel.fromAiResponse(String textResponse) {
    try {
      final title = _extractSection(textResponse, 'TITULO');
      final ingredients = _extractSection(textResponse, 'INGREDIENTES');
      final steps = _extractSection(textResponse, 'PASSOS');
      final nutrition = _extractSection(textResponse, 'NUTRICIONAL');

      return RecipeModel(
        title: title,
        ingredients: ingredients,
        steps: steps,
        nutritionalInfo: nutrition,
      );
    } catch (e) {
      if (kDebugMode) {
        print(
            "Não foi possível criar uma receita válida. Por favor, aguarde alguns instantes e tente novamente.");
      }

      return const RecipeModel(
          title: "Erro na Receita",
          ingredients: "Não foi possível extrair os ingredientes.",
          steps: "Não foi possível extrair os passos.",
          nutritionalInfo:
              "Não foi possível extrair as informações nutricionais.");
    }
  }

  static String _extractSection(String text, String marker) {
    final startMarker = '###$marker###';
    final endMarker = '###FIM-$marker###';
    final startIndex = text.indexOf(startMarker);
    final endIndex = text.indexOf(endMarker);

    if (startIndex != -1 && endIndex != -1) {
      return text.substring(startIndex + startMarker.length, endIndex).trim();
    }

    if (marker == 'TITULO' && !text.contains('###')) {
      return text.split('\n').first;
    }
    return 'Não encontrado';
  }

  @override
  List<Object?> get props => [
        title,
        ingredients,
        steps,
        nutritionalInfo,
        id,
      ];
}
