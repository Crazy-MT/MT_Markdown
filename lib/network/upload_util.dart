import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:code_zero/app/modules/mine/buyer_order/order_send_sell/model/charge_model.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:code_zero/common/model/upload_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/platform_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../network/base_model.dart';
import '../../../../../utils/log_utils.dart';
import '../../../../../utils/utils.dart';
import '../common/user_apis.dart';

uploadFile({isShowLoading = true, List<int>? value}) async {
  if(value == null) {
    return;
  }
  Map<String, dynamic> map = {
    "file": dio.MultipartFile.fromBytes(
      value,
      filename: "a.png",
    )
  };
  dio.FormData formData = dio.FormData.fromMap(map);
  ResultData<UploadModel>? _result = await LRequest.instance.request<UploadModel>(
    url: Apis.UPLOAD,
    t: UploadModel(),
    formData: formData,
    isShowLoading: isShowLoading,
    requestType: RequestType.POST,
    errorBack: (errorCode, errorMsg, expMsg) {
      Utils.showToastMsg("上传失败：${errorCode == -1 ? expMsg : errorMsg}");
      errorLog("上传失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
    },
  );

  if (_result?.value == null) {
    return;
  }

  lLog('MTMTMT uploadFile ${_result?.value?.fileUrl}');
  return _result?.value?.fileUrl ?? "";
}

void checkPayResult(int? id, VoidCallback? success, VoidCallback? timeOut, VoidCallback? fail) {
  EasyLoading.show();

  int duration = 1;
  int max = 30;

  int count = 0;
  Timer.periodic(Duration(seconds: duration), (timer) async {
    count += 1;
    int status = await checkPayStatus(id);
    lLog('MTMTMT checkPayResult ${status}');

    if (count >= (max / duration)) {
      timer.cancel();
      EasyLoading.dismiss();
      showConfirmDialog(
        singleText: '确定',
        onSingle: () async {
          timeOut?.call();
        },
        content: '查询支付结果超时，请稍后查询或联系工作人员',
      );
      return;
    }

    // 3 6 需要再查，1 成功，其它失败
    if (status == 3 || status == 6) {
    } else {
      timer.cancel();
      EasyLoading.dismiss();
      if (status == 1) {
        /// 支付成功
        Utils.showToastMsg('支付成功');
        success?.call();
      } else {
        showConfirmDialog(
          singleText: '确定',
          onSingle: () async {
            fail?.call();
          },
          content: '支付异常，请联系工作人员',
        );
      }
    }
  });
}

/// 设置订单状态
Future<int> setPayStatus(id) async {
  int status = -1;
  await LRequest.instance.request
  // <ChargeModel>
    (
      url: SnapApis.SET_PAY_STATUS,
      // url: SnapApis.PAY_STATUS,
      t: ChargeModel(),
      queryParameters: {
        "id": id
      },
      isShowLoading: false,
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        status = -1;
      },
      onSuccess: (result) {
        // status = result.value?.tradeState ?? 0;
        status = 1;
      });
  return status;
}

/// 查询订单状态
Future<int> checkPayStatus(id) async {
  int status = -1;
  await LRequest.instance.request
  <ChargeModel>
    (
    // url: SnapApis.SET_PAY_STATUS,
      url: SnapApis.PAY_STATUS,
      t: ChargeModel(),
      queryParameters: {
        "id": id
      },
      isShowLoading: false,
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        status = -1;
      },
      onSuccess: (result) {
        status = result.value?.tradeState ?? 0;
        // status = 1;
      });
  return status;
}

