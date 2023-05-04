// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ercode_cli/helpers/cli/pubspec_util.dart';
import 'package:ercode_cli/helpers/extension.dart';
import 'package:ercode_cli/models/module.dart';
import 'package:ercode_cli/templates/detail/view_item.dart';
import 'package:recase/recase.dart';

class CreateViewItemDetail {
  final Module module;
  final bool force;
  CreateViewItemDetail(
    this.module, {
    this.force = false,
  });

  generate() async {
    final className = module.name.pascalCase;
    final modelName = module.modelName.pascalCase;
    final filename = module.name.toLowerCaseWithUnderscore();
    final filenameModel = module.modelName.toLowerCaseWithUnderscore();
    final varName = module.modelName.camelCase;

    var baseDir = Directory("./lib/modules/$filename/views/widgets/");
    if (await baseDir.exists()) {
      baseDir.createSync(recursive: true);
    }

    String itemList = "";
    String itemImage = "";
    String itemImageImport = "";

    for (var field in module.fields!) {
      if (!field.hidden) {
        final fieldName = field.name.camelCase;
        if (field.input == 'image') {
          itemImageImport =
              "import 'package:cached_network_image/cached_network_image.dart';";

          itemImage += """if ($varName.$fieldName.isNotEmpty)
              CachedNetworkImage(
                imageUrl:$varName.$fieldName,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(
              height: 16.0,
            ),
          """;
        } else {
          itemList += """
          TextInfo(
              title: "${field.name.camelCase}",
              value: $varName.${field.name.camelCase}${(field.type == 'int' || field.type == 'double') ? '.toString()' : ''},
            ),
          """;
        }
      }
    }

    String template = viewItemDetailTemplate();
    template = template.replaceAll('@className', className);
    template = template.replaceAll('@modelName', modelName);
    template = template.replaceAll('@varName', varName);
    template = template.replaceAll('@packageName', PubspecUtil.projectName!);
    template = template.replaceAll('@filename', filenameModel);
    template = template.replaceAll('@importImage', itemImageImport);
    template = template.replaceAll('@itemImage', itemImage);
    template = template.replaceAll('@itemList', itemList);

    final file = File('${baseDir.path}/item_detail.dart');
    if (!force && file.existsSync()) {
      print('File view item detail : ${file.path} is exists');
      return;
    }
    File(file.path).createSync(recursive: true);
    file.writeAsStringSync(template);
    print('File view item detail : ${file.path} created');
  }
}
