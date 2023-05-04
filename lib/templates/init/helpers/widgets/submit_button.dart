submitButton() {
  return """
import 'package:flutter/material.dart';

import '../constants.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.press,
    this.background = primaryColor,
    this.textColor = Colors.white,
    this.title = "Submit",
    this.rounded = 8,
    this.icon,
  }) : super(key: key);

  final Function() press;

  final Color background;
  final Color textColor;

  final String title;
  final double rounded;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: press,
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(rounded)),
            backgroundColor: background,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            elevation: 0),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

""";
}
