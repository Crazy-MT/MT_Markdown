import 'package:code_zero/network/convert_interface.dart';

class SelfOrderListModel extends ConvertInterface{
  List<SelfOrderItems>? items;
  int? totalCount;

  SelfOrderListModel({this.items, this.totalCount});

  SelfOrderListModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <SelfOrderItems>[];
      json['items'].forEach((v) {
        items!.add(new SelfOrderItems.fromJson(v));
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
    return SelfOrderListModel.fromJson(json);
  }
}

class SelfOrderItems {
  int? id;
  int? tradeState;
  String? tradeStateDesc;
  String? amount;
  int? paidAmount;
  String? newPrice;
  String? outTradeNo;
  String? createdAt;
  String? updatedAt;
  int? tradeMethod;
  String? tradeTime;
  String? paymentFlowNo;
  String? successTime;
  int? userId;
  String? nickname;
  String? phone;
  String? receiptConsignee;
  String? receiptPhone;
  String? receiptRegion;
  String? receiptAddress;
  int? buyingTransactionId;
  int? commodityId;
  String? commodityName;
  int? tradeCategory;
  String? tradeCategoryDesc;
  int? tradeType;
  String? bankType;
  int? isNotify;

  SelfOrderItems(
      {this.id,
      this.tradeState,
      this.tradeStateDesc,
      this.amount,
      this.paidAmount,
      this.newPrice,
      this.outTradeNo,
      this.createdAt,
      this.updatedAt,
      this.tradeMethod,
      this.tradeTime,
      this.paymentFlowNo,
      this.successTime,
      this.userId,
      this.nickname,
      this.phone,
      this.receiptConsignee,
      this.receiptPhone,
      this.receiptRegion,
      this.receiptAddress,
      this.buyingTransactionId,
      this.commodityId,
      this.commodityName,
      this.tradeCategory,
      this.tradeCategoryDesc,
      this.tradeType,
      this.bankType,
      this.isNotify});

  SelfOrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tradeState = json['tradeState'];
    tradeStateDesc = json['tradeStateDesc'];
    amount = json['amount'];
    paidAmount = json['paidAmount'];
    newPrice = json['newPrice'];
    outTradeNo = json['outTradeNo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    tradeMethod = json['tradeMethod'];
    tradeTime = json['tradeTime'];
    paymentFlowNo = json['paymentFlowNo'];
    successTime = json['successTime'];
    userId = json['userId'];
    nickname = json['nickname'];
    phone = json['phone'];
    receiptConsignee = json['receiptConsignee'];
    receiptPhone = json['receiptPhone'];
    receiptRegion = json['receiptRegion'];
    receiptAddress = json['receiptAddress'];
    buyingTransactionId = json['buyingTransactionId'];
    commodityId = json['commodityId'];
    commodityName = json['commodityName'];
    tradeCategory = json['tradeCategory'];
    tradeCategoryDesc = json['tradeCategoryDesc'];
    tradeType = json['tradeType'];
    bankType = json['bankType'];
    isNotify = json['isNotify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tradeState'] = this.tradeState;
    data['tradeStateDesc'] = this.tradeStateDesc;
    data['amount'] = this.amount;
    data['paidAmount'] = this.paidAmount;
    data['newPrice'] = this.newPrice;
    data['outTradeNo'] = this.outTradeNo;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['tradeMethod'] = this.tradeMethod;
    data['tradeTime'] = this.tradeTime;
    data['paymentFlowNo'] = this.paymentFlowNo;
    data['successTime'] = this.successTime;
    data['userId'] = this.userId;
    data['nickname'] = this.nickname;
    data['phone'] = this.phone;
    data['receiptConsignee'] = this.receiptConsignee;
    data['receiptPhone'] = this.receiptPhone;
    data['receiptRegion'] = this.receiptRegion;
    data['receiptAddress'] = this.receiptAddress;
    data['buyingTransactionId'] = this.buyingTransactionId;
    data['commodityId'] = this.commodityId;
    data['commodityName'] = this.commodityName;
    data['tradeCategory'] = this.tradeCategory;
    data['tradeCategoryDesc'] = this.tradeCategoryDesc;
    data['tradeType'] = this.tradeType;
    data['bankType'] = this.bankType;
    data['isNotify'] = this.isNotify;
    return data;
  }

  getTradeMethod() {
    switch (tradeMethod) {
      case 0:
        return "其它方式";
      case 1:
        return "微信支付";
      case 2:
        return "支付宝支付";
      case 3:
        return "银行卡支付";
    }
    return "其它方式";
  }

}
