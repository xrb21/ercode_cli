// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:path/path.dart';

import 'log_service.dart';
import 'pubspec_util.dart';
import 'sort.dart';
import 'structure.dart';

/// Create or edit the contents of a file
File writeFile(String path, String content,
    {bool overwrite = false,
    bool skipFormatter = false,
    bool logger = true,
    bool skipRename = false,
    bool useRelativeImport = false}) {
  var newFile = File(Structure.replaceAsExpected(path: path));

  if (!newFile.existsSync() || overwrite) {
    if (!skipFormatter) {
      if (path.endsWith('.dart')) {
        try {
          content = sortImports(
            content,
            renameImport: !skipRename,
            filePath: path,
            useRelative: useRelativeImport,
          );
        } on Exception catch (_) {
          if (newFile.existsSync()) {
            LogService.info("invalid path: ${newFile.path}");
          }
          rethrow;
        }
      }
    }
    if (!skipRename && newFile.path != 'pubspec.yaml') {
      var separatorFileType = PubspecUtil.separatorFileType!;
      if (separatorFileType.isNotEmpty) {
        newFile = newFile.existsSync()
            ? newFile = newFile
                .renameSync(replacePathTypeSeparator(path, separatorFileType))
            : File(replacePathTypeSeparator(path, separatorFileType));
      }
    }

    newFile.createSync(recursive: true);
    newFile.writeAsStringSync(content);
    if (logger) {
      LogService.success(
          "succes crete file ${basename(newFile.path)} ${newFile.path}");
    }
  }
  return newFile;
}

/// Replace the file name separator
String replacePathTypeSeparator(String path, String separator) {
  if (separator.isNotEmpty) {
    var index = path.indexOf(RegExp(r'controller.dart|model.dart|provider.dart|'
        'binding.dart|view.dart|screen.dart|widget.dart|repository.dart'));
    if (index != -1) {
      var chars = path.split('');
      index--;
      chars.removeAt(index);
      if (separator.length > 1) {
        chars.insert(index, separator[0]);
      } else {
        chars.insert(index, separator);
      }
      return chars.join();
    }
  }

  return path;
}
