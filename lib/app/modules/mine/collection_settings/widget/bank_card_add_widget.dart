import 'package:code_zero/app/modules/mine/collection_settings/collection_settings_controller.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          _buildInputItem('姓名'),
          _buildInputItem('手机号'),
          _buildInputItem('短信验证码'),
          _buildInputItem('银行卡号'),
          _buildInputItem('所属银行'),
          Expanded(child: SizedBox()),
          _addButtonWidget(),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 20.w),
        ],
      ),
    );
  }

  Widget _buildInputItem(String title) {
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
      suffixWidget: title == '短信验证码'
          ? SizedBox(
              width: 87.w,
              height: 30.w,
              child: ElevatedButton(
                onPressed: controller.sendSmsCountdown.value <= 0 ? () {} : null,
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                ).copyWith(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.green.withOpacity(controller.sendSmsCountdown.value <= 0 ? 1 : 0.5),
                  ),
                ),
                child: Text(
                  controller.sendSmsCountdown.value <= 0 ? "获取验证码" : "${controller.sendSmsCountdown.value}s",
                  style: TextStyle(
                    color: Colors.white.withOpacity(controller.sendSmsCountdown.value <= 0 ? 1 : 0.5),
                    fontSize: 12.sp,
                  ),
                ),
              ),
            )
          : SizedBox(),
    );
  }

  Widget _addButtonWidget() {
    return SafeTapWidget(
      onTap: () {
        Get.find<CollectionSettingsController>().bankCardDidAdd.value = true;
      },
      child: Container(
        width: double.infinity,
        height: 44.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(22.w),
        ),
        child: Text(
          '确认添加',
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