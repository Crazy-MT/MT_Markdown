import 'package:code_zero/common/model/upload_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:dio/dio.dart' as dio;

import '../../../../../common/user_helper.dart';
import '../../../../../network/base_model.dart';
import '../../../../../utils/log_utils.dart';
import '../../../../../utils/utils.dart';
import '../app/modules/others/user_apis.dart';

uploadFile(path) async {
  dio.FormData formData = dio.FormData.fromMap({
    "file": await dio.MultipartFile.fromFile(
        path,
        filename: "a.png"
    )
  });
  print('MTMTMT uploadFile ${path} ');
  ResultData<UploadModel>? _result = await LRequest.instance.request<UploadModel>(
    url: UserApis.UPLOAD,
    t: UploadModel(),
    formData: formData,
    requestType: RequestType.POST,
    errorBack: (errorCode, errorMsg, expMsg) {
      Utils.showToastMsg("上传失败：${errorCode == -1 ? expMsg : errorMsg}");
      errorLog("上传失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
    },
  );

  if (_result?.value == null) {
    return;
  }

  lLog('MTMTMT UserInformationController.uploadImage ${_result?.value?.fileUrl}');
  return _result?.value?.fileUrl ?? "";
}
