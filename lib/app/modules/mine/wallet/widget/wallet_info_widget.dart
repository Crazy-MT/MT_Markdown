import 'package:code_zero/app/modules/mine/wallet/model/walle_model.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletInfoWidget extends StatelessWidget {
  final WalletModel? walletModel;
  const WalletInfoWidget(this.walletModel, {Key? key}) : super(key: key);

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
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(Assets.imagesWalletInfoBg),
          ),
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('我的资产（元）',
                style: TextStyle(
                    color: Color(0xff111111),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400)),
            SizedBox(height: 29.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('余额（元）',
                    style: TextStyle(
                        color: Color(0xff111111).withOpacity(0.5),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400)),
                Row(
                  children: [
                    Image.asset('assets/icons/red_env.png', width: 12.5.w,),
                    SizedBox(width: 5.w,),
                    Text('红包奖励',
                        style: TextStyle(
                            color: Color(0xff111111).withOpacity(0.5),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(walletModel?.balance ?? "",
                    style: TextStyle(
                        color: Color(0xff111111),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500)),
                Text(walletModel?.redEnvelopeAmount ?? "0.00",
                    style: TextStyle(
                        color: Color(0xff111111),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
