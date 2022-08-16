import 'package:code_zero/common/colors.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryEmptyView extends StatelessWidget {
  const CategoryEmptyView({Key? key}) : super(key: key);

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
          SizedBox(height: 75.w),
          Image.asset(
            Assets.imagesShoppingCartEmptyView,
            width: 100.w,
            height: 100.w,
          ),
          SizedBox(height: 20.w),
          Text(
            '暂无商品',
            style: TextStyle(
              color: Color(0xffABAAB9),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
