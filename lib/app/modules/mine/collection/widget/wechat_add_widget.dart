import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../collection_controller.dart';
import '../model/user_wechat_model.dart';

class WechatAddWidget extends StatelessWidget {
  const WechatAddWidget({Key? key}) : super(key: key);

  //------ pragma mark - properties ------//

  //------ pragma mark - lifecycle ------//

  @override
  Widget build(BuildContext context) {
    return _contentWidget(context);
  }

  //------ pragma mark - event responses (require: start with '_on') ------//

  //------ pragma mark - private methods (require: start with '_') ------//

  //------ pragma mark - widget (require: start with '_', end with 'Widget') ------//

  Widget _contentWidget(BuildContext context) {
    CollectionController controller = Get.find<CollectionController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Obx(
        (() => controller.wechatInfo.value == null ? Center(child: Text("对方未设置该收款方式")) : SingleChildScrollView(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputItem('微信收款账号', controller.wechatAccountController, controller.wechatInfo.value),
                  _buildInputItem('微信收款姓名', controller.wechatNameController, controller.wechatInfo.value),
                  // Expanded(child: SizedBox()),
                  _addQrcodeWidget(controller.wechatInfo.value)
                ],
              ),
        )),
      ),
    );
  }

  Widget _buildInputItem(String title, TextEditingController editingController, UserWechatModel? wechatModel) {
    return buildInputWithTitle(
      Container(
        padding: EdgeInsets.only(left: 17.w, top: 15.w),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xff121212),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      inputController: editingController,
      enable: false
    );
  }

  Widget _addQrcodeWidget(UserWechatModel? wechatModel) {
    return Container(
      padding: EdgeInsets.only(left: 17.w, top: 15.w),
      child: Column(
        children: [
          Text(
            '微信收款二维码',
            style: TextStyle(
              color: Color(0xff121212),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 7.w),
      (wechatModel?.wechatPaymentCodeUrl?.isNotEmpty ?? false)
          ? CachedNetworkImage(
        imageUrl: wechatModel?.wechatPaymentCodeUrl ?? "",
        width: 135.w,
        height: 200.w,
      )
          : SizedBox.shrink(),

        ],
      ),
    );
  }

}
