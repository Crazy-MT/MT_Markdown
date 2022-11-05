import 'package:code_zero/network/convert_interface.dart';

class AppVersions extends ConvertInterface{
  int? id;
  String? versionNum;
  String? androidDownloadUrl;
  String? updateDesc;

  AppVersions({this.id, this.versionNum, this.androidDownloadUrl, this.updateDesc});

  AppVersions.fromJson(Map<String, dynamic> json) {
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

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return AppVersions.fromJson(json);
  }
}