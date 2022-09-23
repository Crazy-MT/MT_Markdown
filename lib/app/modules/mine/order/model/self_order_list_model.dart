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
  String? paidAmount;
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
  List<CommodityList>? commodityList;
  String? prepayId;
  String? partnerId;
  String? timeStamp;
  String? nonceStr;
  String? package;
  String? sign;
  String? courierCompany;
  String? trackingNumber;

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
      this.isNotify,
        this.prepayId,
        this.partnerId,
        this.timeStamp,
        this.nonceStr,
        this.package,
      this.sign,
      this.commodityList,
      this.courierCompany,
      this.trackingNumber});

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
    prepayId = json['prepayId'];
    partnerId = json['partnerId'];
    timeStamp = json['timeStamp'];
    nonceStr = json['nonceStr'];
    package = json['package'];
    sign = json['sign'];
    courierCompany = json['courierCompany'];
    trackingNumber = json['trackingNumber'];
    if (json['commodityList'] != null) {
      commodityList = <CommodityList>[];
      json['commodityList'].forEach((v) {
        commodityList!.add(new CommodityList.fromJson(v));
      });
    }
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
    if (this.commodityList != null) {
      data['commodityList'] =
          this.commodityList!.map((v) => v.toJson()).toList();
    }
    data['prepayId'] = this.prepayId;
    data['partnerId'] = this.partnerId;
    data['timeStamp'] = this.timeStamp;
    data['nonceStr'] = this.nonceStr;
    data['package'] = this.package;
    data['sign'] = this.sign;
    data['courierCompany'] = this.courierCompany;
    data['trackingNumber'] = this.trackingNumber;
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

class CommodityList {
  int? commodityId;
  String? commodityName;
  String? commodityThumbnailUrl;
  String? commodityPrice;
  int? commodityCount;
  int? payId;
  int? orderNo;
  int? id;

  CommodityList(
      {this.commodityId,
        this.commodityName,
        this.commodityThumbnailUrl,
        this.commodityPrice,
        this.commodityCount,
        this.payId,
        this.orderNo,
        this.id});

  CommodityList.fromJson(Map<String, dynamic> json) {
    commodityId = json['commodityId'];
    commodityName = json['commodityName'];
    commodityThumbnailUrl = json['commodityThumbnailUrl'];
    commodityPrice = json['commodityPrice'];
    commodityCount = json['commodityCount'];
    payId = json['payId'];
    orderNo = json['orderNo'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commodityId'] = this.commodityId;
    data['commodityName'] = this.commodityName;
    data['commodityThumbnailUrl'] = this.commodityThumbnailUrl;
    data['commodityPrice'] = this.commodityPrice;
    data['commodityCount'] = this.commodityCount;
    data['payId'] = this.payId;
    data['orderNo'] = this.orderNo;
    data['id'] = this.id;
    return data;
  }
}
