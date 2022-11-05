import 'package:code_zero/network/convert_interface.dart';

class AppVersions extends ConvertInterface{
  List<Items>? items;
  int? totalCount;

  AppVersions({this.items, this.totalCount});

  AppVersions.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
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
    return AppVersions.fromJson(json);
  }
}

class Items {
  int? id;
  String? versionNum;
  String? androidDownloadUrl;
  String? updateDesc;

  Items({this.id, this.versionNum, this.androidDownloadUrl, this.updateDesc});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    versionNum = json['versionNum'];
    androidDownloadUrl = json['androidDownloadUrl'];
    updateDesc = json['updateDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['versionNum'] = this.versionNum;
    data['androidDownloadUrl'] = this.androidDownloadUrl;
    data['updateDesc'] = this.updateDesc;
    return data;
  }
}
