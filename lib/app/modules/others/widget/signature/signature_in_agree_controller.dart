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

  GlobalKey globalKey = GlobalKey();

  saveSignature() async {
    if (signImgUrl.value.isNotEmpty) {
      File file = await _saveImageToFile();
      String toPath = await _capturePng(file);
      if(toPath.isNotEmpty) {
        var signUrl = await uploadFile(toPath, value: await file.readAsBytes());
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

  Future<File> _saveImageToFile() async {
    Directory tempDir = await getTemporaryDirectory();
    int curT = DateTime.now().millisecondsSinceEpoch;
    String toFilePath = "${tempDir.path}/$curT.png";
    File file = File(toFilePath);
    bool exists = await file.exists();
    if (!exists) {
      await file.create(recursive: true);
    }
    return file;
  }

  Future<String> _capturePng(File file) async {
    RenderObject? obj = globalKey.currentContext?.findRenderObject();
    if (obj is RenderRepaintBoundary) {
      double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
      var image = await obj.toImage(pixelRatio: dpr);
      ByteData? _byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? sourceBytes = _byteData?.buffer.asUint8List();
      if (sourceBytes != null) {
        await file.writeAsBytes(sourceBytes);
        return file.path;
      }
    }
    return "";
  }
}
