import 'package:code_zero/app/modules/shopping_cart/model/goods_model.dart';
import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class ShoppingCartController extends GetxController {
  final pageName = 'ShoppingCart'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  ScrollController scrollController = ScrollController();

  // 所有商品
  RxList<GoodsModel> goodsList = RxList<GoodsModel>();
  // 选中的商品
  RxList<GoodsModel> selectGoodsList = RxList<GoodsModel>();
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
    fetchCartData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  void fetchCartData() {
    GoodsModel model = GoodsModel();
    model.name = '1019翡翠玻璃种镶玫瑰金叶子吊坠';
    model.price = '30000';
    model.url =
        'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ff70181a20931f7807418b722b4accf9cbd89d0c6c08a-s3JzNf_fw658&refer=http%3A%2F%2Fhbimg.b0.upaiyun.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663056542&t=17f6675c5cb02a4c4c23dd11959387e9';
    model.num = 2;
    goodsList.add(model);
    GoodsModel model2 = GoodsModel();
    model2.name = '1020翡翠玻璃种镶玫瑰金叶子吊坠';
    model2.price = '10000';
    model2.url =
        'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ff70181a20931f7807418b722b4accf9cbd89d0c6c08a-s3JzNf_fw658&refer=http%3A%2F%2Fhbimg.b0.upaiyun.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663056542&t=17f6675c5cb02a4c4c23dd11959387e9';
    model2.num = 1;
    goodsList.add(model2);
  }

  // 更新商品的选中状态
  void updateSelectGoodsItem(GoodsModel goodsModel) {
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

  // 更新商品价格
  void updateTotalPrice() {
    totalPrice.value = 0;
    if (selectGoodsList.isEmpty) {
      totalPrice.value = 0;
      return;
    }
    for (GoodsModel item in selectGoodsList) {
      totalPrice.value += double.parse(item.price ?? '0') * (item.num ?? 1);
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
  void submit() {}

  // 删除商品
  void delete() {
    int num = 0;
    for (GoodsModel item in selectGoodsList) {
      num += (item.num ?? 0);
    }
    showConfirmDialog(
      onConfirm: () async {
        for (GoodsModel item in selectGoodsList) {
          goodsList.remove(item);
        }
        selectGoodsList.clear();
        updateTotalPrice();
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
