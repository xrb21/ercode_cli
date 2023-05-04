// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ercode_cli/helpers/extension.dart';
import 'package:ercode_cli/templates/init/helpers/models/response_data.dart';

class ResponseDataGenerate {
  ResponseDataGenerate();

  generate() async {
    final className = 'response_data';
    final filename = className.toLowerCaseWithUnderscore();

    var baseDir = Directory("./lib/models/");
    if (await baseDir.exists()) {
      baseDir.createSync(recursive: true);
    }

    String template = responseData();
    final file = File('${baseDir.path}/$filename.dart');
    if (file.existsSync()) {
      print('File: ${file.path} is exists');
      return;
    }
    File(file.path).createSync(recursive: true);
    file.writeAsStringSync(template);
    print('Create file init: ${file.path} successfully');
  }
}
