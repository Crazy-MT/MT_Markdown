import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:code_zero/utils/device_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'shopping_cart_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCartPage extends GetView<ShoppingCartController> {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.page_bg,
      body: Obx(
        () => Stack(
          children: [
            FTStatusPage(
              type: controller.pageStatus.value,
              errorMsg: controller.errorMsg.value,
              builder: (BuildContext context) {
                return CustomScrollView(
                  controller: controller.scrollController,
                  slivers: [
                    _buildSliverAppBar(),
                    _buildOrderContent(context),
                  ],
                );
              },
            ),
            _totalPrice(),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 48.w,
      backgroundColor: Colors.transparent,
      actions: [
        _rightManage(),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text('购物车'),
        background: Image.asset(
          Assets.imagesAppBarBg,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _rightManage() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Text(
          '管理',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderContent(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: 375.w,
        height: 812.w -
            48.w -
            60.w -
            64.w -
            MediaQuery.of(context).padding.bottom -
            MediaQuery.of(context).padding.top,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 15.w),
          itemBuilder: (BuildContext context, int index) {
            return _orderItem();
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10);
          },
          itemCount: 13,
        ),
      ),
    );
  }

  Widget _orderItem() {
    return Container(
      height: 120,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_box_rounded,
            color: Colors.green,
          ),
          SizedBox(width: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl:
                  'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ff70181a20931f7807418b722b4accf9cbd89d0c6c08a-s3JzNf_fw658&refer=http%3A%2F%2Fhbimg.b0.upaiyun.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663056542&t=17f6675c5cb02a4c4c23dd11959387e9',
              width: 90,
              height: 90,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    '1019翡翠玻璃种镶玫瑰金叶子吊坠',
                    style: TextStyle(
                      color: Color(0xff141519),
                      fontSize: 15,
                    ),
                  ),
                ),
                _priceAndCount(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceAndCount() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '￥',
          style: TextStyle(
            color: Color(0xff1BDB8A),
            fontSize: 10,
          ),
        ),
        Text(
          '30000',
          style: TextStyle(
            color: Color(0xff1BDB8A),
            fontSize: 18,
          ),
        ),
        Expanded(child: SizedBox()),
        GestureDetector(
          child: Container(
            alignment: Alignment.center,
            width: 25,
            height: 22,
            color: Colors.transparent,
            child: Text(
              '-',
              style: TextStyle(
                color: Color(0xffD9D9D9),
                fontSize: 18,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.center,
          height: 22,
          decoration: BoxDecoration(
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '1',
            style: TextStyle(
              color: Color(0xff111111),
              fontSize: 15,
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            width: 25,
            height: 22,
            child: Text(
              '+',
              style: TextStyle(
                color: Color(0xff111111),
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _totalPrice() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 60.w,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(width: 25.w),
            Icon(
              Icons.check_box_rounded,
              color: Colors.green,
            ),
            SizedBox(width: 10.w),
            Text(
              '全选',
              style: TextStyle(
                color: Color(0xff757575),
                fontSize: 15,
              ),
            ),
            Expanded(child: SizedBox()),
            Text(
              '总计:',
              style: TextStyle(
                color: Color(0xff757575),
                fontSize: 15,
              ),
            ),
            Text(
              '￥',
              style: TextStyle(
                color: Color(0xff1BDB8A),
                fontSize: 15,
              ),
            ),
            Text(
              '30000',
              style: TextStyle(
                color: Color(0xff1BDB8A),
                fontSize: 18,
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              width: 100,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xff1BDB8A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '结算',
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(width: 15.w),
          ],
        ),
      ),
    );
  }
}
