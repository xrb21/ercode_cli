// ignore_for_file: unused_element

import 'package:ercode_cli/ercode.dart';
import 'package:ercode_cli/generate_code.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('');
    print(' ercode_cli');
    print('');
    print('    init \t\t\t to init ercode generator');
    print('    create <folde/generator.json> \t to generate code');
    print('');
    return;
  }

  String command = arguments[0];
  if (command == 'init') {
    initProject();
  } else if (command == 'create') {
    generateCode(arguments);
  }
}
