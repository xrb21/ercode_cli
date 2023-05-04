viewDetailTemplate() {
  return """
import 'package:@packageName/helpers/widgets/show_page.dart';
import 'package:flutter/material.dart';

import '../controllers/@filename_detail_controller.dart';
import 'widgets/item_detail.dart';

class @classNameDetailView extends StatefulWidget {
  final int id;
  const @classNameDetailView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<@classNameDetailView> createState() => @classNameDetailController();

  Widget build(context, @classNameDetailController controller) {
    controller.view = this;
    controller.id = id;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail @className"),
        actions: [
          IconButton(
            onPressed: () {
              controller.editData();
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.confirmDelete();
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: ShowPage(
        status: controller.connectionStatus,
        error: controller.error,
        press: () {
          controller.getData();
        },
        child: controller.@varName != null
            ? ItemDetail(@varName: controller.@varName!)
            : Container(),
      ),
    );
  }
}


""";
}
