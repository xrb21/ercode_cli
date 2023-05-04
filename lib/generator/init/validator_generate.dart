// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ercode_cli/helpers/extension.dart';

import '../../templates/init/helpers/Validator.dart';

class ValidatorGenerate {
  ValidatorGenerate();

  generate() async {
    final className = 'validator';
    final filename = className.toLowerCaseWithUnderscore();

    var baseDir = Directory("./lib/helpers/");
    if (await baseDir.exists()) {
      baseDir.createSync(recursive: true);
    }

    String template = validator();
    final file = File('${baseDir.path}/$filename.dart');
    if (file.existsSync()) {
      print('File init: ${file.path} is exists');
      return;
    }
    File(file.path).createSync(recursive: true);
    file.writeAsStringSync(template);
    print('Create file init: ${file.path} successfully');
  }
}
