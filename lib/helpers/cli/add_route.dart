import 'dart:io';

import 'package:ercode_cli/helpers/extension.dart';
import 'package:recase/recase.dart';

import '../rb_helpers.dart';
import 'create_single_file.dart';
import 'find_file_by_name.dart';
import 'get_app_pages.dart';
import 'log_service.dart';
import 'pubspec_util.dart';
import 'samples/get_route.dart';

/// This command will create the route to the new page
void addRoute(String nameRoute, String bindingDir, String viewDir,
    {String sub = ""}) {
  var routesFile = findFileByName('app_routes.dart');
  //var lines = <String>[];
  var content = '';

  if (routesFile.path.isEmpty) {
    RouteSample().create();
    routesFile = File(RouteSample().path);
    content = routesFile.readAsStringSync();
  } else {
    content = formatterDartFile(routesFile.readAsStringSync());
    //lines = LineSplitter.split(content).toList();
  }
  var pathSplit = viewDir.split('/');

  ///remove file
  pathSplit.removeLast();

  ///remove view folder
  if (PubspecUtil.extraFolder ?? true) {
    pathSplit.removeLast();
  }

  pathSplit.removeWhere((element) => element == 'app' || element == 'modules');

  for (var i = 0; i < pathSplit.length; i++) {
    pathSplit[i] =
        pathSplit[i].snakeCase.snakeCase.toLowerCase().replaceAll('_', '-');
  }
  var route = pathSplit.join('/');
  final routeName = sub.isNotEmpty ? '$nameRoute-$sub' : nameRoute;
  var declareRoute = 'static const ${routeName.snakeCase.toUpperCase()} =';
  var line = "$declareRoute '/$routeName';";

  if (supportChildrenRoutes) {
    line = '$declareRoute ${_pathsToRoute2(nameRoute, sub)};';
    var linePath = "$declareRoute '/$routeName';";
    content = content.appendClassContent('_Paths', linePath);
  }
  content = content.appendClassContent('Routes', line);

  addAppPage(routeName, bindingDir, viewDir);

  LogService.success("success route created $nameRoute");

  writeFile(
    routesFile.path,
    content,
    overwrite: true,
    logger: false,
    useRelativeImport: true,
  );
}

String _pathsToRoute2(String pathSplit, String sub) {
  var sb = StringBuffer();
  sb.write('_Paths.');
  sb.write(pathSplit.snakeCase.toUpperCase());

  if (sub.isNotEmpty) {
    sb.write(' + ');
    sb.write('_Paths.');
    sb.write(pathSplit.snakeCase.toUpperCase());
    sb.write('_');
    sb.write(sub.snakeCase.toUpperCase());
  }

  return sb.toString();
}

bool get supportChildrenRoutes {
  var supportChildren = true;
  if (supportChildren) {
    var routesFile = findFileByName('app_routes.dart');
    if (routesFile.path.isNotEmpty) {
      supportChildren =
          routesFile.readAsLinesSync().contains('abstract class _Paths {') ||
              routesFile.readAsLinesSync().contains('abstract class _Paths {}');
    } else {
      supportChildren = false;
    }
  }
  return supportChildren;
}
