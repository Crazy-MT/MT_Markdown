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
}

get importExtension => null;
