pickImage() {
  return """
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';
import '../state_util.dart';
import 'crop_image.dart';

class PickImage extends StatelessWidget {
  const PickImage(
      {Key? key,
      required this.child,
      required this.onTap,
      this.crop = true,
      this.showCamera = true,
      this.showGalery = true})
      : super(key: key);

  final Widget child;
  final Function(File) onTap;
  final bool crop;
  final bool showCamera;
  final bool showGalery;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () {
        dialogPilihUpload(context);
      },
    );
  }

  void dialogPilihUpload(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: StatefulBuilder(builder: (BuildContext context, setState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Pick Image",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black45),
                            ),
                          ),
                          if (showCamera)
                            SizedBox(
                              width: 250,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: primaryColor.withAlpha(30),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                onPressed: () {
                                  getImage(true);
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.camera,
                                        size: 20,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Camera",
                                      style: TextStyle(color: primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (showCamera && showGalery)
                            const SizedBox(
                              height: 4,
                            ),
                          if (showGalery)
                            SizedBox(
                              width: 250,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: secondaryColor),
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                onPressed: () {
                                  getImage(false);
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          Icons.image,
                                          size: 20,
                                          color: secondaryColor,
                                        )),
                                    Text(
                                      "Galery",
                                      style: TextStyle(color: secondaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        });
  }

  Future getImage(bool isKamera) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: isKamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (image != null) {
      if (crop) {
        Get.to(
          CropImage(
            file: File(image.path),
            onTap: (file) {
              onTap(file);
            },
          ),
        );
      } else {
        onTap(File(image.path));
      }
    }
  }
}

""";
}
