import 'package:code_zero/app/modules/home/submit_order/model/data_model.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/network/upload_util.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/platform_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common/colors.dart';

class ComplaintFeedbackController extends GetxController {
  final pageName = 'ComplaintFeedback'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  final textCount = 0.obs;
  final photoItems = ["add"].obs;
  List<XFile?> photoXFile = [];
  final TextEditingController textEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }

  createAppeal() async {
    var imageUrlList = [];
    EasyLoading.show();
    for (var photo in photoXFile) {
      String imageUrl = await uploadFile(isShowLoading: false, value: await photo?.readAsBytes());
      imageUrlList.add(imageUrl);
    }

    ResultData<DataModel>? _result = await LRequest.instance.request<DataModel>(
        url: SnapApis.CREATE_APPEAL,
        isShowLoading: false,
        data: {
          "content": textEditingController.text,
          "appealType": Get.arguments?['appealType'],
          "userId": userHelper.userInfo.value?.id,
          "buyingTranId": Get.arguments?['id'],
          "imageUrlList": imageUrlList
        },
        t: DataModel(),
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("申诉失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("申诉失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
          EasyLoading.dismiss();
        },
        onSuccess: (rest) {
          Utils.showToastMsg("申诉成功");
          EasyLoading.dismiss();
          Get.back();
        });
  }

  // 选择图片并上传
  Future<void> addImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image?.path != null) {
      photoXFile.insert(0, image);
      photoItems.insert(0, image!.path);
    }
  }

  removeImage(int index) {
    if (photoItems.length > index && photoItems[index] != "add") {
      photoXFile.removeAt(index);
      photoItems.removeAt(index);
    }
  }
}
