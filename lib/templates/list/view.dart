viewTemplate() {
  return """
import 'package:flutter/material.dart';
import 'package:@packageName/helpers/widgets/show_page.dart';
import '../controllers/@filename_controller.dart';
import 'widgets/item.dart';

class @classNameView extends StatefulWidget {
  const @classNameView({Key? key}) : super(key: key);

  @override
  State<@classNameView> createState() => @classNameController();

  Widget build(context, @classNameController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("@className"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          controller.addData();
        },
      ),
      body: ShowPage(
        status: controller.connectionStatus,
        error: controller.error,
        press: () {
          controller.getData();
        },
        child: ListView.builder(
          itemCount: controller.data.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final item = controller.data[index];
            return Item(
              item,
              onDetail: () {
                controller.toDetail(item.id);
              },
            );
          },
        ),
      ),
    );
  }
}


""";
}
