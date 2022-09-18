import 'package:code_zero/app/modules/shopping_cart/model/shopping_cart_list_model.dart';
import 'package:code_zero/app/modules/shopping_cart/shopping_cart_api.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/convert_interface.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

//TODO 全选删除逻辑有bug，后面调  复现步骤，全选->管理->删除->找一个商品加入购物车->回到购物车
class ShoppingCartController extends GetxController {
  final pageName = 'ShoppingCart'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  ScrollController scrollController = ScrollController();

  // 所有商品
  RxList<ShoppingCartItem> goodsList = RxList<ShoppingCartItem>();
  // 选中的商品
  RxList<ShoppingCartItem> selectGoodsList = RxList<ShoppingCartItem>();
  // 总价
  RxDouble totalPrice = RxDouble(0);
  // 是否是编辑
  RxBool isManageStatus = false.obs;
  // 是否全选
  RxBool isSelectAll = false.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.loading;
    getGoodsList().then((value) {
      pageStatus.value = FTStatusPageType.success;
    }).catchError((e) {
      errorLog(e.toString());
      pageStatus.value = FTStatusPageType.error;
    });
  }

  Future<void> getGoodsList() async {
    ResultData<ShoppingCartListModel>? _result = await LRequest.instance.request<ShoppingCartListModel>(
      url: ShoppingCartApis.GET_SHOPPING_CART_LIST,
      queryParameters: {
        "userId": userHelper.userInfo.value?.id,
      },
      t: ShoppingCartListModel(),
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("购物车信息获取失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
    );
    if (_result?.value != null) {
      lLog(_result!.value!.toJson().toString());
      goodsList.value = _result.value!.items ?? [];
      return;
    }
  }

  editGoodsItem() {}

  // 更新商品的选中状态
  void updateSelectGoodsItem(ShoppingCartItem goodsModel) {
    if (selectGoodsList.contains(goodsModel)) {
      selectGoodsList.removeWhere((element) => goodsModel == element);
    } else {
      selectGoodsList.add(goodsModel);
    }
    if (selectGoodsList.length == goodsList.length) {
      isSelectAll.value = true;
    } else {
      isSelectAll.value = false;
    }
    updateTotalPrice();
  }

  updateGoodsNumber(ShoppingCartItem goodsModel, int num) async {
    goodsModel.commodityCount = num;
    ResultData<ConvertInterface>? _result = await LRequest.instance.request<ConvertInterface>(
      url: ShoppingCartApis.UPDATE_SHOPPING_CART_NUM,
      data: {
        "commodityCount": num,
        "id": goodsModel.id,
      },
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        // Utils.showToastMsg("更新失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("更新失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
      onSuccess: (_) {
        updateTotalPrice();
      }
    );
  }

  // 更新商品价格
  void updateTotalPrice() {
    totalPrice.value = 0;
    if (selectGoodsList.isEmpty) {
      totalPrice.value = 0;
      return;
    }
    for (ShoppingCartItem item in selectGoodsList) {
      totalPrice.value += (item.commodityPrice ?? 0) * (item.commodityCount ?? 1);
    }
  }

  // 全选
  void selectAllGoods() {
    isSelectAll.value = !isSelectAll.value;
    selectGoodsList.clear();
    if (isSelectAll.value) {
      selectGoodsList.addAll(goodsList);
    }
    updateTotalPrice();
  }

  // 提交订单
  void submit() {
    Get.toNamed(RoutesID.SUBMIT_ORDER_PAGE, arguments: {
      "goods": selectGoodsList,
      "isFromSnap": false
    });
  }

  // 删除商品
  void delete() {
    int num = 0;
    for (ShoppingCartItem item in selectGoodsList) {
      num += (item.commodityCount ?? 0);
    }
    showConfirmDialog(
      onConfirm: () async {
        var _idList = [];
        for (ShoppingCartItem item in selectGoodsList) {
          _idList.add(item.id);
        }
        ResultData<ConvertInterface>? _result = await LRequest.instance.request<ConvertInterface>(
          url: ShoppingCartApis.DELETE_COMMODITY,
          data: {
            "idList": _idList,
          },
          requestType: RequestType.POST,
          errorBack: (errorCode, errorMsg, expMsg) {
            Utils.showToastMsg("移除失败：${errorCode == -1 ? expMsg : errorMsg}");
            errorLog("移除失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
          },
        );
        if (_result?.message == "OK") {
          getGoodsList();
          selectGoodsList.clear();
          updateTotalPrice();
        }
      },
      content: "确认要删除这$num件商品吗",
    );
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}
