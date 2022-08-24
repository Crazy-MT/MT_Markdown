import 'package:code_zero/network/convert_interface.dart';

class EditAddressModel extends ConvertInterface {
  int? rows;

  EditAddressModel({this.rows});

  @override
  fromJson(Map<String, dynamic> json) {
    return EditAddressModel.fromJson(json);
  }

  EditAddressModel.fromJson(Map<String, dynamic> json) {
    rows = json['rows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rows'] = this.rows;
    return data;
  }
}
