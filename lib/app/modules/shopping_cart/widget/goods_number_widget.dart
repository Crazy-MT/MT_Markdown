import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodsNumberWidget extends StatefulWidget {
  final int initNumber;
  final int minNumber;
  final int maxNumber;
  final ValueChanged? onChange;

  GoodsNumberWidget({
    Key? key,
    required this.initNumber,
    this.minNumber = 1,
    this.maxNumber = 999999,
    this.onChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GoodsNumberState();
}

class _GoodsNumberState extends State<GoodsNumberWidget> {
  late int number;
  @override
  void initState() {
    super.initState();
    number = widget.initNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SafeTapWidget(
          onTap: () {
            subNumber();
          },
          child: Container(
            alignment: Alignment.center,
            width: 25.w,
            height: 22.w,
            color: Colors.transparent,
            child: Text(
              '-',
              style: TextStyle(
                color: number > widget.minNumber ? Color(0xff111111) : Color(0xffD9D9D9),
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          alignment: Alignment.center,
          height: 22.w,
          decoration: BoxDecoration(
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            number.toString(),
            style: TextStyle(
              color: Color(0xff111111),
              fontSize: 15.sp,
            ),
          ),
        ),
        SafeTapWidget(
          onTap: () {
            addNumber();
          },
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            width: 25.w,
            height: 22.w,
            child: Text(
              '+',
              style: TextStyle(
                color: number < widget.maxNumber ? Color(0xff111111) : Color(0xffD9D9D9),
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  addNumber() {
    if (number < widget.maxNumber) {
      setState(() {
        number++;
      });
      widget.onChange?.call(number);
    }
  }

  subNumber() {
    if (number > widget.minNumber) {
      setState(() {
        number--;
      });
      widget.onChange?.call(number);
    }
  }
}
