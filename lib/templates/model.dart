modelTemplate() {
  return """
import 'dart:convert';

class @ClassName {
  @variableName

  @ClassName({
    @constructorVar
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      @toMapVar
    };
  }

  factory @ClassName.fromMap(Map<String, dynamic> map) {
    return @ClassName(
      @fromMapVar
    );
  }

  String toJson() => json.encode(toMap());

  factory @ClassName.fromJson(String source) =>
      @ClassName.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '@ClassName(@toStringVar)';
  }
}

""";
}
