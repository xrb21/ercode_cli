loadingLayout() {
  return """
import 'package:flutter/material.dart';

import '../constants.dart';

class LoadingLayout extends StatelessWidget {
  const LoadingLayout({
    Key? key,
    this.width = 24.0,
    this.height = 24.0,
    this.border = 1.8,
    this.color = primaryColor,
  }) : super(key: key);

  final double width;
  final double height;
  final double border;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: CircularProgressIndicator(
          strokeWidth: border,
          valueColor: AlwaysStoppedAnimation(
            color,
          ),
        ),
      ),
    );
  }
}

""";
}
