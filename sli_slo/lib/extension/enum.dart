import 'package:sli_slo/extension/string.dart';

extension EnumExt on Enum {
  String get kebabCaseName => name.toKebabCase();

  String get snakeCaseName => name.toSnakeCase();
}