import 'package:code_zero/network/convert_interface.dart';

class CreateAddressModel extends ConvertInterface {
  int? id;

  CreateAddressModel({this.id});

  @override
  fromJson(Map<String, dynamic> json) {
    return CreateAddressModel.fromJson(json);
  }

  CreateAddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
