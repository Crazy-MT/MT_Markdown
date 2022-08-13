import 'convert_interface.dart';

class BaseModel<T extends ConvertInterface> {
  int? status;
  String? message;
  dynamic data;
  int? timestamp;

  BaseModel({this.status, this.message, this.data, this.timestamp});

  BaseModel.fromJson(Map<String, dynamic> json, T? t) {
    status = json['status'];
    message = json['message'];
    if (json['data'] is Map) {
      data = t!.fromJson(json['data']);
    } else if (json['data'] is List) {
      data = <T>[];
      json['data'].forEach((v) {
        data!.add(t!.fromJson(v));
      });
    } else {
      data = json['data'];
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data is List) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    } else {
      data['data'] = this.data?.toJson();
    }
    data['timestamp'] = timestamp;
    return data;
  }
}

class ResultData<T> {
  String? message;
  T? value;
  List<T?> valueList = [];
}
