// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ercode_cli/helpers/cli/pubspec_util.dart';
import 'package:ercode_cli/helpers/extension.dart';
import 'package:ercode_cli/models/module.dart';
import 'package:ercode_cli/templates/add/controller.dart';
import 'package:recase/recase.dart';

class CreateControllerAdd {
  final Module module;
  final bool force;
  CreateControllerAdd(this.module, {this.force = false});

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

    String importFile = "";
    String varInput = "";
    String varInputImage = "";
    String varFilter = "";

    String varParameters = "";
    String varParametersImage = "";
    String varSetText = "";

    for (final field in module.fields!) {
      if (field.primary) {
        continue;
      }

      final varField = field.name.camelCase;
      final varFieldUpper = field.name.pascalCase;
      final varFieldLowerSpace = field.name.toLowerCaseSpace();
      final varFieldInput = field.name.toLowerCaseWithUnderscore();

      switch (field.input) {
        case "image":
          importFile += "import 'dart:io';";
          importFile += "\nimport 'package:path/path.dart';";

          varInput += "var $varField = '';\n";
          varInput += "var ${varField}Error = '';\n";

          varInputImage += """
          set$varFieldUpper(String v) {
            setState(() {
              $varField = v;
            });
          }
          """;

          varFilter += """
          if ($varField.isEmpty && !isEdit) {
            setState(() {
              $varField = 'Please pickup a $varFieldLowerSpace';
            });

            if (isValid) isValid = false;
          } else {
            setState(() {
              $varField = '';
            });
          }
          """;

          varParametersImage += """
            if ($varField.isNotEmpty) {
              File file = File($varField);
              params['$varFieldInput'] = await dio.MultipartFile.fromFile(
                file.path,
                filename: basename(file.path),
              );
            }
          """;

          break;
        default:
          varInput += "final txt$varFieldUpper = TextEditingController();\n";
          varParameters += "'$varFieldInput': txt$varFieldUpper.text,\n";
          varSetText +=
              "txt$varFieldUpper.text = $varName!.$varField${field.type == 'int' ? '.toString()' : ''};\n";
      }
    }

    String template = controllerAddTemplate();

    template = template.replaceAll('@importFile', importFile);
    template = template.replaceAll('@className', className);
    template = template.replaceAll('@modelName', modelName);
    template = template.replaceAll('@varName', varName);
    template = template.replaceAll('@packageName', PubspecUtil.projectName!);
    template = template.replaceAll('@filenameModel', filenameModel);
    template = template.replaceAll('@filename', filename);

    template = template.replaceAll('@varInput', varInput);
    template = template.replaceAll('@varImageInput', varInputImage);
    template = template.replaceAll('@varFilter', varFilter);
    template = template.replaceAll('@varParameters', varParameters);
    template = template.replaceAll('@varUploadFile', varParametersImage);
    template = template.replaceAll('@varSetText', varSetText);
    template = template.replaceAll('@varApi', module.api);

    final file = File('${baseDir.path}/${filename}_add_controller.dart');
    if (!force && file.existsSync()) {
      print('File controller add : ${file.path} is exists');
      return;
    }
    File(file.path).createSync(recursive: true);
    file.writeAsStringSync(template);
    print('File controller add : ${file.path} created');
  }
}
