import 'package:code_zero/app/modules/mine/collection/model/user_bank_card_model.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../collection_controller.dart';

class BankCardAddWidget extends StatelessWidget {
  const BankCardAddWidget({Key? key}) : super(key: key);

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
        (() => controller.bankcardInfo.value == null
            ? Center(child: Text("对方未设置该收款方式"))
            : Column(
                children: [
                  _buildInputItem('商品金额', controller.priceController, null, needCopy: true),

                  _buildInputItem('姓名', controller.bankNameController,
                      controller.bankcardInfo.value, needCopy: true),
                  // _buildInputItem('手机号', controller.bankPhoneController, controller.bankcardInfo.value),
                  // _buildInputItem('短信验证码', controller.bankCodeController),
                  _buildInputItem('银行卡号', controller.bankCardNumController,
                      controller.bankcardInfo.value, needCopy: true),
                  _buildInputItem('所属银行', controller.bankBelongController,
                      controller.bankcardInfo.value, needCopy: true),

                  Expanded(child: SizedBox()),
                  SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 20.w),
                ],
              )),
      ),
    );
  }

  Widget _buildInputItem(String title, TextEditingController editingController,
      UserBankCardModel? bankCardModel, {bool needCopy = false}) {
    return buildInputWithTitle(
        Container(
          padding: EdgeInsets.only(left: 17.w, top: 15.w),
          child: Text(
            title,
            style: TextStyle(
              color: Color(0xff121212),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        inputController: editingController,
        enable: false,
        suffixWidget: needCopy ? SafeTapWidget(
          onTap: () {
            String text = editingController.text;
            if(editingController.text.contains("￥")) {
              text = text.substring(1);
            }
            Clipboard.setData(ClipboardData(text: text));
            Utils.showToastMsg('复制成功');
          },
          child: Container(
            width: 50.w,
            child: Text('复制', style: TextStyle(color: Colors.red),),
          ),
        ) : SizedBox());
  }
}
