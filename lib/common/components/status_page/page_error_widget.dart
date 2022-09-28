import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageErrorWidget extends StatelessWidget {
  const PageErrorWidget({Key? key, this.error, this.retryMethod}) : super(key: key);
  final Function? retryMethod;
  final dynamic error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/icons/error.png',width: 100.w, height: 100.w,),
          const SizedBox(
            height: 20,
          ),
          Text('糟糕！好像出错了……', style: TextStyle(
            color: Color(0xffABAAB9),
            fontSize: 14.sp,
          ),),
        ],
      ),
    );
  }
}
