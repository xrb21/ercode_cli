// ignore_for_file: depend_on_referenced_packages

import 'structure.dart';
import 'package:path/path.dart';

extension ListExtension<T> on List<T> {
  /// Edit all elements of a list.
  /// ```
  /// List<String> users = ['john', 'william', 'david'];
  /// users.replaceAll( (user) => user.toUpperCase());
  /// print(users); // ['JHON', 'WILLIAM', 'DAVID'];
  /// ```
  ///
  List<T> replaceAll(T Function(T element) function) {
    for (var i = 0; i < length; i++) {
      this[i] = function(this[i]);
    }
    return this;
  }
}

String replaceToRelativeImport(String import, String otherFile) {
  var startImport = import.indexOf('/');
  var endImport = import.lastIndexOf("'");
  var pathImport = import.substring(startImport + 1, endImport);
  var pathSafe = Structure.safeSplitPath(otherFile);
  pathSafe.removeWhere((element) => element == 'lib');
  pathSafe.removeLast();
  otherFile = pathSafe.join('/');

  var newImport = relative(pathImport, from: otherFile);
  newImport = Structure.safeSplitPath(newImport).join('/');
  return "import '$newImport${import.substring(endImport)}";
}
