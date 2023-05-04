imageText() {
  return """
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'pick_image.dart';

class ImageText extends StatelessWidget {
  const ImageText(
      {Key? key,
      this.image = "",
      this.errorText = "",
      this.title = "Logo",
      required this.imageUrl,
      required this.onClick,
      this.crop = true})
      : super(key: key);

  final String image;
  final String title;
  final String imageUrl;
  final Function(File f) onClick;
  final bool crop;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13.0,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        PickImage(
          crop: crop,
          onTap: (File v) {
            onClick(v);
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Stack(
              children: [
                Center(
                  child: (imageUrl.isNotEmpty || image.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: image.isNotEmpty
                              ? Image.file(
                                  File(image),
                                  height:
                                      MediaQuery.of(context).size.width / 2.6,
                                  fit: BoxFit.contain,
                                )
                              : CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  height: MediaQuery.of(context).size.width / 2,
                                  fit: BoxFit.contain,
                                ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(44),
                          child: Text(
                            " + Add Your \$title",
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Colors.black45,
                                    ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: errorText.isNotEmpty ? 5.0 : 0.0),
        Text(
          errorText,
          style: TextStyle(
              color: Colors.redAccent.shade700,
              fontSize: errorText.isNotEmpty ? 12.0 : 0.0),
        ),
      ],
    );
  }
}

""";
}
