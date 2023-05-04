// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ercode_cli/helpers/cli/pubspec_util.dart';
import 'package:ercode_cli/helpers/extension.dart';
import 'package:ercode_cli/templates/list/controller.dart';
import 'package:recase/recase.dart';

import '../../models/module.dart';

class CreateController {
  final Module module;
  final bool force;
  CreateController(
    this.module, {
    this.force = false,
  });

  generate() async {
    final className = module.name.pascalCase;
    final modelName = module.modelName.pascalCase;
    final filename = module.name.toLowerCaseWithUnderscore();
    final filenameModel = module.modelName.toLowerCaseWithUnderscore();

    var baseDir = Directory("./lib/modules/$filename/controllers");
    if (await baseDir.exists()) {
      baseDir.createSync(recursive: true);
    }

    String template = controllerTemplate();
    template = template.replaceAll('@className', className);
    template = template.replaceAll('@modelName', modelName);
    template = template.replaceAll('@filenameModel', filenameModel);
    template = template.replaceAll('@filename', filename);
    template = template.replaceAll('@packageName', PubspecUtil.projectName!);

    final file = File('${baseDir.path}/${filename}_controller.dart');
    if (!force && file.existsSync()) {
      print('File controller : ${file.path} is exists');
      return;
    }
    File(file.path).createSync(recursive: true);
    file.writeAsStringSync(template);
    print('File controller : ${file.path} created');
  }
}
