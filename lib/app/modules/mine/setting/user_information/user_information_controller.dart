import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/model/upload_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../common/user_helper.dart';
import '../../../../../network/base_model.dart';
import '../../../../../network/upload_util.dart';
import '../../../../../utils/log_utils.dart';
import '../../../../../utils/utils.dart';
import '../../../../../common/user_apis.dart';
import 'model/update_info.dart';

class UserInformationController extends GetxController {
  final pageName = 'UserInformation'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  var avatarImg = "".obs;

  TextEditingController? nameController = TextEditingController();

  RxInt gender = 0.obs;
  var birthday = "".obs;

  @override
  void onInit() {
    super.onInit();
    initData();
    initMenuList();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  initMenuList() {
    avatarImg.value = userHelper.userInfo.value?.avatarUrl ?? "";
    nameController?.text = userHelper.userInfo.value?.nickname ?? "";
    birthday.value = userHelper.userInfo.value?.birthday ?? "";
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }

  Future<void> chooseAndUploadImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery);
    if(image == null) {
      return;
    }
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      compressQuality: 50,
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
          // rectWidth: 500,
          // rectHeight: 500
          // rectX: 500,
          // rectY: 500
        ),
      ],
    );
    avatarImg.value = await uploadFile(croppedFile?.path);
  }

  Future<void> updateInfo() async {
    ResultData<UpdateInfoModel>? _result = await LRequest.instance.request<UpdateInfoModel>(
      url: Apis.UPDATE_INFO,
      t: UpdateInfoModel(),
      data: {
        "id": userHelper.userInfo.value?.id,
        "avatarUrl": avatarImg.value,
        "nickname": nameController?.text,
        "gender": gender.value,
        "hasBirthday": birthday.value.isEmpty ? 0 : 1,
        "birthday": birthday.value
      },
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("修改失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("修改失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
      onSuccess: (_) async {
        userHelper.userInfo.value?.birthday = birthday.value;
        userHelper.userInfo.value?.hasBirthday = birthday.value.isEmpty ? 0 : 1;
        userHelper.userInfo.value?.gender = gender.value;
        userHelper.userInfo.value?.nickname = nameController?.text;
        userHelper.userInfo.value?.avatarUrl = avatarImg.value;
        userHelper.userInfo.update((val) {});
        await userHelper.whenLogin(userHelper.userInfo.value!);
        Utils.showToastMsg("修改成功");
        Get.back();
      }
    );

    if (_result?.value == null) {
      return;
    }
  }
}