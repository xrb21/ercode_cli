viewItemAddTemplate() {
  return """
import 'package:@packageName/helpers/validator.dart';
import 'package:@packageName/helpers/widgets/edit_text.dart';
import 'package:@packageName/helpers/widgets/image_text.dart';
import 'package:@packageName/helpers/widgets/submit_button.dart';
import 'package:flutter/material.dart';

import '../../controllers/@filename_add_controller.dart';

class ItemAdd extends StatelessWidget {
  const ItemAdd({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final @classNameAddController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        @itemInput
        const SizedBox(
          height: 16.0,
        ),
        SubmitButton(
            title: controller.isEdit ? 'Update' : 'Save',
            press: () {
              controller.save();
            })
      ],
    );
  }
}

""";
}
