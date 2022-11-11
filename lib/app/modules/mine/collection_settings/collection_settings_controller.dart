import 'dart:async';

import 'package:code_zero/app/modules/mine/collection_settings/collection_settings_apis.dart';
import 'package:code_zero/app/modules/mine/collection_settings/model/user_alipay_model.dart';
import 'package:code_zero/app/modules/mine/collection_settings/model/user_bank_card_model.dart';
import 'package:code_zero/app/modules/mine/collection_settings/model/user_wechat_model.dart';
import 'package:code_zero/common/user_apis.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/model/user_model.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/network/upload_util.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CollectionSettingsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final pageName = 'CollectionSettings'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  List<String> tabList = ['微信', '银行卡', '支付宝'];
  TabController? tabController;

  // 银行卡数据
  Rx<UserBankCardModel?> bankcardInfo = Rx<UserBankCardModel?>(null);

  // 银行卡姓名
  TextEditingController bankNameController = new TextEditingController();

  // 银行卡手机号
  TextEditingController bankPhoneController = new TextEditingController();

  // 银行卡验证码
  TextEditingController bankCodeController = new TextEditingController();

  // 银行卡卡号
  TextEditingController bankCardNumController = new TextEditingController();

  // 银行卡所属银行
  TextEditingController bankBelongController = new TextEditingController();

  // 微信数据
  Rx<UserWechatModel?> wechatInfo = Rx<UserWechatModel?>(null);

  // 微信账号
  TextEditingController wechatAccountController = new TextEditingController();

  // 微信验证码
  TextEditingController wechatCodeController = new TextEditingController();

  // 微信收款姓名
  TextEditingController wechatNameController = new TextEditingController();

  // 微信收款二维码
  RxString wechatQrImg = "".obs;

  // 支付宝数据
  Rx<UserAlipayModel?> aliPayInfo = Rx<UserAlipayModel?>(null);

  // 支付宝账号
  TextEditingController aliPayAccountController = new TextEditingController();

  // 支付宝验证码
  TextEditingController aliPayCodeController = new TextEditingController();

  // 支付宝收款姓名
  TextEditingController aliPayNameController = new TextEditingController();

  // 支付宝收款二维码
  RxString aliPayQrImg = "".obs;

  RxBool isBankEdit = RxBool(true);
  RxBool isWechatEdit = RxBool(true);
  RxBool isAliPayEdit = RxBool(true);

  var hasNoBankCard = true;
  var hasNoWeiXin = true;
  var hasNoAliPay = true;

  final sendBankCodeCountDown = 0.obs;
  final sendWechatCodeCountDown = 0.obs;
  final sendAliPayCodeCountDown = 0.obs;

  Timer? bankTimer;
  Timer? wechatTimer;
  Timer? aliPayTimer;

  @override
  void onInit() {
    super.onInit();
    initData();
    fetchBankCardData();
    fetchWeChatData();
    fetchAliPayData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    tabController = TabController(
      length: tabList.length,
      vsync: this,
      initialIndex: 0,
    );
    tabController?.addListener(() {
      ///避免addListener调用2次
      if (tabController?.index == tabController?.animation?.value) {
        // lLog("点击了下标为${tabController?.index}的tab");
      }
    });
  }

  void goBack() {
    if (hasNoWeiXin && hasNoBankCard && hasNoAliPay) {
      Get.back();
      return;
    }
    if (tabController?.index == 0 &&
        isBankEdit.value == true &&
        !hasNoBankCard) {
      isBankEdit.value = false;
    } else if (tabController?.index == 1 &&
        isWechatEdit.value == true &&
        !hasNoWeiXin) {
      isWechatEdit.value = false;
    } else if (tabController?.index == 2 &&
        isAliPayEdit.value == true &&
        !hasNoAliPay) {
      isAliPayEdit.value = false;
    } else {
      Get.back();
    }
  }

