editText() {
  return """
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class EditText extends StatelessWidget {
  EditText({
    Key? key,
    this.title,
    required this.controller,
    this.validator,
    this.padding = 16.0,
    this.press,
    this.enable = true,
    this.isPassword = false,
    this.radius = 6,
    this.maxlines = 1,
    this.keyboard = TextInputType.text,
    this.inputFormat,
    this.prefix,
    this.action = TextInputAction.next,
    this.suffix,
    this.onChange,
    this.hint = '',
    this.alignment = TextAlign.start,
    this.background = Colors.transparent,
  }) : super(key: key);

  final String? title;
  final TextEditingController controller;
  final bool isPassword;
  final FormFieldValidator<String>? validator;
  final double padding;
  final Function()? press;
  final bool enable;
  final double radius;
  final int maxlines;
  final TextInputType keyboard;
  final TextInputFormatter? inputFormat;
  final TextInputAction action;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onChange;
  final _debouncer = Debouncer(milliseconds: 500);
  final String hint;
  final TextAlign alignment;
  final background;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: padding,
        ),
        if (title != null)
          Text(
            title!,
            style: const TextStyle(
              fontSize: 13.0,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        const SizedBox(
          height: 6,
        ),
        TextFormField(
          onTap: press,
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          enabled: enable,
          readOnly: press != null,
          maxLines: maxlines,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: action,
          keyboardType: keyboard,
          inputFormatters:
              inputFormat != null ? <TextInputFormatter>[inputFormat!] : [],
          onChanged: onChange != null
              ? (v) {
                  _debouncer.run(() {
                    if (onChange != null) {
                      onChange!();
                    }
                  });
                }
              : null,
          decoration: InputDecoration(
              hintText: hint,
              isDense: true,
              prefixIcon: prefix != null
                  ? SizedBox(
                      child: Center(
                        widthFactor: 0.0,
                        child: prefix,
                      ),
                    )
                  : null,
              suffixIcon: suffix != null
                  ? SizedBox(
                      child: Center(
                        widthFactor: 0.0,
                        child: suffix,
                      ),
                    )
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withAlpha(40),
                ),
                borderRadius: BorderRadius.circular(radius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor.withAlpha(90),
                ),
                borderRadius: BorderRadius.circular(radius),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.withAlpha(50),
                ),
                borderRadius: BorderRadius.circular(radius),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withAlpha(50),
                ),
                borderRadius: BorderRadius.circular(radius),
              ),
              fillColor: background,
              filled: true),
          textAlign: alignment,
        ),
      ],
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

""";
}
