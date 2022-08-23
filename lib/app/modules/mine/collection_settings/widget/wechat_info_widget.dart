import 'package:code_zero/app/modules/mine/collection_settings/collection_settings_controller.dart';
import 'package:code_zero/app/modules/mine/collection_settings/widget/wechat_add_widget.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class WechatInfoWidget extends StatelessWidget {
  const WechatInfoWidget({Key? key}) : super(key: key);

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
      child: Obx(() => Get.find<CollectionSettingsController>().bankCardDidAdd.value ? _cardInfoWidget() : WechatAddWidget()),
    );
  }

  Widget _cardInfoWidget() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(15.w, 15.w, 15.w, 0),
          height: 84.w,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesWalletWechatBg),
            ),
          ),
          child: Row(
            children: [
              Image.asset(Assets.imagesWalletWechatIcon, width: 40.w, height: 40.w),
              SizedBox(width: 15.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '招商银行',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '6225 8801 467 0045',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 21.w,
          right: 21.w,
          child: SafeTapWidget(
            onTap: () {},
            child: Container(
              width: 66.w,
              height: 24.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: Text(
                '更改收款',
                style: TextStyle(
                  color: Color(0xff111111),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
