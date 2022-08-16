import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShoppingCartPriceWidget extends StatelessWidget {
  const ShoppingCartPriceWidget({Key? key}) : super(key: key);

  //------ pragma mark - properties ------//

  //------ pragma mark - lifecycle ------//

  @override
  Widget build(BuildContext context) {
    return _contentWidget();
  }

  //------ pragma mark - event responses (require: start with '_on') ------//

  //------ pragma mark - private methods (require: start with '_') ------//

  //------ pragma mark - widget (require: start with '_', end with 'Widget') ------//

  Widget _contentWidget() {
    return Container(
      height: 60.w,
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(width: 25.w),
          Image.asset(
            Assets.imagesShoppingCartShoppingCartGoodsUnselected,
            width: 19.w,
            height: 19.w,
          ),
          SizedBox(width: 10.w),
          Text(
            '全选',
            style: TextStyle(
              color: Color(0xff757575),
              fontSize: 15.sp,
            ),
          ),
          Expanded(child: SizedBox()),
          Text(
            '总计:',
            style: TextStyle(
              color: Color(0xff757575),
              fontSize: 15.sp,
            ),
          ),
          Text(
            '￥',
            style: TextStyle(
              color: Color(0xff1BDB8A),
              fontSize: 15.sp,
            ),
          ),
          Text(
            '30000',
            style: TextStyle(
              color: Color(0xff1BDB8A),
              fontSize: 18.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            width: 100.w,
            height: 40.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xff1BDB8A),
              borderRadius: BorderRadius.circular(20.w),
            ),
            child: Text(
              '结算',
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 15.sp,
              ),
            ),
          ),
          SizedBox(width: 15.w),
        ],
      ),
    );
  }
}
