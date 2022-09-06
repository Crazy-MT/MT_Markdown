import 'package:code_zero/app/modules/mine/collection_settings/collection_settings_controller.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

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
    CollectionSettingsController controller = Get.find<CollectionSettingsController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Obx(
        (() => Column(
              children: [
                _buildInputItem('姓名', controller.bankNameController),
                _buildInputItem('手机号', controller.bankPhoneController),
                _buildInputItem('短信验证码', controller.bankCodeController),
                _buildInputItem('银行卡号', controller.bankCardNumController),
                _buildInputItem('所属银行', controller.bankBelongController),
                Expanded(child: SizedBox()),
                _addButtonWidget(),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 20.w),
              ],
            )),
      ),
    );
  }

  Widget _buildInputItem(String title, TextEditingController editingController) {
    CollectionSettingsController controller = Get.find<CollectionSettingsController>();
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
      suffixWidget: title == '短信验证码'
          ? SizedBox(
              width: 87.w,
              height: 30.w,
              child: ElevatedButton(
                onPressed: controller.sendBankCodeCountDown.value <= 0
                    ? () {
                        controller.startBankCountDown();
                        controller.getSMS(true);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                ).copyWith(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.green.withOpacity(controller.sendBankCodeCountDown.value <= 0 ? 1 : 0.5),
                  ),
                ),
                child: Text(
                  controller.sendBankCodeCountDown.value <= 0 ? "获取验证码" : "${controller.sendBankCodeCountDown.value}s",
                  style: TextStyle(
                    color: Colors.white.withOpacity(controller.sendBankCodeCountDown.value <= 0 ? 1 : 0.5),
                    fontSize: 12.sp,
                  ),
                ),
              ),
            )
          : SizedBox(),
    );
  }

  Widget _addButtonWidget() {
    CollectionSettingsController controller = Get.find<CollectionSettingsController>();
    bool enable = controller.bankNameController.text.isNotEmpty &&
        controller.bankPhoneController.text.isNotEmpty &&
        controller.bankCodeController.text.isNotEmpty &&
        controller.bankCardNumController.text.isNotEmpty &&
        controller.bankBelongController.text.isNotEmpty;
    return SafeTapWidget(
      onTap: () {
        if (enable && controller.hasNoBankCard) {
          controller.addUserBankCard();
        } else {
          controller.editBankCard(controller.bankcardInfo.value?.id);
        }
      },
      child: Container(
        width: double.infinity,
        height: 44.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: enable ? AppColors.green : Color(0xffBAEED8),
          borderRadius: BorderRadius.circular(22.w),
        ),
        child: Text(
          controller.hasNoBankCard ? "确认添加" : "确认修改",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
