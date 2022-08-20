import 'dart:async';

import 'package:code_zero/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/S.dart';

class TimerTest extends StatefulWidget {
  TimerTest({Key? key, this.seconds}) : super(key: key);
  final int? seconds;

  @override
  createState() => new _TimerTestState();
}

class _TimerTestState extends State<TimerTest> {
  Timer? _timer;
  int seconds = 0;

  // String _content = '00:00:00';

  String hour = "00";
  String minute = "00";
  String second = "00";

  @override
  void initState() {
    super.initState();
    seconds = widget.seconds ?? 0;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    // lLog('MTMTMT _TimerTestState.build ${seconds}');
    constructTime(seconds);

    return Row(
      children: [
        Container(
          width: 22.w,
          height: 22.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xff1BDB8A),
            borderRadius: BorderRadius.circular(5.w),
          ),
          child: Text(
            "$hour",
            style: S.textStyles.timer,
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
          decoration: BoxDecoration(
            color: Color(0xff1BDB8A),
            borderRadius: BorderRadius.circular(5.w),
          ),
          child: Text(
            "$minute",
            style: S.textStyles.timer,
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
          decoration: BoxDecoration(
            color: Color(0xff1BDB8A),
            borderRadius: BorderRadius.circular(5.w),
          ),
          child: Text(
            "$second",
            style: S.textStyles.timer,
          ),
        ),
      ],
    );
  }

  constructTime(int seconds) {
    // int minute = seconds % 3600 ~/ 60;
    // int second = seconds % 60;
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
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }
}
