import 'dart:io';

import 'package:ercode_cli/generator/init/api_generate.dart';
import 'package:ercode_cli/generator/init/constants_generate.dart';
import 'package:ercode_cli/generator/init/rb_helpers_generate.dart';
import 'package:ercode_cli/generator/init/response_data_generate.dart';
import 'package:ercode_cli/generator/init/state_util_generate.dart';
import 'package:ercode_cli/generator/init/widgets/crop_image_generate.dart';
import 'package:ercode_cli/generator/init/widgets/dialog_confirm_generate.dart';
import 'package:ercode_cli/generator/init/widgets/dropdown_spinner_generate.dart';
import 'package:ercode_cli/generator/init/widgets/edit_text_generate.dart';
import 'package:ercode_cli/generator/init/widgets/error_layout_generate.dart';
import 'package:ercode_cli/generator/init/widgets/image_text_generate.dart';
import 'package:ercode_cli/generator/init/widgets/loading_layout_generate.dart';
import 'package:ercode_cli/generator/init/widgets/pick_image_generate.dart';
import 'package:ercode_cli/generator/init/widgets/show_page_generate.dart';
import 'package:ercode_cli/generator/init/widgets/submit_button_generate.dart';
import 'package:ercode_cli/generator/init/widgets/text_info_generate.dart';

import 'generator/init/validator_generate.dart';

initProject() async {
  print('\nstart init project......\n');
  //install deppendecy packages
  final deppendecies = [
    'pub add dio:^4.0.6',
    'pub add pretty_dio_logger:^1.2.0-beta-1',
    'pub add validators:^3.0.0',
    'pub add cached_network_image:^3.2.3',
    'pub add image_picker:^0.8.6+1',
    'pub add image_crop:^0.4.1',
    'pub add flutter_easyloading:^3.0.5',
    'pub add path:^1.8.3'
  ];

  for (final script in deppendecies) {
    final cmd = script.split(" ");
    final result = await Process.run('flutter', cmd);
    if (result.exitCode != 0) {
      //print('Failed to add package: ${result.stderr}');
    } else {
      print('Package $script added successfully!');
    }
  }

  //append stete_utils & flutter loading in main.dart
  appendImportMain();
  appendMainConfig();

  //init file helpers
  StateUtilGenerate().generate();
  ApiGenerate().generate();
  ConstantsGenerate().generate();
  ValidatorGenerate().generate();
  RbHelpersGenerate().generate();
  //widget
  CropImageGenerate().generate();
  DialohConfirmGenerate().generate();
  DropdownSpinnerGenerate().generate();
  EditTextGenerate().generate();
  ErrorLayoutGenerate().generate();
  ImageTextGenerate().generate();
  LoadingLayoutGenerate().generate();
  PickImageGenerate().generate();
  ShowPageGenerate().generate();
  SubmitButtonGenerate().generate();
  TextInfoGenerate().generate();
  //models
  ResponseDataGenerate().generate();

  print('\ninit project finish......\n');
}

void appendImportMain() {
  final filePath = 'lib/main.dart';
  // Read the contents of the file
  final file = File(filePath);
  String contents = file.readAsStringSync();
  if (contents
      .contains('package:flutter_easyloading/flutter_easyloading.dart')) {
    return;
  }

  // Find the index of the last import statement
  final lastImportIndex = contents.lastIndexOf('import ');

  String importFile = """ 
  import 'package:flutter_easyloading/flutter_easyloading.dart';
  import 'helpers/state_util.dart';
  """;
  // Insert the string after the last import statement
  contents =
      contents.replaceRange(lastImportIndex, lastImportIndex, importFile);

  // Write the modified contents back to the file
  file.writeAsStringSync(contents);
}

void appendMainConfig() {
  final file = File('lib/main.dart');
  String originalContent = file.readAsStringSync();

  if (originalContent.contains('navigatorKey: Get.navigatorKey')) {
    return;
  }

  // Locate the position of the last curly brace before the end of MaterialApp method
  final materialAppIndex = originalContent.indexOf('MaterialApp(');

  // Build the desired string to append
  final newString =
      '\n navigatorKey: Get.navigatorKey, \n builder: EasyLoading.init(),';

  originalContent = originalContent.replaceRange(
      materialAppIndex + 12, materialAppIndex + 12, newString);

  // Write the modified content back to the file
  file.writeAsStringSync(originalContent);
}
