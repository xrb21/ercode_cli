dropDownSpinner() {
  return """
import 'package:flutter/material.dart';

class DropDownSpinner extends StatelessWidget {
  final String title;
  final String hint;
  final bool required;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;
  final EdgeInsets contentPadding;
  final double padding;
  final double radius;

  const DropDownSpinner({
    Key? key,
    FormFieldSetter<dynamic>? onSaved,
    FormFieldValidator<dynamic>? validator,
    AutovalidateMode autovalidate = AutovalidateMode.onUserInteraction,
    this.title = 'Title',
    this.hint = 'Select one option',
    this.required = false,
    this.errorText = '',
    this.value,
    required this.dataSource,
    this.textField = 'label',
    this.valueField = 'id',
    required this.onChanged,
    this.padding = 16.0,
    this.radius = 8.0,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: padding / 2,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 13.0,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          padding: contentPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                radius,
              ),
            ),
            border: Border.all(
              color: errorText.isNotEmpty
                  ? Colors.red.withAlpha(50)
                  : Colors.black.withAlpha(40),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              isDense: true,
              isExpanded: true,
              hint: Text(
                hint,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14.0,
                ),
              ),
              value: cekKeyExist(value) ? value : null,
              onChanged: (dynamic newValue) {
                onChanged(newValue);
              },
              items: dataSource.map((item) {
                return DropdownMenuItem<dynamic>(
                  value: item[valueField],
                  child: Text(
                    item[textField],
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                );
              }).toList(),
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

  bool cekKeyExist(value) {
    bool result = false;
    for (final d in dataSource) {
      if (d['id'] == value) {
        result = true;
        break;
      }
    }
    return result;
  }
}

""";
}
