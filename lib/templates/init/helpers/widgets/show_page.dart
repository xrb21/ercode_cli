showPage() {
  return """
import 'package:flutter/material.dart';

import '../api.dart';
import 'error_layout.dart';
import 'loading_layout.dart';

class ShowPage extends StatelessWidget {
  const ShowPage({
    Key? key,
    required this.child,
    required this.status,
    this.error,
    this.press,
    this.empty,
  }) : super(key: key);

  final Widget child;
  final ConnectionStatus status;
  final dynamic error;
  final Function()? press;
  final Widget? empty;

  @override
  Widget build(BuildContext context) {
    if (status == ConnectionStatus.loading) {
      return const LoadingLayout();
    } else if (status == ConnectionStatus.error) {
      if (empty != null && error == 'Not data found') {
        return Center(child: empty!);
      } else {
        return Center(
          child: ErrorLayout.error(
            error,
            enableButton: press != null,
            onPressed: press,
          ),
        );
      }
    } else {
      return child;
    }
  }
}

""";
}
