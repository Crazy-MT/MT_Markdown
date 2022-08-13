import 'package:dart_style/dart_style.dart';

/// Format a dart file
String formatterDartFile(String content) {
  var formatter = DartFormatter(pageWidth: 200);
  return formatter.format(content);
}

String insertUnderscoresToFileName(String name) {
  String result = name[0];
  for (var i = 1; i < name.length; i++) {
    if (name.codeUnitAt(i) >= 65 && name.codeUnitAt(i) <= 90 && name.codeUnitAt(i - 1) >= 97 && name.codeUnitAt(i - 1) <= 122) {
      result += "_";
    } else if (i != name.length - 1 &&
        name.codeUnitAt(i) >= 65 &&
        name.codeUnitAt(i) <= 90 &&
        name.codeUnitAt(i + 1) >= 97 &&
        name.codeUnitAt(i + 1) <= 122 &&
        name.codeUnitAt(i - 1) >= 65 &&
        name.codeUnitAt(i - 1) <= 90) {
      result += "_";
    }
    result += name[i];
  }
  return result;
}
