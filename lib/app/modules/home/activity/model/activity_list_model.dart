import 'package:code_zero/network/convert_interface.dart';

class ActivityListModel extends ConvertInterface{
  List<ActivityItems>? items;
  int? totalCount;

  ActivityListModel({this.items, this.totalCount});

  ActivityListModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ActivityItems>[];
      json['items'].forEach((v) {
        items!.add(new ActivityItems.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return ActivityListModel.fromJson(json);
  }
}

class ActivityItems {
  int? id;
  int? kindId;
  String? name;
  String? imageUrl;
  int? orderNo;
  int? status;

  ActivityItems(
      {this.id,
      this.kindId,
      this.name,
      this.imageUrl,
      this.orderNo,
      this.status
      });

  ActivityItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kindId = json['kindId'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    orderNo = json['orderNo'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kindId'] = this.kindId;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['orderNo'] = this.orderNo;
    data['status'] = this.status;

    return data;
  }
}