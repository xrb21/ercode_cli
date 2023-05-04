errorLayout() {
  return """
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class ErrorLayout extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final String? title;
  final String? description;
  final bool enableButton;

  const ErrorLayout(
      {Key? key,
      this.onPressed,
      this.icon,
      this.title,
      this.description,
      this.enableButton = true})
      : super(key: key);

  factory ErrorLayout.empty(String description,
      {VoidCallback? onPressed, bool enableButton = false}) {
    return ErrorLayout(
      onPressed: onPressed,
      icon: Icons.inbox,
      title: "Empty",
      description: description,
      enableButton: enableButton,
    );
  }

  factory ErrorLayout.error(dynamic error,
      {VoidCallback? onPressed,
      bool enableButton = true,
      String? info,
      Icon? icon,
      showIcon = true}) {
    String title;
    String desc;
    IconData icon;
    //print(error);
    if (error is SocketException || error is TimeoutException) {
      title = "No internet";
      desc = "Desc no internet";
      icon = Icons.signal_wifi_off;
    } else if (error is NullThrownError) {
      title = "Data not found";
      desc = "";
      icon = Icons.mood_bad;
      enableButton = false;
    } else if (error is String) {
      title = "Information";
      desc = error;
      icon = Icons.info;
    } else {
      var err = error.toString().split(":");
      desc = err.length > 1 ? err[1] : error.toString();
      title = "Information";
      icon = Icons.info;
    }

    if (info != null) {
      desc = info;
    }

    return ErrorLayout(
      onPressed: onPressed,
      icon: icon,
      title: title,
      description: desc,
      enableButton: enableButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              icon != null
                  ? Icon(
                      icon,
                      size: 48.0,
                      color: const Color(0xff849dfe),
                    )
                  : Container(),
              const SizedBox(height: 8.0),
              Text(title!,
                  style: const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0)),
              const SizedBox(height: 8.0),
              Text(
                description!,
                style: TextStyle(color: Colors.blueGrey[500], fontSize: 13.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              _buildRetryButton()
            ],
          )),
    );
  }

  Widget _buildRetryButton() {
    if (enableButton) {
      return TextButton(
        onPressed: onPressed,
        child: const Text(
          "Refresh",
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return Container();
  }
}

""";
}
