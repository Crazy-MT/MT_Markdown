import 'package:code_zero/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NumberInputFormatter extends TextInputFormatter {
  final int numberLength;
  final int decimalLength;

  NumberInputFormatter({this.numberLength = 0, this.decimalLength = 2});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (numberLength != 0) {
      if (newValue.text.length > numberLength && newValue.text.length > oldValue.text.length) {
        return oldValue;
      }
    }
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }
    if (!newValue.text.isNum) {
      return oldValue;
    }
    if (newValue.text.contains(".") && newValue.text.split(".")[1].length > decimalLength) {
      return oldValue;
    }
    if (double.parse(newValue.text) > 999999999.99) {
      return const TextEditingValue(text: "999999999.99");
    }

    return newValue;
  }
}

class MaxInputFormatter extends TextInputFormatter {
  final int maxInputLength;
  final bool showToast;

  MaxInputFormatter(
    this.maxInputLength, {
    this.showToast = false,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }
    if (newValue.text.length > maxInputLength) {
      if (showToast) Utils.showToastMsg("不可超过$maxInputLength字哦～");
      return oldValue;
    }
    if (newValue.text.contains("   ")) {
      return oldValue;
    }
    return newValue;
  }
}
