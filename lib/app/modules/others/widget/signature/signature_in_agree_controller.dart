import 'package:code_zero/network/upload_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../common/model/user_model.dart';
import '../../../../../common/user_helper.dart';
import '../../../../../network/l_request.dart';
import '../../../../../utils/log_utils.dart';
import '../../../../../utils/utils.dart';
import '../../../../../common/user_apis.dart';
class SignatureInArgeeController extends GetxController {
  final signImgUrl = "".obs;
  Uint8List? imageData;

  GlobalKey globalKey = GlobalKey();

  saveSignature() async {
    if (signImgUrl.value.isNotEmpty) {
      Uint8List? sourceBytes = await Utils().capturePng(globalKey);
      if(sourceBytes != null) {
        var signUrl = await uploadFile(value: sourceBytes);
        await LRequest.instance.request<UserModel>(
            url: Apis.UPDATE_SIGNATURE,
            t: UserModel(),
            data: {
              "id": userHelper.userInfo.value?.id,
              "signatureUrl": signUrl,
            },
            requestType: RequestType.POST,
            errorBack: (errorCode, errorMsg, expMsg) {
              Utils.showToastMsg("设置签名失败：${errorCode == -1 ? expMsg : errorMsg}");
              errorLog("设置签名失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
            },
            onSuccess: (_) async {
              Utils.showToastMsg("设置签名成功");
              userHelper.userInfo.value?.hasSignature = 1;
              userHelper.userInfo.value?.signatureUrl = signUrl;
              await userHelper.whenLogin(userHelper.userInfo.value!);
              Get.back();
            }
        );
      }
    }
  }
}
