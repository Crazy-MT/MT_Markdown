import 'package:code_zero/network/convert_interface.dart';

class WalletModel extends ConvertInterface {
  String? points;
  String? balance;

  WalletModel({this.points, this.balance});

  WalletModel.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    data['balance'] = this.balance;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return WalletModel.fromJson(json);
  }
}
