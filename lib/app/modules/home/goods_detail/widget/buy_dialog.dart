import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/shopping_cart/shopping_cart_api.dart';
import 'package:code_zero/app/modules/shopping_cart/shopping_cart_controller.dart';
import 'package:code_zero/app/modules/shopping_cart/widget/goods_number_widget.dart';
import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/convert_interface.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class _BuyDialog extends StatelessWidget {
  final bool isAddToCart;
  final CommodityItem goods;

  const _BuyDialog({Key? key, required this.isAddToCart, required this.goods}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<BuyDialogController>(
        init: BuyDialogController(
          isAddToCart,
          goods,
        ),
        builder: (controller) {
          return UnconstrainedBox(
            child: Container(
              width: controller.containerWidth.value,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.w),
                ),
              ),
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 268.w,
                      maxHeight: 420.w,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.w),
                                child: CachedNetworkImage(
                                  imageUrl: (goods.thumbnails ?? []).isEmpty ? '' : goods.thumbnails![0],
                                  width: 120.w,
                                  height: 120.w,
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 120.w,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Icon(
                                            Icons.close_outlined,
                                            color: Color(0xFFABAAB9),
                                          ),
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "¥",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: AppColors.green,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "${(goods.currentPrice ?? '0.00').split('.')[0]}",
                                              style: TextStyle(
                                                fontSize: 22.sp,
                                                color: AppColors.green,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ".${(goods.currentPrice ?? '0.00').contains('.') ? (goods.currentPrice ?? '0.00').split('.')[1] : '00'}",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: AppColors.green,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.w,
                                      ),
                                      Text(
                                        "库存：${goods.inventory}件",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Color(0xFFABAAB9),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "数量",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.text_dark,
                                ),
                              ),
                              GoodsNumberWidget(
                                initNumber: 1,
                                maxNumber: goods.inventory ?? 1,
                                onChange: (value) {
                                  controller.commodityCount.value = value;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.w,
                  ),
                  SizedBox(
                    width: 335.w,
                    height: 44.w,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.clickNext();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                      ).copyWith(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                        backgroundColor: MaterialStateProperty.all(
                          AppColors.green,
                        ),
                        elevation: MaterialStateProperty.all(0),
                      ),
                      child: Text(
                        isAddToCart ? "加入购物车" : "立即购买",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class BuyDialogController extends GetxController {
  final bool isAddToCart;
  final CommodityItem goods;
  final containerWidth = 375.w.obs;
  RxInt commodityCount = 1.obs;

  BuyDialogController(
    this.isAddToCart,
    this.goods,
  );
  clickNext() async {
    // Get.back(result: "1");
    if (isAddToCart) {
      ResultData<ConvertInterface>? _result = await LRequest.instance.request<ConvertInterface>(
        url: ShoppingCartApis.ADD_TO_SHOPPING_CART,
        data: {
          "commodityCount": commodityCount.value,
          "commodityId": goods.id,
          "userId": userHelper.userInfo.value?.id,
        },
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("添加失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("添加失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
      );
      if (_result?.message == "OK") {
        Utils.showToastMsg("加入购物车成功");
        Get.find<ShoppingCartController>().getGoodsList();
        Get.back(result: "1");
      }
    } else {}
  }
}

Future<String> showByDialog({bool isAddToCart = false, required CommodityItem goods}) async {
  var result = await showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _BuyDialog(
          isAddToCart: isAddToCart,
          goods: goods,
        );
      });
  return result is String ? result : "";
}
