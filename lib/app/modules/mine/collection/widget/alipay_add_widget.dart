import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/mine/collection/collection_controller.dart';
import 'package:code_zero/app/modules/mine/collection/model/user_alipay_model.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AlipayAddWidget extends StatelessWidget {
  const AlipayAddWidget({Key? key}) : super(key: key);

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
        (() => controller.alipayInfo.value == null
            ? Center(child: Text("对方未设置该收款方式"))
            : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputItem('商品金额', controller.priceController, null,
                      needCopy: true),
                  _buildInputItem(
                      '支付宝收款账号',
                      controller.alipayAccountController,
                      controller.alipayInfo.value),
                  _buildInputItem('支付宝收款姓名', controller.alipayNameController,
                      controller.alipayInfo.value),
                  // Expanded(child: SizedBox()),
                  _addQrcodeWidget(controller.alipayInfo.value)
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildInputItem(String title, TextEditingController editingController,
      UserAlipayModel? wechatModel,
      {bool needCopy = false}) {
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
        enable: false,
        suffixWidget: needCopy
            ? SafeTapWidget(
          onTap: () {
            String text = editingController.text;
            if (editingController.text.contains("￥")) {
              text = text.substring(1);
            }
            Clipboard.setData(ClipboardData(text: text));
            Utils.showToastMsg('复制成功');
          },
          child: Container(
            width: 50.w,
            child: Text(
              '复制',
              style: TextStyle(color: Colors.red),
            ),
          ),
        )
            : SizedBox());
  }

  Widget _addQrcodeWidget(UserAlipayModel? wechatModel) {
    return Container(
      padding: EdgeInsets.only(top: 15.w),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start
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
              ? SafeTapWidget(
            onTap: () {
              Get.toNamed(RoutesID.PHOTO_VIEW_PAGE, arguments: {
                "url": wechatModel?.wechatPaymentCodeUrl ?? ""
              });
            },
            child: CachedNetworkImage(
              imageUrl: wechatModel?.wechatPaymentCodeUrl ?? "",
              width: 135.w,
              height: 200.w,
            ),
          )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
