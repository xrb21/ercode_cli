textInfo() {
  return """
import 'package:flutter/material.dart';

class TextInfo extends StatelessWidget {
  final String title;
  final String? value;
  const TextInfo({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black45,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          value ?? '',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

""";
}
