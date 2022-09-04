import 'package:code_zero/app/modules/home/submit_order/model/data_model.dart';
import 'package:code_zero/app/modules/mine/address_manage/address_apis.dart';
import 'package:code_zero/app/modules/mine/model/order_list_model.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/system_setting.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/convert_interface.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../common/colors.dart';
import '../../../../network/upload_util.dart';
import '../address_manage/model/create_address_model.dart';
import '../model/order_tab_info.dart';

class BuyerOrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final pageName = 'Order'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  final List<OrderTabInfo> myTabs = <OrderTabInfo>[
    // 买家，就是 0 -- 待付款、2 -- 已付款、3 -- 待上架

    OrderTabInfo(
        Tab(text: '我的仓库'), -1, RefreshController(), 1, RxList<OrderItem>()),
    OrderTabInfo(
        Tab(text: '待付款'), 0, RefreshController(), 1, RxList<OrderItem>()),
    OrderTabInfo(
        Tab(text: '已付款'), 1, RefreshController(), 1, RxList<OrderItem>()),
    OrderTabInfo(
        Tab(text: '待上架'), 3, RefreshController(), 1, RxList<OrderItem>()),
  ];

  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: myTabs.length);
    tabController?.index = Get.arguments['index'] as int;
    tabController?.addListener(() {
      ///避免addListener调用2次
      if (tabController?.index == tabController?.animation?.value) {
        // print("点击了下标为${tabController?.index}的tab");
      }
    });
    initAllData();
  }

  initAllData() async {
    pageStatus.value = FTStatusPageType.loading;
    await Future.forEach<OrderTabInfo>(myTabs, (element) async {
      await getOrder(true, element);
    }).catchError((e) {
      errorLog(e);
      pageStatus.value = FTStatusPageType.success;
    });
    pageStatus.value = FTStatusPageType.success;
  }

  getOrder(bool isRefresh, OrderTabInfo tabInfo) async {
    int prePageIndex = tabInfo.currentPage;
    if (isRefresh) {
      tabInfo.currentPage = 1;
    } else {
      tabInfo.currentPage++;
    }
    ResultData<OrderListModel>? _result = await LRequest.instance.request<
        OrderListModel>(
      url: SnapApis.ORDER_LIST,
      queryParameters: {
        "to-user-id": userHelper.userInfo.value?.id,
        "page": tabInfo.currentPage,
        "size": 10,
        "trade-state": tabInfo.tradeState,
      },
      t: OrderListModel(),
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("订单列表获取失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        isRefresh ? tabInfo.currentPage = prePageIndex : tabInfo.currentPage--;
      },
    );
    if (_result?.value != null) {
      isRefresh
          ? tabInfo.orderList.value = _result?.value?.items ?? []
          : tabInfo.orderList.addAll(_result?.value?.items ?? []);
    }

    if (isRefresh) {
      tabInfo.refreshController.refreshCompleted();
      tabInfo.refreshController.loadComplete();
    } else {
      if ((_result?.value?.items ?? []).isEmpty) {
        tabInfo.refreshController.loadNoData();
      } else {
        tabInfo.refreshController.loadComplete();
      }
    }
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }

  Future<void> cancelOrder(int id) async {
    ResultData<DataModel>? _result = await LRequest.instance.request<DataModel>(
        url: SnapApis.CANCEL_ORDER,
        data: {
          "id": id
        },
        t: DataModel(),
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("取消订单失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("取消订单失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (rest) {
          // print('MTMTMT BuyerOrderController.cancelOrder ${rest} ');
          Utils.showToastMsg("取消订单成功");
          initAllData();
        }
    );
  }

  Future<void> confirmOrder(int id) async {
    ResultData<DataModel>? _result = await LRequest.instance.request<DataModel>(
        url: SnapApis.CONFIRM_ORDER,
        data: {
          "id": id
        },
        t: DataModel(),
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("确认支付失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("确认支付失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (rest) {
          // print('MTMTMT BuyerOrderController.cancelOrder ${rest} ');
          Utils.showToastMsg("确认支付成功");
          initAllData();
        }
    );
  }

  // 选择图片并上传
  Future<void> chooseAndUploadImage(id) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image?.path ?? "",
      aspectRatioPresets: [
        // CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        // CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: '裁剪图片',
            toolbarColor: AppColors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        IOSUiSettings(
          title: '裁剪图片',
        ),
      ],
    );
    String tradeUrl = await uploadFile(croppedFile?.path);

    ResultData<DataModel>? _result = await LRequest.instance.request<DataModel>(
        url: SnapApis.UPDATE_TRADE_URL_ORDER,
        data: {
          "id": id,
          "tradeUrl": tradeUrl
        },
        t: DataModel(),
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("上传支付凭证失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("上传支付凭证失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (rest) {
          // print('MTMTMT BuyerOrderController.cancelOrder ${rest} ');
          Utils.showToastMsg("上传支付凭证成功");
          initAllData();
        }
    );
  }

  void tihuo(id) {
    showConfirmDialog(
      onConfirm: () async {
        ///提货
        ResultData<DataModel>? _result = await LRequest.instance.request<
            DataModel>(
            url: SnapApis.PICK_UP_COMMODITY,
            data: {
              "id": id,
            },
            t: DataModel(),
            requestType: RequestType.POST,
            errorBack: (errorCode, errorMsg, expMsg) {
              Utils.showToastMsg("提货失败：${errorCode == -1 ? expMsg : errorMsg}");
              errorLog("提货失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
            },
            onSuccess: (rest) {
              Utils.showToastMsg("提货成功");
              initAllData();
            }
        );
      },
      content: "确定提货吗？",
    );
  }

  /// 委托上架
  void shangjia() {
    if (!timeInShelf()) {
      showConfirmDialog(
        singleText: '知道了',
        onSingle: () async {},
        content: "委托上架时间为${systemSetting.model.value
            ?.shelfStartTime}--${systemSetting.model.value?.shelfEndTime}",
      );
      return;
    }

    showConfirmDialog(
      title: "委托寄卖",
      cancelText: "暂不使用",
      onConfirm: () async {
        /// todo 委托上架之后打开寄卖信息页面
        Get.toNamed(RoutesID.ORDER_SEND_SELL_PAGE);
      },
      contentWidget: RichText(
        text: TextSpan(
          text: "请你务必认真阅读、充分理解“委托寄卖”各条款，包括但不限于:为了向你提供数据、分享等服务所要获叹的权限信息。你可以阅读",
          style: TextStyle(
            color: Color(0xFF434446),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          children: [
            TextSpan(
                text: "《委托寄卖》",
                style: TextStyle(
                  color: Color(0xFF1BDB8A),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(
                      RoutesID.LOCAL_HTML_PAGE,
                      arguments: {
                        "page_title": "委托寄售服务协议",
                        "html_file": "assets/html/sell_policy.html",
                      },
                    );
                  }),
            TextSpan(
                text: "了解详细信息。如您同意，请点击同意开始接受我们的服务",
                style: TextStyle(
                  color: Color(0xFF434446),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ))
          ],
        ),
      )
    );
  }

  /// 可上架时间判断
  bool timeInShelf() {
    String now = formatDate(DateTime.now(), [HH, ':', nn]);
    var nowArr = now.split(":");
    var startArr = systemSetting.model.value?.shelfStartTime?.split(":");
    var endArr = systemSetting.model.value?.shelfEndTime?.split(":");
    int nowHour = (int.parse(nowArr[0]));
    int nowMinute = int.parse(nowArr[1]);
    int nowTime = nowHour * 60 + nowMinute; // 当前天分钟数

    int startHour = int.parse(startArr?[0] ?? "0");
    int startMinute = int.parse(startArr?[1] ?? "0");
    int start = startHour * 60 + startMinute;

    int endHour = int.parse(endArr?[0] ?? "0");
    int endMinute = int.parse(endArr?[1] ?? "0");
    int end = endHour * 60 + endMinute;

    return nowTime >= start && nowTime <= end;
  }
}
