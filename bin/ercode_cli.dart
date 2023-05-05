// ignore_for_file: unused_element

import 'package:ercode_cli/ercode.dart';
import 'package:ercode_cli/generate_code.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    showInfo();
    return;
  }

  String command = arguments[0];
  if (command == 'init') {
    initProject();
  } else if (command == 'generate') {
    generateCode(arguments);
  } else {
    showInfo();
  }
}

void showInfo() {
  print('');
  print(' ercode');
  print('');
  print('   init \t\t\t\t to init ercode generator');
  print('   generate <folder/generator.json> \t to generate code');
  print('');
}
