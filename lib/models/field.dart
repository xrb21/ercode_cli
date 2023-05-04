// ignore_for_file: public_member_api_docs, sort_constructors_first

class Field {
  final String name;
  final String type;
  final String input;
  final bool hidden;
  final bool showList;
  final bool primary;

  Field({
    required this.name,
    required this.type,
    this.input = 'text',
    this.hidden = false,
    this.showList = false,
    this.primary = false,
  });

  factory Field.fromMap(Map<String, dynamic> map) {
    return Field(
      type: map['type'] ?? 'String',
      name: map['name'] ?? '',
      input: map['input'] ?? 'text',
      hidden: map['hidden'] ?? false,
      showList: map['list'] ?? false,
      primary: map['primary'] ?? false,
    );
  }

  @override
  String toString() => 'Field(type: $type, name: $name, input: $input)';
}
