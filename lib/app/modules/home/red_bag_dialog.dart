import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class _RedBagDialog extends StatefulWidget {
  final VoidCallback? onConfirm;
  final String? newRedEnvelopeAmount;

  const _RedBagDialog({Key? key, this.onConfirm, this.newRedEnvelopeAmount})
      : super(key: key);

  @override
  State<_RedBagDialog> createState() => _RedBagDialogState();
}

class _RedBagDialogState extends State<_RedBagDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? slideAnimationController;
  Animation<double>? slideAnimation;

  @override
  void initState() {
    super.initState();

    slideAnimationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    // slideAnimation =
    //     Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.ease).animate(slideAnimationController!);
    slideAnimation = CurvedAnimation(
        parent: slideAnimationController!, curve: Curves.easeOutBack);
    slideAnimationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        height: 410.w,
        // color: Colors.red,
        child: Column(
          children: [
            // Expanded(child: SizedBox()),
            Container(
              height: (410 - 76).w,
              // color: Colors.black,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.w),
                      child: Image.asset(
                        "assets/icons/dialog_red_bag_1.png",
                        width: 260.w,
                        height: 288.w,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 95.w,
                    child: SizeTransition(
                      sizeFactor: slideAnimation!,
                      axis: Axis.vertical,
                      axisAlignment: -1,
                      child: Container(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Image.asset(
                              'assets/icons/dialog_red_bag_2.png',
                              width: (427 / 2).w,
                              // height: 433.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 17.w,
                                ),
                                Image.asset(
                                  'assets/icons/dialog_red_bag_4.png',
                                  width: (122).w,
                                  // height: 433.w,
                                ),
                                SizedBox(
                                  height: 14.w,
                                ),
                                Image.asset(
                                  'assets/icons/dialog_red_bag_5.png',
                                  width: (122).w,
                                  // height: 433.w,
                                ),
                                SizedBox(
                                  height: 14.w,
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: widget.newRedEnvelopeAmount,
                                        style: TextStyle(
                                            color: Color(0xffEA2C0D),
                                            fontSize: 60.sp),
                                        children: [
                                      TextSpan(
                                          text: '元',
                                          style: TextStyle(
                                              color: Color(0xffEA2C0D),
                                              fontSize: 18.sp))
                                    ])),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100.w),
                    child: Image.asset(
                      'assets/icons/dialog_red_bag_3.png',
                      width: 260.w,
                      // height: 433.w,
                    ),
                  ),
                  Positioned(
                      bottom: 33.w,
                      child: SafeTapWidget(
                          onTap: () {
                            Get.toNamed(RoutesID.WALLET_PAGE);
                          },
                          child: Image.asset(
                            'assets/icons/check_red.png',
                            width: 224.w,
                          )))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.w),
              width: 150.w,
              height: 36.w,
              child: SafeTapWidget(
                onTap: () {
                  Get.back(result: "1");
                  widget.onConfirm?.call();
                },
                child: Image.asset('assets/icons/close.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showRedBagDialog({
  String? newRedEnvelopeAmount,
  VoidCallback? onConfirm,
}) {
  Get.dialog(
      _RedBagDialog(
        newRedEnvelopeAmount: newRedEnvelopeAmount,
        onConfirm: onConfirm,
      ),
      barrierDismissible: false);
}
