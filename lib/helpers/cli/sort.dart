import 'dart:convert';

import 'package:ercode_cli/helpers/cli/list.dart';

import '../rb_helpers.dart';
import 'create_single_file.dart';
import 'pubspec_util.dart';

/// Sort imports from a dart file
String sortImports(
  String content, {
  String? packageName,
  bool renameImport = false,
  String filePath = '',
  bool useRelative = false,
}) {
  packageName = packageName ?? PubspecUtil.projectName;
  content = formatterDartFile(content);
  var lines = LineSplitter.split(content).toList();

  var contentLines = <String>[];

  var librarys = <String>[];
  var dartImports = <String>[];
  var flutterImports = <String>[];
  var packageImports = <String>[];
  var projectRelativeImports = <String>[];
  var projectImports = <String>[];
  var exports = <String>[];

  var stringLine = false;
  for (var i = 0; i < lines.length; i++) {
    if (lines[i].startsWith('import ') &&
        !stringLine &&
        lines[i].endsWith(';')) {
      if (lines[i].contains('dart:')) {
        dartImports.add(lines[i]);
      } else if (lines[i].contains('package:flutter/')) {
        flutterImports.add(lines[i]);
      } else if (lines[i].contains('package:$packageName/')) {
        projectImports.add(lines[i]);
      } else if (!lines[i].contains('package:')) {
        projectRelativeImports.add(lines[i]);
      } else if (lines[i].contains('package:')) {
        if (!lines[i].contains('package:flutter/')) {
          packageImports.add(lines[i]);
        }
      }
    } else if (lines[i].startsWith('export ') &&
        lines[i].endsWith(';') &&
        !stringLine) {
      exports.add(lines[i]);
    } else if (lines[i].startsWith('library ') &&
        lines[i].endsWith(';') &&
        !stringLine) {
      librarys.add(lines[i]);
    } else {
      var containsThreeQuotes = lines[i].contains("'''");
      if (containsThreeQuotes) {
        stringLine = !stringLine;
      }
      contentLines.add(lines[i]);
    }
  }

  if (dartImports.isEmpty &&
      flutterImports.isEmpty &&
      packageImports.isEmpty &&
      projectImports.isEmpty &&
      projectRelativeImports.isEmpty &&
      exports.isEmpty) {
    return content;
  }

  if (renameImport) {
    projectImports.replaceAll(_replacePath);

    projectRelativeImports.replaceAll(_replacePath);
  }
  if (filePath.isNotEmpty && useRelative) {
    projectImports
        .replaceAll((element) => replaceToRelativeImport(element, filePath));
    projectRelativeImports.addAll(projectImports);
    projectImports.clear();
  }

  dartImports.sort();
  flutterImports.sort();
  packageImports.sort();
  projectImports.sort();
  projectRelativeImports.sort();
  exports.sort();
  librarys.sort();

  var sortedLines = <String>[];

  sortedLines.addAll([
    ...librarys,
    '',
    ...dartImports,
    '',
    ...flutterImports,
    '',
    ...packageImports,
    '',
    ...projectImports,
    '',
    ...projectRelativeImports,
    '',
    ...exports,
    '',
    ...contentLines
  ]);

  return formatterDartFile(sortedLines.join('\n'));
}

String _replacePath(String str) {
  var separator = PubspecUtil.separatorFileType!;
  return replacePathTypeSeparator(str, separator);
}
