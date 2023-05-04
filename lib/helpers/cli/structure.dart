import 'dart:io';

class Structure {
  static final Map<String, String> _paths = {
    'page': Directory(replaceAsExpected(
                path: '${Directory.current.path} /lib/pages/'))
            .existsSync()
        ? replaceAsExpected(path: 'lib/pages')
        : replaceAsExpected(path: 'lib/app/modules'),
    'widget': replaceAsExpected(path: 'lib/app/widgets/'),
    'model': replaceAsExpected(path: 'lib/app/data/models'),
    'init': replaceAsExpected(path: 'lib/'),
    'route': replaceAsExpected(path: 'lib/routes/'),
    'repository': replaceAsExpected(path: 'lib/app/data/'),
    'provider': replaceAsExpected(path: 'lib/app/data'),
    'controller': replaceAsExpected(path: 'lib/app'),
    'binding': replaceAsExpected(path: 'lib/app'),
    'view': replaceAsExpected(path: 'lib/app/views/'),
    //artekko files
    'screen': replaceAsExpected(path: 'lib/presentation'),
    'controller.binding':
        replaceAsExpected(path: 'lib/infrastructure/navigation/bindings'),
    'navigation': replaceAsExpected(
        path: 'lib/infrastructure/navigation/navigation.dart'),
    //generator files
    'generate_locales': replaceAsExpected(path: 'lib/generated'),
  };

  static String replaceAsExpected({required String path, String? replaceChar}) {
    if (path.contains('\\')) {
      if (Platform.isLinux || Platform.isMacOS) {
        return path.replaceAll('\\', '/');
      } else {
        return path;
      }
    } else if (path.contains('/')) {
      if (Platform.isWindows) {
        return path.replaceAll('/', '\\\\');
      } else {
        return path;
      }
    } else {
      return path;
    }
  }

  static String? getPathWithName(String? firstPath, String secondPath,
      {bool createWithWrappedFolder = false, required String? folderName}) {
    late String betweenPaths;
    if (Platform.isWindows) {
      betweenPaths = '\\\\';
    } else if (Platform.isMacOS || Platform.isLinux) {
      betweenPaths = '/';
    }
    if (betweenPaths.isNotEmpty) {
      if (createWithWrappedFolder) {
        return firstPath! +
            betweenPaths +
            folderName! +
            betweenPaths +
            secondPath;
      } else {
        return firstPath! + betweenPaths + secondPath;
      }
    }
    return null;
  }

  static List<String> safeSplitPath(String path) {
    return path.replaceAll('\\', '/').split('/')
      ..removeWhere((element) => element.isEmpty);
  }

  static String pathToDirImport(String path) {
    var pathSplit = safeSplitPath(path)
      ..removeWhere((element) => element == '.' || element == 'lib');
    return pathSplit.join('/');
  }
}
