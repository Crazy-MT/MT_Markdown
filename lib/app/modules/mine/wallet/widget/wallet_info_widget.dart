import 'package:code_zero/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletInfoWidget extends StatelessWidget {
  const WalletInfoWidget({Key? key}) : super(key: key);

  //------ pragma mark - properties ------//

  //------ pragma mark - lifecycle ------//

  @override
  Widget build(BuildContext context) {
    return _contentWidget();
  }

  //------ pragma mark - event responses (require: start with '_on') ------//

  //------ pragma mark - private methods (require: start with '_') ------//

  //------ pragma mark - widget (require: start with '_', end with 'Widget') ------//

  Widget _contentWidget() {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xffA8FFDA),
            Color(0xff17E18C),
          ],
        ),
      ),
      child: Container(
        height: 123.w,
        padding: EdgeInsets.fromLTRB(15.w, 10.w, 15.w, 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.white,
              Color(0xff7AFFC7),
            ],
          ),
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('我的资产（元）', style: TextStyle(color: Color(0xff111111), fontSize: 13, fontWeight: FontWeight.w400)),
            SizedBox(height: 24.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('余额（元）', style: TextStyle(color: Color(0xff111111).withOpacity(0.5), fontSize: 13, fontWeight: FontWeight.w400)),
                Text('积分', style: TextStyle(color: Color(0xff111111).withOpacity(0.5), fontSize: 13, fontWeight: FontWeight.w400)),
              ],
            ),
            SizedBox(height: 10.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('453256.88', style: TextStyle(color: Color(0xff111111), fontSize: 18, fontWeight: FontWeight.w500)),
                Text('56788.05', style: TextStyle(color: Color(0xff111111), fontSize: 18, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}