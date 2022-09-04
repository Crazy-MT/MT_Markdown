import 'package:flutter/material.dart';
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

  // 选择图片并上传
  Future<void> addImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image?.path != null) {
      photoItems.insert(0, image!.path);
    }
  }

  removeImage(int index) {
    if (photoItems.length > index && photoItems[index] != "add") {
      photoItems.removeAt(index);
    }
  }
}
