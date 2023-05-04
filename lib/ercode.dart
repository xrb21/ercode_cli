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
  print('init project');

  //install deppendecy packages
  final deppendecies = [
    'pub add dio:^4.0.6',
    'pub add pretty_dio_logger:^1.2.0-beta-1',
    'pub add validators:^3.0.0',
    'pub add cached_network_image:^3.2.3',
    'pub add image_picker:^0.8.6+1',
    'pub add image_crop:^0.4.1',
    'pub add flutter_easyloading:^3.0.5',
  ];

  for (final script in deppendecies) {
    final cmd = script.split(" ");
    final result = await Process.run('flutter', cmd);
    if (result.exitCode != 0) {
      print('Failed to add package: ${result.stderr}');
    } else {
      print('Package $script added successfully!');
    }
  }

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
}
