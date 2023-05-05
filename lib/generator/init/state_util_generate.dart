// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ercode_cli/helpers/extension.dart';
import 'package:ercode_cli/templates/init/helpers/state_util.dart';

class StateUtilGenerate {
  StateUtilGenerate();

  generate() async {
    final className = 'state_util';
    final filename = className.toLowerCaseWithUnderscore();

    var baseDir = Directory("./lib/helpers/");
    if (await baseDir.exists()) {
      baseDir.createSync(recursive: true);
    }

    String template = stateUtil();
    final file = File('${baseDir.path}/$filename.dart');
    if (file.existsSync()) {
      //print('File init: ${file.path} is exists');
    }
    File(file.path).createSync(recursive: true);
    file.writeAsStringSync(template);
  }
}
