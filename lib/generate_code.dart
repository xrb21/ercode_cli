import 'generator/add/controller_add_generator.dart';
import 'generator/add/view_add_generator.dart';
import 'generator/detail/controller_detail_generator.dart';
import 'generator/detail/view_detail_generator.dart';
import 'generator/list/controller_generator.dart';
import 'generator/list/view_generator.dart';
import 'generator/model_generator.dart';
import 'generator/repo_generator.dart';
import 'helpers/rb_helpers.dart';

generateCode(arguments) {
  String fileName = arguments[1];
  bool force = arguments.length > 2 && arguments[2] == 'force';

  readJsonFile(fileName).then((module) {
    if (module.only.isNotEmpty) {
      final only = module.only;

      if (only.contains("model")) {
        CreateModel(module, force: force).generate();
      }
      if (only.contains("repository")) {
        CreateRepository(module, force: force).generate();
      }
      if (only.contains("list")) {
        CreateController(module, force: force).generate();
        CreateView(module, force: force).generate();
      }
      if (only.contains("add")) {
        CreateControllerAdd(module, force: force).generate();
        CreateViewAdd(module, force: force).generate();
      }
      if (only.contains("detail")) {
        CreateControllerDetail(module, force: force).generate();
        CreateViewDetail(module, force: force).generate();
      }
    } else if (module.only.isNotEmpty) {
    } else {
      CreateModel(module, force: force).generate();
      CreateRepository(module, force: force).generate();
      //list
      CreateController(module, force: force).generate();
      CreateView(module, force: force).generate();
      //add
      CreateControllerAdd(module, force: force).generate();
      CreateViewAdd(module, force: force).generate();
      //detail
      CreateControllerDetail(module, force: force).generate();
      CreateViewDetail(module, force: force).generate();
    }
  });
}
