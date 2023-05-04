import 'cli/cli_exception.dart';

extension StringExtension on String {
  String toPascalCase() {
    var words = split(' ');
    var pascalCase = '';
    for (var word in words) {
      pascalCase += word[0].toUpperCase() + word.substring(1);
    }
    return pascalCase;
  }

  String toPascalCaseSpace() {
    var words = split('_');
    var pascalCase = '';
    for (var word in words) {
      pascalCase += word[0].toUpperCase() + word.substring(1);
    }
    return pascalCase;
  }

  String toCamelCase() {
    var words = split(' ');
    var result = '';
    for (var i = 0; i < words.length; i++) {
      if (i == 0) {
        result += words[i].toLowerCase();
      } else {
        result += words[i].substring(0, 1).toUpperCase() +
            words[i].substring(1).toLowerCase();
      }
    }
    return result;
  }

  String toLowerCaseWithUnderscore() {
    return replaceAll(' ', '_').toLowerCase();
  }

  String toUppercaseCaseWithUnderscore() {
    return replaceAll(' ', '_').toUpperCase();
  }

  String toLowerCaseSpace() {
    return replaceAll('_', ' ').replaceAll("-", " ").toLowerCase();
  }

  /// Removes all characters.
  /// ```
  /// var bestPackage = 'GetX'.removeAll('X');
  /// print(bestPackage) // Get;
  /// ```
  String removeAll(String value) {
    var newValue = replaceAll(value, '');
    //this =  newValue;
    return newValue;
  }

  /// Append the content of dart class
  /// ``` dart
  /// var newClassContent = '''abstract class Routes {
  ///  Routes._();
  ///
  ///}
  /// abstract class _Paths {
  ///  _Paths._();
  /// }'''.appendClassContent('Routes', 'static const HOME = _Paths.HOME;' );
  /// print(newClassContent);
  /// ```
  /// abstract class Routes {
  /// Routes._();
  /// static const HOME = _Paths.HOME;
  /// }
  /// abstract class _Paths {
  ///  _Paths._();
  /// }
  ///
  String appendClassContent(String className, String value) {
    var matches =
        RegExp('class $className {.*?(^})', multiLine: true, dotAll: true)
            .allMatches(this);
    if (matches.isEmpty) {
      throw CliException('The class $className is not found in the file $this');
    } else if (matches.length > 1) {
      throw CliException(
          'The class $className is found more than once in the file $this');
    }
    var match = matches.first;
    return insert(match.end - 1, value);
  }

  String insert(int index, String value) {
    var newValue = substring(0, index) + value + substring(index);
    return newValue;
  }
}
