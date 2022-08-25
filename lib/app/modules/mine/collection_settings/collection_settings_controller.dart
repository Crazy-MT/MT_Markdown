import 'package:code_zero/app/modules/mine/collection_settings/collection_settings_apis.dart';
import 'package:code_zero/app/modules/mine/collection_settings/model/user_bank_card_model.dart';
import 'package:code_zero/app/modules/mine/collection_settings/model/user_wechat_model.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/network/upload_util.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CollectionSettingsController extends GetxController with GetSingleTickerProviderStateMixin {
  final pageName = 'CollectionSettings'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  List<String> tabList = ['银行卡', '微信'];
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
  final sendSmsCountdown = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
    fetchBankCardData();
    fetchWeChatData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    tabController = TabController(
      length: tabList.length,
      vsync: this,
      initialIndex: 0,
    );
    // tabController?.index = Get.arguments['index'] as int;
    tabController?.addListener(() {
      ///避免addListener调用2次
      if (tabController?.index == tabController?.animation?.value) {
        lLog("点击了下标为${tabController?.index}的tab");
      }
    });
  }

  Future<void> fetchBankCardData() async {
    ResultData<UserBankCardModel>? _result = await LRequest.instance.request<UserBankCardModel>(
      url: CollectionSettingsApis.USERBANK,
      t: UserBankCardModel(),
      data: {
        "user-id": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        lLog(errorMsg);
      },
    );
    if (_result?.value == null) {
      return;
    }
    bankcardInfo.value = _result?.value;
  }

  Future<void> fetchWeChatData() async {
    ResultData<UserWechatModel>? _result = await LRequest.instance.request<UserWechatModel>(
      url: CollectionSettingsApis.USERWECHAT,
      t: UserWechatModel(),
      data: {
        "user-id": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        lLog(errorMsg);
      },
    );
    if (_result?.value == null) {
      return;
    }
    wechatInfo.value = _result?.value;
  }

  Future<void> addUserBankCard() async {
    ResultData<UserBankCardModel>? _result = await LRequest.instance.request<UserBankCardModel>(
      url: CollectionSettingsApis.USEADDBANK,
      t: UserBankCardModel(),
      data: {
        "name": bankNameController.text,
        "phone": bankPhoneController.text,
        "authCode": bankCodeController.text,
        "bankCardNum": bankCardNumController.text,
        "bank": bankNameController.text,
        "userId": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        lLog(errorMsg);
      },
    );
    if (_result?.value == null) {
      return;
    }
    bankcardInfo.value = _result?.value;
  }

  Future<void> addUserWechat() async {
    ResultData<UserWechatModel>? _result = await LRequest.instance.request<UserWechatModel>(
      url: CollectionSettingsApis.USEADDWECHAT,
      t: UserWechatModel(),
      data: {
        "wechatAccount": wechatAccountController.text,
        "authCode": wechatCodeController.text,
        "name": wechatNameController.text,
        "wechatPaymentCodeUrl": '',
        "phone": userHelper.userInfo.value?.phone,
        "userId": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        lLog(errorMsg);
      },
    );
    if (_result?.value == null) {
      return;
    }
    wechatInfo.value = _result?.value;
  }

  Future<void> chooseAndUploadImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image?.path ?? "",
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
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
    wechatQrImg.value = await uploadFile(croppedFile?.path);
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}
