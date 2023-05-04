// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ercode_cli/generator/list/view_item_generator.dart';
import 'package:ercode_cli/helpers/cli/pubspec_util.dart';
import 'package:ercode_cli/helpers/extension.dart';
import 'package:ercode_cli/models/module.dart';
import 'package:ercode_cli/templates/list/view.dart';
import 'package:recase/recase.dart';

class CreateView {
  final Module module;
  final bool force;
  CreateView(this.module, {this.force = false});

  generate() async {
    final className = module.name.pascalCase;
    final filename = module.name.toLowerCaseWithUnderscore();

    var baseDir = Directory("./lib/modules/$filename/views");
    if (await baseDir.exists()) {
      baseDir.createSync(recursive: true);
    }

    String template = viewTemplate();
    template = template.replaceAll('@className', className);
    template = template.replaceAll('@filename', filename);
    template = template.replaceAll('@packageName', PubspecUtil.projectName!);

    final file = File('${baseDir.path}/${filename}_view.dart');
    if (!force && file.existsSync()) {
      print('File view: ${file.path} is exists');
      CreateViewItem(module, force: force).generate();
      return;
    }
    File(file.path).createSync(recursive: true);
    file.writeAsStringSync(template);
    print('File view: ${file.path} created');

    CreateViewItem(module, force: force).generate();
  }
}
