import 'package:code_zero/app/modules/mine/collection_settings/collection_settings_controller.dart';
import 'package:code_zero/app/modules/mine/collection_settings/widget/alipay_add_widget.dart';
import 'package:code_zero/app/modules/mine/collection_settings/widget/wechat_add_widget.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class AlipayInfoWidget extends StatelessWidget {
  const AlipayInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionSettingsController controller = Get.find<CollectionSettingsController>();
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Obx(() => (controller.isAliPayEdit.value == false) ? _cardInfoWidget(controller) : AlipayAddWidget()),
    );
  }

  Widget _cardInfoWidget(CollectionSettingsController controller) {
    return SafeTapWidget(
      onTap: () {
        if(Get.arguments != null && (Get.arguments['title'] != null)) {
          Get.back(result: 1);
        }
      },
      child: Column(
        children: [
          Stack(
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
                          controller.aliPayInfo.value?.name ?? "",
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          controller.aliPayInfo.value?.wechatAccount ?? "",
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
                  onTap: () {
                    Get.find<CollectionSettingsController>().isAliPayEdit.value = true;
                  },
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
          ),
          SizedBox(height: 10.w,),
          Text('一个用户只能绑定一个支付宝', style: TextStyle(
              color: Color(0xFFD0A06D)
          ),)
        ],
      ),
    );
  }
}
