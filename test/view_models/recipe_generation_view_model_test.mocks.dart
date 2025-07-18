// Mocks generated by Mockito 5.4.4 from annotations
// in ai_chef/test/view_models/recipe_generation_view_model_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:ai_chef/src/models/recipe_model.dart' as _i2;
import 'package:ai_chef/src/services/interfaces/gemini_service_interface.dart'
    as _i3;
import 'package:ai_chef/src/services/interfaces/recipe_service_interface.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeRecipeModel_0 extends _i1.SmartFake implements _i2.RecipeModel {
  _FakeRecipeModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GeminiServiceInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockGeminiServiceInterface extends _i1.Mock
    implements _i3.GeminiServiceInterface {
  MockGeminiServiceInterface() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.RecipeModel> generateRecipe(List<String>? ingredients) =>
      (super.noSuchMethod(
        Invocation.method(
          #generateRecipe,
          [ingredients],
        ),
        returnValue: _i4.Future<_i2.RecipeModel>.value(_FakeRecipeModel_0(
          this,
          Invocation.method(
            #generateRecipe,
            [ingredients],
          ),
        )),
      ) as _i4.Future<_i2.RecipeModel>);
}

/// A class which mocks [RecipeServiceInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockRecipeServiceInterface extends _i1.Mock
    implements _i5.RecipeServiceInterface {
  MockRecipeServiceInterface() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> saveRecipe(_i2.RecipeModel? recipe) => (super.noSuchMethod(
        Invocation.method(
          #saveRecipe,
          [recipe],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<List<_i2.RecipeModel>> getSavedRecipes() => (super.noSuchMethod(
        Invocation.method(
          #getSavedRecipes,
          [],
        ),
        returnValue:
            _i4.Future<List<_i2.RecipeModel>>.value(<_i2.RecipeModel>[]),
      ) as _i4.Future<List<_i2.RecipeModel>>);

  @override
  _i4.Future<void> updateRecipe(_i2.RecipeModel? recipe) => (super.noSuchMethod(
        Invocation.method(
          #updateRecipe,
          [recipe],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
