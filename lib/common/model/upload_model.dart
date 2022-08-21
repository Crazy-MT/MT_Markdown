import '../../network/convert_interface.dart';

class UploadModel extends ConvertInterface {
  int? id;
  String? filename;
  String? filePath;
  String? fileUrl;
  String? createdAt;
  String? updatedAt;

  @override
  fromJson(Map<String, dynamic> json) {
    return UploadModel.fromJson(json);
  }

  UploadModel({this.id, this.filename, this.filePath, this.fileUrl, this.createdAt, this.updatedAt});

  UploadModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filename = json['filename'];
    filePath = json['filePath'];
    fileUrl = json['fileUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['filename'] = this.filename;
    data['filePath'] = this.filePath;
    data['fileUrl'] = this.fileUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
