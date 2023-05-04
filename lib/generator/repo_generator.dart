// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ercode_cli/helpers/extension.dart';
import 'package:ercode_cli/templates/repository.dart';
import 'package:recase/recase.dart';

import '../models/module.dart';

class CreateRepository {
  final Module module;
  final bool force;
  CreateRepository(this.module, {this.force = false});

  generate() async {
    final className = module.name.pascalCase;
    final modelName = module.modelName.pascalCase;
    final filename = module.name.toLowerCaseWithUnderscore();
    final filenameModel = module.modelName.toLowerCaseWithUnderscore();

    var baseDir = Directory("./lib/modules/$filename/data");
    if (await baseDir.exists()) {
      baseDir.createSync(recursive: true);
    }

    String template = repositoryTemplate();
    template = template.replaceAll('@className', className);
    template = template.replaceAll('@modelName', modelName);
    template = template.replaceAll('@filename', filenameModel);
    template = template.replaceAll('@api', module.api);

    final file = File('${baseDir.path}/${filename}_repository.dart');
    if (!force && file.existsSync()) {
      print('File repo ${file.path} is exists');
      return;
    }
    File(file.path).createSync(recursive: true);
    file.writeAsStringSync(template);
    print('File repo ${file.path} created');
  }
}
