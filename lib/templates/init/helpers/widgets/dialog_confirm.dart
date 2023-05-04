dialogConfirm() {
  return """
import 'package:flutter/material.dart';

import '../constants.dart';
import '../state_util.dart';

dialogConfirm(
    {String? title,
    String? textCancel,
    String? msg,
    Widget? contentWidget,
    String? textConfirm,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    Color? confirmColor = secondaryColor}) {
  AlertDialog alert = AlertDialog(
      title: Text(title ?? "Confirmation"),
      content: contentWidget ?? Text(msg!),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (onCancel != null) onCancel();
            Get.back();
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            textCancel ?? "Cancel",
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            onConfirm();
          },
          style: TextButton.styleFrom(
            backgroundColor: confirmColor!.withAlpha(15),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            textConfirm ?? "Submit",
            style: TextStyle(
              color: confirmColor,
              fontSize: 16,
            ),
          ),
        ),
      ]);

  showDialog(
    context: Get.currentContext,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

""";
}
