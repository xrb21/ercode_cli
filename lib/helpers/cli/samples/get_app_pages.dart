import '../pubspec_util.dart';
import 'sample_interface.dart';

/// [Sample] file from [app_pages] file creation.
class AppPagesSample extends Sample {
  String initial;
  AppPagesSample(
      {String path = 'lib/app/routes/app_pages.dart', this.initial = 'HOME'})
      : super(path);
  final import = PubspecUtil.getPackageImport;
  String get _initialRoute =>
      initial.isNotEmpty ? '\nstatic const INITIAL = Routes.$initial;' : '';

  @override
  String get content => '''$import
part 'app_routes.dart';

class AppPages {
   AppPages._();
  $_initialRoute

  static final routes = [
  ];
}
''';
}
