import 'convert_interface.dart';

class BaseModel<T extends ConvertInterface> {
  int? code;
  String? message;
  dynamic data;

  BaseModel({this.code, this.message, this.data});

  BaseModel.fromJson(Map<String, dynamic> json, T? t) {
    code = json['code'];
    message = json['message'];
    if (json['data'] is Map) {
      data = t!.fromJson(json['data']);
    } else if (json['data'] is List) {
      data = <T>[];
      json['data'].forEach((v) {
        data!.add(t!.fromJson(v));
      });
    } else {
      // data = json['data'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data is List) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    } else {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class ResultData<T> {
  String? message;
  T? value;
  List<T?> valueList = [];
}
