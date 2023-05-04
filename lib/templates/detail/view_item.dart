viewItemDetailTemplate() {
  return """
import 'package:@packageName/helpers/widgets/text_info.dart';
@importImage
import 'package:flutter/material.dart';

import '../../data/@filename.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({
    Key? key,
    required this.@varName,
  }) : super(key: key);

  final @modelName @varName;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            @itemImage
            @itemList
          ],
        ),
      ),
    );
  }
}

""";
}
