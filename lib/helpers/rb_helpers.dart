import 'dart:convert';
import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:ercode_cli/helpers/extension.dart';

import '../models/module.dart';

Future<Module> readJsonFile(String filePath) async {
  var input = await File(filePath).readAsString();
  final respon = jsonDecode(input);
  return Module.fromMap(respon);
}

dirModule(String name) {
  final dir = Directory("./lib/module/${name.toLowerCaseWithUnderscore()}/");
  return dir.createSync(recursive: true);
}

String formatterDartFile(String content) {
  var formatter = DartFormatter();
  return formatter.format(content);
}
