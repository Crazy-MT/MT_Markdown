import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/shopping_cart/model/goods_model.dart';
import 'package:code_zero/app/modules/shopping_cart/shopping_cart_controller.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'goods_number_widget.dart';

class ShoppingCartGoodsItem extends StatelessWidget {
  final GoodsModel goodsModel;
  const ShoppingCartGoodsItem({Key? key, required this.goodsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShoppingCartController controller = Get.find<ShoppingCartController>();
    return Container(
      height: 120.w,
      padding: EdgeInsets.fromLTRB(0, 15.w, 10.w, 15.w),
      margin: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Row(
        children: [
          SafeTapWidget(
            onTap: () {
              controller.updateSelectGoodsItem(goodsModel);
            },
            child: Obx(
              (() {
                return Container(
                  padding: EdgeInsets.all(10.w),
                  child: Image.asset(
                    controller.selectGoodsList.contains(goodsModel)
                        ? Assets.imagesShoppingCartGoodsSelected
                        : Assets.imagesShoppingCartGoodsUnselected,
                    width: 19.w,
                    height: 19.w,
                  ),
                );
              }),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: goodsModel.url ?? '',
              width: 90.w,
              height: 90.w,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    goodsModel.name ?? '',
                    style: TextStyle(
                      color: Color(0xff141519),
                      fontSize: 15.sp,
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
    ShoppingCartController controller = Get.find<ShoppingCartController>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '￥',
          style: TextStyle(
            color: Color(0xff1BDB8A),
            fontSize: 10.sp,
          ),
        ),
        Text(
          goodsModel.price ?? '',
          style: TextStyle(
            color: Color(0xff1BDB8A),
            fontSize: 18.sp,
          ),
        ),
        Expanded(child: SizedBox()),
        GoodsNumberWidget(
          key: Key((goodsModel.id ?? 0).toString()),
          initNumber: goodsModel.num ?? 1,
          maxNumber: 10000,
          onChange: (num) {
            goodsModel.num = num;
            controller.updateTotalPrice();
          },
        ),
      ],
    );
  }
}
