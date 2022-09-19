import 'package:code_zero/network/convert_interface.dart';

class ChargeModel extends ConvertInterface{
  int? id;
  String? outTradeNo;
  String? prepayId;
  String? partnerId;
  String? timeStamp;
  String? nonceStr;
  String? package;
  String? sign;
  int? tradeState;

  ChargeModel(
      {this.id,
      this.outTradeNo,
      this.prepayId,
      this.partnerId,
      this.timeStamp,
      this.nonceStr,
      this.package,
        this.tradeState,
      this.sign});

  ChargeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outTradeNo = json['outTradeNo'];
    prepayId = json['prepayId'];
    partnerId = json['partnerId'];
    timeStamp = json['timeStamp'];
    nonceStr = json['nonceStr'];
    package = json['package'];
    sign = json['sign'];
    tradeState = json['tradeState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['outTradeNo'] = this.outTradeNo;
    data['prepayId'] = this.prepayId;
    data['partnerId'] = this.partnerId;
    data['timeStamp'] = this.timeStamp;
    data['nonceStr'] = this.nonceStr;
    data['package'] = this.package;
    data['sign'] = this.sign;
    data['tradeState'] = this.tradeState;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return ChargeModel.fromJson(json);
  }
}
