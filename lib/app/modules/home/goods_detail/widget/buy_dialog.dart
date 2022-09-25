import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/shopping_cart/model/shopping_cart_list_model.dart';
import 'package:code_zero/app/modules/shopping_cart/shopping_cart_api.dart';
import 'package:code_zero/app/modules/shopping_cart/shopping_cart_controller.dart';
import 'package:code_zero/app/modules/shopping_cart/widget/goods_number_widget.dart';
import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/convert_interface.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class _BuyDialog extends StatelessWidget {
  final bool isAddToCart;
  final CommodityItem goods;
  final bool isFromSnap;

  const _BuyDialog(
      {Key? key,
      required this.isAddToCart,
      required this.goods,
      required this.isFromSnap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<BuyDialogController>(
        init: BuyDialogController(
          isAddToCart,
          goods,
          isFromSnap,
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
                                  imageUrl: (goods.thumbnails ?? []).isEmpty
                                      ? ''
                                      : goods.thumbnails![0],
                                  width: 120.w,
                                  height: 120.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 120.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              text:
                                                  "${(goods.currentPrice ?? '0.00').split('.')[0]}",
                                              style: TextStyle(
                                                fontSize: 22.sp,
                                                color: AppColors.green,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  ".${(goods.currentPrice ?? '0.00').contains('.') ? (goods.currentPrice ?? '0.00').split('.')[1] : '00'}",
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
                        if((controller.goods.inventory ?? 0) == 0) {
                          Utils.showToastMsg('商品库存不够');
                          return;
                        }
                        controller.clickNext();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                      ).copyWith(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0)),
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
  final containerWidth = 374.w.obs;
  RxInt commodityCount = 1.obs;
  final bool isFromSnap;

  BuyDialogController(this.isAddToCart, this.goods, this.isFromSnap);

  clickNext() async {
    // Get.back(result: "1");
    if (isAddToCart) {
      ResultData<ConvertInterface>? _result =
          await LRequest.instance.request<ConvertInterface>(
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
        Get.find<ShoppingCartController>().getGoodsList(isShowLoading: false);
        Get.back(result: "1");
      }
    } else {
      // Get.back(result: "1");
      lLog(
          'MTMTMT BuyDialogController.clickNext ${(double.tryParse(goods.currentPrice ?? "0") ?? 1) * 100} ${commodityCount.value} ${((double.tryParse(goods.currentPrice ?? "0") ?? 1) * 100 * commodityCount.value / 100)} ${0.01 * 2}');
      Get.toNamed(RoutesID.SUBMIT_ORDER_PAGE, arguments: {
        "goods": [
          ShoppingCartItem(
              commodityId: goods.id,
              commodityName: goods.name,
              commodityCount: commodityCount.value,
              commodityPrice: double.tryParse(goods.currentPrice ?? "0") ?? 1 ,
              commodityThumbnail: goods.thumbnails?.firstWhere((element) => element.isNotEmpty, orElse: () => "")
          )
        ].obs,
        "isFromSnap": isFromSnap,
        "totalPrice": ((double.tryParse(goods.currentPrice ?? "0") ?? 1) * 100 * commodityCount.value / 100)
      });
    }
  }
}

Future<String> showByDialog(
    {bool isAddToCart = false,
    required CommodityItem goods,
    bool isFromSnap = false}) async {
  var result = await showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _BuyDialog(
          isAddToCart: isAddToCart,
          goods: goods,
          isFromSnap: isFromSnap,
        );
      });
  return result is String ? result : "";
}
