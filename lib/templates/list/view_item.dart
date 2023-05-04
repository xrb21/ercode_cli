viewItemTemplate() {
  return """
import '../../data/@filenameModel.dart';
import 'package:@packageName/helpers/widgets/loading_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final @modelName @varName;
  final Function()? onDetail;
  const Item(
    this.@varName, {
    Key? key,
    this.onDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onDetail!();
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.black12,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              @itemListImage
              
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      @itemList
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


""";
}
