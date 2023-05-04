// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ercode_cli/helpers/extension.dart';
import 'package:ercode_cli/templates/model.dart';
import 'package:recase/recase.dart';

import '../models/module.dart';

class CreateModel {
  final Module module;
  final bool force;
  CreateModel(
    this.module, {
    this.force = false,
  });

  generate() async {
    final className = module.modelName.pascalCase;
    final filenameModel = module.modelName.toLowerCaseWithUnderscore();
    final filename = module.name.toLowerCaseWithUnderscore();

    var baseDir = Directory("./lib/modules/$filename/data");
    if (await baseDir.exists()) {
      baseDir.createSync(recursive: true);
    }

    String variableName = "";
    String constructorVar = "";
    String toMapVar = "";
    String fromMapVar = "";
    String toStringVar = "";

    for (final field in module.fields!) {
      variableName += "final ${field.type} ${field.name.camelCase};\n\t";
      constructorVar += "required this.${field.name.camelCase},\n\t\t";
      toMapVar +=
          "'${field.name.toLowerCaseWithUnderscore()}': ${field.name.camelCase},\n\t\t\t";

      fromMapVar +=
          "${field.name.camelCase}: map['${field.name.toLowerCaseWithUnderscore()}'] ?? ${field.type != 'String' ? 0 : '\'\''},\n\t\t\t";

      toStringVar += "${field.name.camelCase}: \$${field.name.camelCase},";
    }

    variableName += "DateTime? createdAt;\n\t";
    variableName += "DateTime? updatedAt;\n\t";
    variableName += "DateTime? deletedAt;\n\t";

    constructorVar += "this.createdAt,\n\t\t";
    constructorVar += "this.updatedAt,\n\t\t";
    constructorVar += "this.deletedAt,\n\t\t";

    toMapVar += "'created_at': createdAt,\n\t\t\t";
    toMapVar += "'updated_at': updatedAt,\n\t\t\t";
    toMapVar += "'deleted_at': deletedAt,\n\t\t\t";

    fromMapVar += "createdAt : DateTime.tryParse(map['created_at'] ?? ''),";
    fromMapVar += "updatedAt : DateTime.tryParse(map['updated_at'] ?? ''),";
    fromMapVar += "deletedAt : DateTime.tryParse(map['deleted_at'] ?? ''),";

    String template = modelTemplate();
    template = template.replaceAll('@ClassName', className);
    template = template.replaceAll('@variableName', variableName);
    template = template.replaceAll('@constructorVar', constructorVar);
    template = template.replaceAll('@toMapVar', toMapVar);
    template = template.replaceAll('@fromMapVar', fromMapVar);
    template = template.replaceAll('@toStringVar', toStringVar);
    template = template.replaceAll('@filenameModel', filenameModel);
    template = template.replaceAll('@filename', filename);

    final file = File('${baseDir.path}/$filenameModel.dart');
    if (!force && file.existsSync()) {
      print('File model ${file.path} is exists');
      return;
    }
    File(file.path).createSync(recursive: true);
    file.writeAsStringSync(template);
    print('File model ${file.path} created');
  }
}
