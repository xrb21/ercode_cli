import 'dart:io';

import 'package:ercode_cli/helpers/cli/pubspec_util.dart';
import 'package:ercode_cli/helpers/extension.dart';
import 'package:ercode_cli/models/module.dart';
import 'package:ercode_cli/templates/add/view_item.dart';
import 'package:recase/recase.dart';

class CreateViewItemAdd {
  final Module module;
  final bool force;
  CreateViewItemAdd(
    this.module, {
    this.force = false,
  });

  generate() async {
    final className = module.name.pascalCase;
    final filename = module.name.toLowerCaseWithUnderscore();
    final varName = module.modelName.camelCase;

    var baseDir = Directory("./lib/modules/$filename/views/widgets/");
    if (await baseDir.exists()) {
      baseDir.createSync(recursive: true);
    }

    String itemAdd = "";
    String itemImportFile = "";

    for (var field in module.fields!) {
      final varTitle = field.name.toPascalCaseSpace();
      final varField = field.name.camelCase;
      final varFieldUpper = field.name.pascalCase;

      if (!field.hidden) {
        switch (field.input) {
          case "image":
            itemImportFile +=
                "import 'package:${PubspecUtil.projectName!}/helpers/widgets/image_text.dart';";

            itemAdd += """
                ImageText(
                    crop: false,
                    image: controller.$varField,
                    imageUrl: controller.$varName != null ? controller.$varName!.$varField : '',
                    onClick: (v) {
                      controller.set$varTitle(v.path);
                    },
                    errorText: controller.$varField,
                  ),\n
                """;
            break;
          default:
            itemAdd += """
            EditText(
              title: "$varTitle",
              controller: controller.txt$varFieldUpper,
              validator: Validator.required,
            ),\n
            """;
        }
      }
    }

    String template = viewItemAddTemplate();
    template = template.replaceAll('@className', className);
    template = template.replaceAll('@varName', varName);
    template = template.replaceAll('@packageName', PubspecUtil.projectName!);
    template = template.replaceAll('@filename', filename);
    template = template.replaceAll('@importFile', itemImportFile);
    template = template.replaceAll('@itemInput', itemAdd);

    final file = File('${baseDir.path}/item_add.dart');
    if (!force && file.existsSync()) {
      print('File view item add : ${file.path} is exists');
      return;
    }
    File(file.path).createSync(recursive: true);
    file.writeAsStringSync(template);
    print('File view item add : ${file.path} created');
  }
}
