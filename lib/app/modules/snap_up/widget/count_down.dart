import 'dart:async';

import 'package:code_zero/utils/log_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/S.dart' as Res;

class CountDown extends StatefulWidget {
  CountDown({Key? key, this.seconds, this.start, this.changed}) : super(key: key);
  final int? seconds;
  final int? start;
  final ValueChanged<bool>? changed;

  @override
  createState() => new _CountDownState();
}

class _CountDownState extends State<CountDown> with WidgetsBindingObserver{
  Timer? _timer;
  int seconds = 0;
  int start = 0;

  // String _content = '00:00:00';

  String hour = "00";
  String minute = "00";
  String second = "00";

  @override
  void initState() {
    super.initState();
    seconds = widget.seconds ?? 0;
    start = widget.start ?? 0;
    startTimer();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    lLog('MTMTMT _CountDownState.didChangeAppLifecycleState ${state.toString()} ');
  }

  @override
  Widget build(BuildContext context) {
    String now = formatDate(DateTime.now(), [HH, ':', nn, ':', ss]);
    var nowArr = now.split(":");
    int nowHour = (int.parse(nowArr[0]));
    int nowMinute = int.parse(nowArr[1]);
    int nowSecond = int.parse(nowArr[2]);
    int nowTime = nowHour * 60 * 60 + nowMinute * 60 + nowSecond; // 当前天分钟数
    lLog('MTMTMT _CountDownState.build ${start}  ${nowTime} ');
    // lLog('MTMTMT _CountDownState.build ${start - nowTime} ');
    constructTime(start - nowTime);
    return Row(
      children: [
        Container(
          width: 22.w,
          height: 22.w,
          alignment: Alignment.center,
          /*decoration: BoxDecoration(
            color: Color(0xff1BDB8A),
            borderRadius: BorderRadius.circular(5.w),
          ),*/
          child: Text(
            "$hour",
            style: Res.S.textStyles.timer,
          ),
        ),
        Text(
          ":",
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
        Container(
          width: 22.w,
          height: 22.w,
          alignment: Alignment.center,
          /*decoration: BoxDecoration(
            color: Color(0xff1BDB8A),
            borderRadius: BorderRadius.circular(5.w),
          ),*/
          child: Text(
            "$minute",
            style: Res.S.textStyles.timer,
          ),
        ),
        Text(
          ":",
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
        Container(
          width: 22.w,
          height: 22.w,
          alignment: Alignment.center,
         /* decoration: BoxDecoration(
            color: Color(0xff1BDB8A),
            borderRadius: BorderRadius.circular(5.w),
          ),*/
          child: Text(
            "$second",
            style: Res.S.textStyles.timer,
          ),
        ),
      ],
    );
  }

  constructTime(int seconds) {
    hour = formatTime(seconds ~/ 3600);
    minute = formatTime(seconds % 3600 ~/ 60);
    second = formatTime(seconds % 60);
  }

  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  void startTimer() {
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      setState(() {
        seconds--;
      });
      if (seconds == 0) {
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    widget.changed?.call(true);
  }

  @override
  void dispose() {
    cancelTimer();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}
