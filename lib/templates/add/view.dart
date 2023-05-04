viewAddTemplate() {
  return """
import '../controllers/@filename_add_controller.dart';
import 'package:flutter/material.dart';
import 'widgets/item_add.dart';

class @classNameAddView extends StatefulWidget {
  final int? id;
  const @classNameAddView({Key? key, this.id}) : super(key: key);

  @override
  State<@classNameAddView> createState() => @classNameAddController();

  Widget build(context, @classNameAddController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: Text("\${controller.isEdit ? 'Edit' : 'Add'} @className"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ItemAdd(controller: controller),
          ),
        ),
      ),
    );
  }
}

""";
}
