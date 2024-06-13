import 'package:dartx/dartx.dart';

extension StringExt on String {
  String toKebabCase() {
    try {
      return toLowerCamelCase()
          .replaceAllMapped(
        _textToTextExp,
            (Match m) => '${m.group(1)}$_kebab${m.group(2)}',
      )
          .replaceAllMapped(
        _textToNumericExp,
            (Match m) => '${m.group(1)}$_kebab${m.group(2)}',
      )
          .replaceAllMapped(
        _numericToTextExp,
            (Match m) => '${m.group(1)}$_kebab${m.group(2)}',
      )
          .toLowerCase();
    } catch (e, s) {
      return this;
    }
  }

  String toSnakeCase() {
    try {
      return toLowerCamelCase()
          .replaceAllMapped(
        _textToTextExp,
            (Match m) => '${m.group(1)}$_snake${m.group(2)}',
      )
          .replaceAllMapped(
        _textToNumericExp,
            (Match m) => '${m.group(1)}$_snake${m.group(2)}',
      )
          .replaceAllMapped(
        _numericToTextExp,
            (Match m) => '${m.group(1)}$_snake${m.group(2)}',
      )
          .toLowerCase();
    } catch (e, s) {
      return this;
    }
  }

  String toLowerCamelCase() {
    try {
      return split(_snakeOrKebabSplitExt)
          .map((e) => e.capitalize())
          .join()
          .decapitalize();
    } catch (e, s) {
      return this;
    }
  }
}

const _snake = '_';
const _kebab = '-';
final _textToTextExp = RegExp(r'([a-z])([A-Z])');
final _textToNumericExp = RegExp(r'([a-zA-Z])([0-9])');
final _numericToTextExp = RegExp(r'([0-9])([a-zA-Z])');
final _snakeOrKebabSplitExt = RegExp('[_-]');