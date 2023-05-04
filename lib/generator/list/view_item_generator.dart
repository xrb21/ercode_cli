// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ercode_cli/helpers/cli/pubspec_util.dart';
import 'package:ercode_cli/helpers/extension.dart';
import 'package:ercode_cli/models/module.dart';
import 'package:ercode_cli/templates/list/view_item.dart';
import 'package:recase/recase.dart';

class CreateViewItem {
  final Module module;
  final bool force;
  CreateViewItem(
    this.module, {
    this.force = false,
  });

  generate() async {
    final className = module.name.pascalCase;
    final modelName = module.modelName.pascalCase;
    final filename = module.name.toLowerCaseWithUnderscore();
    final filenameModel = module.modelName.toLowerCaseWithUnderscore();
    final varName = module.modelName.camelCase;

    var baseDir = Directory("./lib/modules/$filename/views/widgets");
    if (await baseDir.exists()) {
      baseDir.createSync(recursive: true);
    }

    String itemList = "";
    String itemImage = "";
    String itemImageImport = "";
    int index = 0;
    for (var field in module.fields!) {
      if (field.showList) {
        if (field.input == 'image') {
          itemImageImport =
              "import 'package:${PubspecUtil.projectName!}/app/helpers/components/image_view.dart';";

          itemImage += """if ($varName.${field.name}.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: $varName.${field.name},
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const SizedBox(
                        width: 16,
                        height: 16,
                        child: LoadingLayout(),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image,
                        color: Colors.black26,
                        size: 48,
                      ),
                    ),
                  ),
                ),
          """;
        } else {
          itemList += """
          Text(
                        $varName.${field.name.camelCase}${field.type == 'int' ? '.toString()' : ''},
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
          """;

          if (index < module.fields!.length - 2) {
            itemList += """
            const SizedBox(
                        height: 4.0,
                      ),
            """;
          }
        }

        index++;
      }
    }

    String template = viewItemTemplate();
    template = template.replaceAll('@className', className);
    template = template.replaceAll('@modelName', modelName);
    template = template.replaceAll('@varName', varName);
    template = template.replaceAll('@packageName', PubspecUtil.projectName!);
    template = template.replaceAll('@filenameModel', filenameModel);
    template = template.replaceAll('@filename', filename);
    template = template.replaceAll('@importImage', itemImageImport);
    template = template.replaceAll('@itemListImage', itemImage);
    template = template.replaceAll('@itemList', itemList);

    final file = File('${baseDir.path}/item.dart');
    if (!force && file.existsSync()) {
      print('File view item : ${file.path} is exists');
      return;
    }
    File(file.path).createSync(recursive: true);
    file.writeAsStringSync(template);
    print('File view item : ${file.path} created');
  }
}
