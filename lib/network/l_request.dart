// ignore_for_file: prefer_generic_function_type_aliases

import 'dart:io';

import 'package:code_zero/common/common.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../common/user_helper.dart';
import '../utils/device_util.dart';
import '../utils/log_utils.dart';
import '../utils/utils.dart';
import 'base_model.dart';
import 'convert_interface.dart';
import 'net_constant.dart';

typedef ErrorCallback(int errorCode, String errorMsg, String expMsg);
typedef HandleBaseModel(BaseModel baseModel);
typedef OnSuccess<T>(ResultData<T> resultData);

// ignore: constant_identifier_names
enum RequestType { GET, POST }

class LRequest {
  static Dio dio = Dio();
  //测试
  // static String token = "PKwBFmxcoQHgRpWWOqNhnQ==";
  //线上
  // static String token = "mEoLdDAQeNUgdIfcCT97Yg==";

  LRequest._();
  static final LRequest _lRequest = LRequest._();
  static LRequest get instance => _lRequest;

  void init() {
    // dio..interceptors.add(InterceptorsWrapper(onError: (DioError dioError) => errorInterceptor(dioError)));

    // dio.interceptors.add(_dioCacheManager.interceptor);
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    dio.options.sendTimeout = 10000;
    dio.options.headers[NetConstant.VERSION] = common.packageInfo?.version;
    dio.options.headers[NetConstant.APP] = "1";
    dio.options.headers[NetConstant.PLATFORM] = Platform.isAndroid ? "android" : "ios";
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
      /*client.findProxy = (uri) {
        return "PROXY 172.16.24.136:8888";
      };*/
      return client;
    };
    // setProxy(SpUtil.getString(Constant.SP_KEY_SAVE_PROXY));
  }

  // 此方法必须 try{}catch(){} 或者 传入 errorBack
  Future<ResultData<T>?> request<T extends ConvertInterface>({
    required String url,
    T? t,
    requestType = RequestType.GET,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool needHeader = true,
    bool noCache = true,
    bool skipError = false,
    bool stringResult = false,
    HandleBaseModel? handleBaseModel,
    ErrorCallback? errorBack,
    OnSuccess<T>? onSuccess,
    bool isShowErrorToast = true,
    FormData? formData,
  }) async {
    Response response;
    dio.options.headers[NetConstant.UNIQUE_ID] = deviceUtil.getUniqueID();
    //TODO 上线前记得改掉
    dio.options.headers[NetConstant.AUTHORIZATION] = "Bearer " + "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjM5NDA3MzEsImlzQWRtaW4iOjAsInBob25lIjoiMTcwOTAzMTE1NjMifQ.E1vnhIK52hrUnTV9zXXu9v6R-TmWfQO3lsMRPFFPv48";
    try {
      lLog("request get start =======>net: $url");
      if (requestType == RequestType.GET) {
        response = await dio.get(url, queryParameters: queryParameters);
      } else {
        response = await dio.post(url, data: formData ?? data);
      }
      lLog("request get over =======>net: $response ");
      //同一错误处理，如果需要可以后面放开
      // if (!skipError) await handleError(response, context: context, url: url);
      BaseModel<T> baseModel = BaseModel.fromJson(response.data, t);
      handleBaseModel?.call(baseModel);
      if (baseModel.code != 0) {
        errorBack?.call(baseModel.code ?? -1, baseModel.message ?? "UnknownMsg", "baseModel.code is not 0,this value is ${baseModel.code}");
        return null;
      }
      ResultData<T> resultData = ResultData();
      if (baseModel.data is List) {
        List<T> valueList = baseModel.data;
        resultData.valueList = valueList;
        resultData.value = valueList.isNotEmpty ? valueList.first : null;
        resultData.message = baseModel.message;
      } else if (baseModel.data is String) {
        resultData.message = baseModel.data;
      } else {
        resultData.value = baseModel.data;
        resultData.valueList = [resultData.value];
        resultData.message = baseModel.message;
      }
      onSuccess?.call(resultData);
      return resultData;
    } on DioError catch (e) {
      debugLog((e.response?.statusCode ?? -1).toString() + "${e.response?.data['message']}" + e.toString());
      errorLog(e.toString());
      if (e.response != null && e.response?.data["code"] == 20001) {
        userOutLoginError();
        return null;
      }
      if (errorBack != null) {
        errorBack(e.response?.statusCode ?? -1, e.response?.data["message"], e.toString());
      } else {
        handleError(e.response?.statusCode ?? -1, e.message, isShowErrorToast);
      }
      return null;
    } on Exception catch (e) {
      errorLog(e.toString());
      if (errorBack != null) {
        errorBack(-1, "数据处理异常", e.toString());
      } else {
        handleError(-1, e.toString(), isShowErrorToast);
      }
      return null;
    }
  }

  handleError(int code, String message, bool isShowErrorToast) {
    if (code == -1 && isShowErrorToast) {
      Utils.showToastMsg("请求失败了，code:$code");
    }
  }

  userOutLoginError() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Toast.show(est.LENGTH_SHORT, gravity: Toast.CENTER);
    //   utils.dismissLoading();
    //   if (ApplicationData.homePageSelectedName == 'hall') {
    //     PageUtil.backToTargetPage(Constant.PAGE_HOME_TAG, homeIndex: 2);
    //   }
    //   //我的时候 先跳首页，因为mine 位置不确定是 2，还是3  回头再优化
    //   if (ApplicationData.homePageSelectedName == 'mine') {
    //     var index = UserManager.isReview() ? 2 : 3;
    //     PageUtil.backToTargetPage(Constant.PAGE_HOME_TAG, homeIndex: index);
    //   }
    //   loginUtils.loginOverdue();
    //   // 登录过期，发布重置
    //   WorksPublishTools.instance.giveUpPublish();
    // });
  }
}
