import 'package:code_zero/app/modules/mine/collection_settings/collection_settings_controller.dart';
import 'package:code_zero/app/modules/mine/collection_settings/widget/bank_card_add_widget.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BankCardListWidget extends StatelessWidget {
  const BankCardListWidget({Key? key}) : super(key: key);

  //------ pragma mark - properties ------//

  //------ pragma mark - lifecycle ------//

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Obx(() => Get.find<CollectionSettingsController>().bankCardDidAdd.value ? _cardInfoWidget() : BankCardAddWidget()),
    );
  }

  Widget _cardInfoWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(15.w, 15.w, 15.w, 0),
      height: 84.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imagesBankCardBg),
        ),
      ),
      child: Row(
        children: [
          Image.asset(Assets.imagesBankCardIcon, width: 40.w, height: 40.w),
          SizedBox(width: 15.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '6225 8801 467 0045',
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '李雪',
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
