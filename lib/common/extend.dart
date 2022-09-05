extension StringExtension on String {
  String fillingPrefixZero(int minLength) {
    if (length >= minLength) {
      return this;
    } else {
      String prefix = "";
      for (var i = 0; i < minLength - length; i++) {
        prefix += "0";
      }
      return "$prefix$this";
    }
  }
}

extension IntExtension on int {
  String formatTime(String formatStr) {
    var time = this;
    if (this < 9999999999) {
      time = this * 1000;
    }
    List<String> _monthList = ["Jan", "Feb", "Mar", "Apr ", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"];
    DateTime _date = DateTime.fromMillisecondsSinceEpoch(time);
    var _year = _date.year.toString();
    var _month = _date.month.toString();
    var _eMonth = _monthList[_date.month - 1];
    var _day = _date.day.toString();
    var _hour = _date.hour.toString();
    var _minute = _date.minute.toString();
    var _second = _date.second.toString();
    formatStr = formatStr
        .replaceAll("YYYY", _year.fillingPrefixZero(4))
        .replaceAll("MM", _month.fillingPrefixZero(2))
        .replaceAll("ee", _eMonth)
        .replaceAll("dd", _day.fillingPrefixZero(2))
        .replaceAll("HH", _hour.fillingPrefixZero(2))
        .replaceAll("mm", _minute.fillingPrefixZero(2))
        .replaceAll("ss", _second.fillingPrefixZero(2));
    return formatStr;
  }

  String toChinese() {
    int index = this;
    List<String> NUMBERS = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", ""];
    if (index > 100) {
      return index.toString();
    }
    StringBuffer stringBuffer = StringBuffer();
    if (index / 10 < 1) {
      return NUMBERS[index];
    }
    int tenUnit = (index / 10).toInt();
    int remainder = index % 10;
    if (remainder == 9) {
      tenUnit++;
      remainder = 10;
    }
    if (tenUnit == 1) {
      stringBuffer
        ..write("十")
        ..write(NUMBERS[remainder]);
      return stringBuffer.toString();
    }
    stringBuffer
      ..write(NUMBERS[tenUnit - 1])
      ..write("十")
      ..write(NUMBERS[remainder]);
    return stringBuffer.toString();
  }
}

get importExtension => null;
