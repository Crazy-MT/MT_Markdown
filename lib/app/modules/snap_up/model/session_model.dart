import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../../../../network/convert_interface.dart';

class SessionModel extends ConvertInterface {
  SessionModel({
    this.items,
    this.totalCount = 0,
  });

  List<Item>? items;
  int totalCount = 0;

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) => SessionModel(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    totalCount: json["totalCount"],
  );
}

class Item {
  Item({
    this.id,
    this.name,
    this.startTime,
    this.endTime,
    this.imageUrl,
    this.orderNo,
    this.status,
  });

  int? id;
  String? name;
  String? startTime;
  String? endTime;
  String? imageUrl;
  int? orderNo;
  int? status;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    imageUrl: json["imageUrl"],
    orderNo: json["orderNo"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "startTime": startTime,
    "endTime": endTime,
    "imageUrl": imageUrl,
    "orderNo": orderNo,
    "status": status,
  };

  /// 倒计时
  isTimer() {
    Map map = {};
    String now = formatDate(DateTime.now(), [HH, ':', nn]);
    var nowArr = now.split(":");
    var startArr = startTime?.split(":");
    int nowHour = (int.parse(nowArr[0]));
    int startHour = int.parse(startArr?[0] ?? "0");
    int nowMinute = int.parse(nowArr[1]);
    int startMinute = int.parse(startArr?[1] ?? "0");
    map["open"] = status == 1  && ((startHour > nowHour) || ((nowHour == startHour) && startMinute > nowMinute));
    if(map["open"]) {
      map["second"] = (startHour - nowHour) * 60 * 60 + (startMinute - nowMinute) * 60;
    }
    return map;
  }

  statusText() {
    Map map = {};

    // startTime = "14:55";
    // endTime = "23:00";

    if(status == 0) {
      map["text"] = "未开放";
      map["toast_text"] = "还未开放，敬请期待";
      return map;
    }
    String now = formatDate(DateTime.now(), [HH, ':', nn]);
    var nowArr = now.split(":");
    var startArr = startTime?.split(":");
    var endArr = endTime?.split(":");
    int nowHour = (int.parse(nowArr[0]));
    int nowMinute = int.parse(nowArr[1]);
    int nowTime = nowHour * 60 + nowMinute; // 当前天分钟数

    int startHour = int.parse(startArr?[0] ?? "0");
    int startMinute = int.parse(startArr?[1] ?? "0");
    int start = startHour * 60 + startMinute;

    int endHour = int.parse(endArr?[0] ?? "0");
    int endMinute = int.parse(endArr?[1] ?? "0");
    int end = endHour * 60 + endMinute;

    if(nowTime > end) {
      map["text"] = "已结束";
      map["toast_text"] = "已经结束，下次再来";
      return map;
    }

    if((start - nowTime) > 20) {
      map["text"] = (startTime ?? "") + "--" + (endTime ?? "");;
      map["toast_text"] = "还未开始，请稍后哦";
      return map;
    }

    map["text"] = (startTime ?? "") + "--" + (endTime ?? "");;
    return map;
  }
}
