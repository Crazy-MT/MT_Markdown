import 'package:code_zero/app/modules/main_tab/main_tab_controller.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShoppingCartEmptyView extends StatelessWidget {
  const ShoppingCartEmptyView({Key? key}) : super(key: key);

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
      width: 375.w,
      height: 812.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 200.w),
          Image.asset(
            Assets.imagesShoppingCartEmptyView,
            width: 100.w,
            height: 100.w,
          ),
          SizedBox(height: 20.w),
          Text(
            '你的购物车空空如也～',
            style: TextStyle(
              color: Color(0xffABAAB9),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 10.w),
          SafeTapWidget(
            onTap: () {
              Get.find<MainTabController>().clickTab(0);
            },
            child: Text(
              '去逛逛',
              style: TextStyle(
                color: AppColors.green,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
