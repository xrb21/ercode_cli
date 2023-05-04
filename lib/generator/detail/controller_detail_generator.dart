// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ercode_cli/helpers/cli/pubspec_util.dart';
import 'package:ercode_cli/helpers/extension.dart';
import 'package:ercode_cli/models/module.dart';
import 'package:ercode_cli/templates/detail/controller.dart';
import 'package:recase/recase.dart';

class CreateControllerDetail {
  final Module module;
  final bool force;
  CreateControllerDetail(
    this.module, {
    this.force = false,
  });

  generate() async {
    final className = module.name.pascalCase;
    final modelName = module.modelName.pascalCase;
    final varName = module.modelName.camelCase;
    final filename = module.name.toLowerCaseWithUnderscore();
    final filenameModel = module.modelName.toLowerCaseWithUnderscore();

    var baseDir = Directory("./lib/modules/$filename/controllers/");
    if (await baseDir.exists()) {
      baseDir.createSync(recursive: true);
    }

    String template = controllerDetailTemplate();
    template = template.replaceAll('@className', className);
    template = template.replaceAll('@modelName', modelName);
    template = template.replaceAll('@packageName', PubspecUtil.projectName!);
    template = template.replaceAll('@modelImport', filenameModel);
    template = template.replaceAll('@filename', filename);
    template = template.replaceAll('@varName', varName);

    final file = File('${baseDir.path}/${filename}_detail_controller.dart');
    if (!force && file.existsSync()) {
      print('File controller detail : ${file.path} is exists');
      return;
    }
    File(file.path).createSync(recursive: true);
    file.writeAsStringSync(template);
    print('File controller detail : ${file.path} created');
  }
}
