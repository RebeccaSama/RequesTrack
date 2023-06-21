import 'package:flutter/services.dart';

class NumericRangeFormatter extends TextInputFormatter {
  final double min, max;

  NumericRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.text == ""
        ? const TextEditingValue(text: "")
        : int.parse(newValue.text) > max ||
                newValue.text.length > 2 ||
                int.parse(newValue.text) < min
            ? oldValue
            : newValue;
  }
}
