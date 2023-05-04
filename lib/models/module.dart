import 'field.dart';

class Module {
  final String name;
  final String api;
  final String modelName;
  final List<String> except;
  final List<String> only;
  List<Field>? fields;

  Module({
    required this.name,
    required this.api,
    required this.modelName,
    this.fields,
    required this.except,
    required this.only,
  });

  static Future<Module> fromMap(Map<String, dynamic> map) async {
    final fields = <Field>[];
    final name = map['name'] ?? '';
    final except = <String>[];
    final only = <String>[];
    if (map.containsKey("except")) {
      for (final item in map['except']) {
        except.add(item);
      }
    }

    final module = Module(
      name: name,
      api: map['api'] ?? map['name'],
      modelName: map['modelName'] ?? name,
      except: except,
      only: only,
    );

    for (final map in map['fields']) {
      fields.add(Field.fromMap(map));
    }

    module.fields = fields;
    return module;
  }

  static List<Field> getFields(Map<String, dynamic> map) {
    final fields = <Field>[];

    try {
      for (final map in map['fields']) {
        fields.add(Field.fromMap(map));
      }
    } catch (err) {
      print('error get fields: $err');
    }

    return fields;
  }

  @override
  String toString() => 'Module(name: $name, type: $api, fields: $fields)';
}
