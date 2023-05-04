rbHelpers() {
  return """
import 'package:flutter/material.dart';

log(dynamic val) {
  //print("log_rb: \$val");
}

trace(e, track) {
  return "\$e\\n\${track.toString().split("\\n")[0]}";
}

dialog(BuildContext context, String msg) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Informasi",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                msg,
                style: const TextStyle(color: Colors.black45, fontSize: 14),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          TextButton(
            child: const Text("Tutup"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Color colorString(String color) {
  color = color.replaceAll("#", "");
  if (color.length == 6) {
    return Color(int.parse("0xFF\$color"));
  } else if (color.length == 8) {
    return Color(int.parse("0x\$color"));
  } else {
    return Colors.transparent;
  }
}

""";
}
