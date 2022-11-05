import 'package:code_zero/app/modules/mine/collection_settings/collection_settings_controller.dart';
import 'package:code_zero/app/modules/mine/collection/widget/alipay_add_widget.dart';
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
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: AlipayAddWidget(),
    );
  }
}