/*
  void enterEdit() {
    if (tabController?.index == 0) {
      bankNameController.text = bankcardInfo.value?.name ?? '';
      bankPhoneController.text = bankcardInfo.value?.phone ?? '';
      bankCardNumController.text = bankcardInfo.value?.bankCardNum ?? '';
      bankBelongController.text = bankcardInfo.value?.bankName ?? '';
      isBankEdit.value = true;
    } else {
      wechatAccountController.text = wechatInfo.value?.wechatAccount ?? '';
      wechatNameController.text = wechatInfo.value?.name ?? '';
      wechatQrImg.value = wechatInfo.value?.wechatPaymentCodeUrl ?? '';
      isBankEdit.value = true;
    }
  }
*/

  // 获取用户银行卡
  Future<void> fetchBankCardData() async {
    ResultData<UserBankCardModel>? _result =
        await LRequest.instance.request<UserBankCardModel>(
      url: CollectionSettingsApis.USERBANK,
      t: UserBankCardModel(),
      queryParameters: {
        "user-id": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取用户银行卡失败：${errorCode == -1 ? expMsg : errorMsg}");
        lLog(errorMsg);
      },
    );
    print(
        'MTMTMT CollectionSettingsController.fetchBankCardData ${bankcardInfo.value} ');
    isBankEdit.value = true;
    if (_result?.value == null) {
      return;
    }
    bankcardInfo.value = _result?.value;
    hasNoBankCard = false;
    isBankEdit.value = false;
    bankNameController.text = bankcardInfo.value?.name ?? "";
    bankPhoneController.text = bankcardInfo.value?.phone ?? "";
    bankCardNumController.text = bankcardInfo.value?.bankCardNum ?? "";
    bankBelongController.text = bankcardInfo.value?.bank ?? "";

    userHelper.userInfo.value?.hasPaymentMethod = 1;
    userHelper.updateSp(userHelper.userInfo.value);
  }

  // 获取用户微信
  Future<void> fetchWeChatData() async {
    ResultData<UserWechatModel>? _result =
        await LRequest.instance.request<UserWechatModel>(
      url: CollectionSettingsApis.USERWECHAT,
      t: UserWechatModel(),
      queryParameters: {
        "user-id": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取用户微信方式失败：${errorCode == -1 ? expMsg : errorMsg}");
        lLog(errorMsg);
      },
    );
    isWechatEdit.value = true;
    if (_result?.value == null) {
      return;
    }
    wechatInfo.value = _result?.value;
    hasNoWeiXin = false;
    isWechatEdit.value = false;
    wechatAccountController.text = wechatInfo.value?.wechatAccount ?? "";
    wechatNameController.text = wechatInfo.value?.name ?? "";
    wechatQrImg.value = wechatInfo.value?.wechatPaymentCodeUrl ?? "";

    userHelper.userInfo.value?.hasPaymentMethod = 1;
    userHelper.updateSp(userHelper.userInfo.value);
  }

  // 获取支付宝
  Future<void> fetchAliPayData() async {
    ResultData<UserAlipayModel>? _result =
        await LRequest.instance.request<UserAlipayModel>(
      url: CollectionSettingsApis.USER_ALIPAY,
      t: UserAlipayModel(),
      queryParameters: {
        "user-id": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg(
            "获取用户支付宝方式失败：${errorCode == -1 ? expMsg : errorMsg}");
        lLog(errorMsg);
      },
    );
    isAliPayEdit.value = true;
    if (_result?.value == null) {
      return;
    }
    aliPayInfo.value = _result?.value;
    hasNoAliPay = false;
    isAliPayEdit.value = false;
    aliPayAccountController.text = aliPayInfo.value?.alipayAccount ?? "";
    aliPayNameController.text = aliPayInfo.value?.name ?? "";
    aliPayQrImg.value = aliPayInfo.value?.alipayPaymentCodeUrl ?? "";

    userHelper.userInfo.value?.hasPaymentMethod = 1;
    userHelper.updateSp(userHelper.userInfo.value);
  }

  // 添加银行卡
  Future<void> addUserBankCard() async {
    String url = CollectionSettingsApis.USEADDBANK;
    ResultData<UserBankCardModel>? _result =
        await LRequest.instance.request<UserBankCardModel>(
      url: url,
      t: UserBankCardModel(),
      data: {
        "name": bankNameController.text,
        "phone": bankPhoneController.text,
        "authCode": bankCodeController.text,
        "bankCardNum": bankCardNumController.text,
        "bank": bankBelongController.text,
        "userId": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("添加银行卡失败：${errorCode == -1 ? expMsg : errorMsg}");
        lLog(errorMsg);
      },
    );
    if (_result?.value == null) {
      return;
    }
    bankcardInfo.value = _result?.value;
    userHelper.userInfo.value?.hasPaymentMethod = 1;
    userHelper.updateSp(userHelper.userInfo.value);
    if (Get.arguments?["from"] == RoutesID.LOGIN_PAGE ||
        Get.arguments?['from'] == RoutesID.HOME_PAGE) {
      Get.back();
    } else {
      fetchBankCardData();
    }
  }

  /// 编辑银行卡信息
  Future<void> editBankCard(id) async {
    String url = CollectionSettingsApis.USEPAYMENTUPDATE;
    ResultData<UserBankCardModel>? _result =
        await LRequest.instance.request<UserBankCardModel>(
            url: url,
            t: UserBankCardModel(),
            data: {
              "paymentMethodId": id,
              "method": 0,
              "name": bankNameController.text,
              "phone": bankPhoneController.text,
              "authCode": bankCodeController.text,
              "bankCardNum": bankCardNumController.text,
              "bank": bankBelongController.text,
              "userId": userHelper.userInfo.value?.id,
              // "isAdmin": 0,
            },
            requestType: RequestType.POST,
            errorBack: (errorCode, errorMsg, expMsg) {
              Utils.showToastMsg(
                  "编辑银行卡信息失败：${errorCode == -1 ? expMsg : errorMsg}");
              lLog(errorMsg);
            },
            onSuccess: (_) {
              fetchBankCardData();
            });
    if (_result?.value == null) {
      return;
    }
    // bankcardInfo.value = _result?.value;
  }

  // 添加微信
  Future<void> addUserWechat() async {
    String url = CollectionSettingsApis.USEADDWECHAT;
    ResultData<UserWechatModel>? _result =
        await LRequest.instance.request<UserWechatModel>(
      url: url,
      t: UserWechatModel(),
      data: {
        "wechatAccount": wechatAccountController.text,
        "authCode": wechatCodeController.text,
        "name": wechatNameController.text,
        "wechatPaymentCodeUrl": wechatQrImg.value,
        "phone": userHelper.userInfo.value?.phone,
        "userId": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("添加微信失败：${errorCode == -1 ? expMsg : errorMsg}");
        lLog(errorMsg);
      },
    );
    if (_result?.value == null) {
      return;
    }
    wechatInfo.value = _result?.value;

    userHelper.userInfo.value?.hasPaymentMethod = 1;
    userHelper.updateSp(userHelper.userInfo.value);

    if (Get.arguments?["from"] == RoutesID.LOGIN_PAGE ||
        Get.arguments?['from'] == RoutesID.HOME_PAGE) {
      Get.back();
    } else {
      fetchWeChatData();
    }
  }

  /// 编辑微信信息
  Future<void> editWeiXinCard(id) async {
    String url = CollectionSettingsApis.USEPAYMENTUPDATE;
    ResultData<UserBankCardModel>? _result =
        await LRequest.instance.request<UserBankCardModel>(
            url: url,
            t: UserBankCardModel(),
            data: {
              "paymentMethodId": id,
              "method": 1,
              "wechatAccount": wechatAccountController.text,
              "name": wechatNameController.text,
              "phone": userHelper.userInfo.value?.phone,
              "authCode": wechatCodeController.text,
              "wechatPaymentCodeUrl": wechatQrImg.value,
              "userId": userHelper.userInfo.value?.id,
              // "isAdmin": 0,
            },
            requestType: RequestType.POST,
            errorBack: (errorCode, errorMsg, expMsg) {
              lLog(errorMsg);
              Utils.showToastMsg(
                  "编辑微信失败：${errorCode == -1 ? expMsg : errorMsg}");
            },
            onSuccess: (_) {
              fetchWeChatData();
            });
    if (_result?.value == null) {
      return;
    }
    // bankcardInfo.value = _result?.value;
  }

  // 添加支付宝
  Future<void> addUserAlipay() async {
    String url = CollectionSettingsApis.USE_ADD_ALIPAY;
    ResultData<UserAlipayModel>? _result =
        await LRequest.instance.request<UserAlipayModel>(
      url: url,
      t: UserAlipayModel(),
      data: {
        "alipayAccount": aliPayAccountController.text,
        "authCode": aliPayCodeController.text,
        "name": aliPayNameController.text,
        "alipayPaymentCodeUrl": aliPayQrImg.value,
        "phone": userHelper.userInfo.value?.phone,
        "userId": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("添加支付宝失败：${errorCode == -1 ? expMsg : errorMsg}");
        lLog(errorMsg);
      },
    );
    if (_result?.value == null) {
      return;
    }
    aliPayInfo.value = _result?.value;

    userHelper.userInfo.value?.hasPaymentMethod = 1;
    userHelper.updateSp(userHelper.userInfo.value);
    lLog('MTMTMT CollectionSettingsController.addUserAlipay ${Get.arguments?['from']} ');
    if (Get.arguments?["from"] == RoutesID.LOGIN_PAGE ||
        Get.arguments?['from'] == RoutesID.HOME_PAGE) {
      Get.back();
    } else {
      fetchAliPayData();
    }
  }

  /// 编辑支付宝信息
  Future<void> editAlipayCard(id) async {
    String url = CollectionSettingsApis.USEPAYMENTUPDATE;
    ResultData<UserBankCardModel>? _result =
        await LRequest.instance.request<UserBankCardModel>(
            url: url,
            t: UserBankCardModel(),
            data: {
              "paymentMethodId": id,
              "method": 2,
              "alipayAccount": aliPayAccountController.text,
              "name": aliPayNameController.text,
              "phone": userHelper.userInfo.value?.phone,
              "authCode": aliPayCodeController.text,
              "alipayPaymentCodeUrl": aliPayQrImg.value,
              "userId": userHelper.userInfo.value?.id,
              // "isAdmin": 0,
            },
            requestType: RequestType.POST,
            errorBack: (errorCode, errorMsg, expMsg) {
              lLog(errorMsg);
              Utils.showToastMsg(
                  "编辑支付宝失败：${errorCode == -1 ? expMsg : errorMsg}");
            },
            onSuccess: (_) {
              fetchAliPayData();
            });
    if (_result?.value == null) {
      return;
    }
    // bankcardInfo.value = _result?.value;
  }

  // 选择图片并上传
  Future<void> chooseAndUploadImage(bool isFromWechat) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
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
        WebUiSettings(
          context: Get.context!,
        ),
      ],
    );
    if (isFromWechat) {
      wechatQrImg.value =
          await uploadFile(value: await croppedFile?.readAsBytes());
    } else {
      aliPayQrImg.value =
          await uploadFile(value: await croppedFile?.readAsBytes());
    }
  }

  // 获取验证码
  void getSMS(bool isBankAdd, {bool isAlipay = false}) async {
    if (isBankAdd && bankPhoneController.text.isEmpty) {
      Utils.showToastMsg('请填写手机号');
      sendBankCodeCountDown.value = 0;
      bankTimer?.cancel();
      return;
    }
    Map<String, dynamic> params = {
      "phone": bankPhoneController.text,
    };
    if (!isBankAdd) {
      params = {
        "phone": userHelper.userInfo.value?.phone ?? '',
      };
    }
    ResultData<UserModel>? _result = await LRequest.instance.request<UserModel>(
      url: Apis.SMS,
      t: UserModel(),
      queryParameters: params,
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        if (isBankAdd) {
          sendBankCodeCountDown.value = 0;
          bankTimer?.cancel();
        } else {
          if (isAlipay) {
            sendAliPayCodeCountDown.value = 0;
            aliPayTimer?.cancel();
          } else {
            sendWechatCodeCountDown.value = 0;
            wechatTimer?.cancel();
          }
        }
        Utils.showToastMsg("获取验证码失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("获取验证码失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
    );

    if (_result?.value == null) {
      return;
    }
  }

  // 银行卡验证码
  void startBankCountDown() {
    if (sendBankCodeCountDown > 0) {
      return;
    }
    sendBankCodeCountDown.value = 60;
    bankTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      sendBankCodeCountDown.value = sendBankCodeCountDown.value - 1;
      if (sendBankCodeCountDown.value == 0) {
        timer.cancel();
      }
    });
  }

  // 微信验证码
  void startWechatCountDown() {
    if (sendWechatCodeCountDown > 0) {
      return;
    }
    sendWechatCodeCountDown.value = 60;
    wechatTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      sendWechatCodeCountDown.value = sendWechatCodeCountDown.value - 1;
      if (sendWechatCodeCountDown.value == 0) {
        timer.cancel();
      }
    });
  }

  // 支付宝验证码
  void startAlipayCountDown() {
    if (sendAliPayCodeCountDown > 0) {
      return;
    }
    sendAliPayCodeCountDown.value = 60;
    aliPayTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      sendAliPayCodeCountDown.value = sendAliPayCodeCountDown.value - 1;
      if (sendAliPayCodeCountDown.value == 0) {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }

  String getBankImage() {
    String bankName = bankcardInfo.value?.bank ?? "";
    if (bankName.contains('建')) {
      return Assets.imagesBank1;
    }

    if (bankName.contains('工')) {
      return Assets.imagesBank2;
    }
    if (bankName.contains('农')) {
      return Assets.imagesBank3;
    }
    if (bankName.contains('邮')) {
      return Assets.imagesBank4;
    }
    if (bankName.contains('交')) {
      return Assets.imagesBank5;
    }
    if (bankName.contains('中国银行')) {
      return Assets.imagesBank6;
    }

    if (bankName.contains('招')) {
      return Assets.imagesBank8;
    }

    if (bankName.contains('浦发')) {
      return Assets.imagesBank7;
    }

    return Assets.imagesWalletBankcardBg;
  }
}
