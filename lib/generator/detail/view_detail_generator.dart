// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ercode_cli/generator/detail/view_item_detail_generator.dart';
import 'package:ercode_cli/helpers/cli/pubspec_util.dart';
import 'package:ercode_cli/helpers/extension.dart';
import 'package:ercode_cli/models/module.dart';
import 'package:ercode_cli/templates/detail/view.dart';
import 'package:recase/recase.dart';

class CreateViewDetail {
  final Module module;
  final bool force;
  CreateViewDetail(this.module, {this.force = false});

  generate() async {
    final className = module.name.pascalCase;
    final varName = module.modelName.camelCase;
    final filename = module.name.toLowerCaseWithUnderscore();

    var baseDir = Directory("./lib/modules/$filename/views/");
    if (await baseDir.exists()) {
      baseDir.createSync(recursive: true);
    }

    String template = viewDetailTemplate();
    template = template.replaceAll('@className', className);
    template = template.replaceAll('@varName', varName);
    template = template.replaceAll('@filename', filename);

    template = template.replaceAll('@packageName', PubspecUtil.projectName!);

    final file = File('${baseDir.path}/${filename}_detail_view.dart');
    if (!force && file.existsSync()) {
      print('File view detail: ${file.path} is exists');
      CreateViewItemDetail(module, force: force).generate();
      return;
    }
    File(file.path).createSync(recursive: true);
    file.writeAsStringSync(template);
    print('File view detail: ${file.path} created');
    CreateViewItemDetail(module, force: force).generate();
  }
}
