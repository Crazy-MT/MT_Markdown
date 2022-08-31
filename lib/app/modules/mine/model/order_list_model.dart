import 'package:code_zero/network/convert_interface.dart';

class OrderListModel extends ConvertInterface {
  List<OrderItem>? items;
  int? totalCount;

  OrderListModel({this.items, this.totalCount});

  @override
  fromJson(Map<String, dynamic> json) {
    return OrderListModel.fromJson(json);
  }

  OrderListModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <OrderItem>[];
      json['items'].forEach((v) {
        items!.add(new OrderItem.fromJson(v));
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
}

class OrderItem {
  int? id;
  int? tradeState;
  String? price;
  String? newPrice;
  String? charge;
  String? commission;
  String? tradeNo;
  int? tradeMethod;
  String? createdAt;
  int? hasTrade;
  String? tradeTime;
  int? hasConfirm;
  String? confirmTime;
  int? hasDeliver;
  String? deliverTime;
  int? hasReceive;
  String? receiveTime;
  int? hasShelf;
  String? shelfTime;
  int? hasCancel;
  String? cancelTime;
  int? hasComplete;
  String? completeTime;
  int? hasTradeUrl;
  String? tradeUrl;
  int? fromUserIsAdmin;
  int? fromUserId;
  String? fromUserNickname;
  String? fromUserPhone;
  int? toUserId;
  String? toUserNickname;
  String? toUserPhone;
  int? toUserFromUserId;
  String? toUserFromUserNickname;
  int? toUserFromUserFromUserId;
  String? toUserFromUserFromUserNickname;
  int? commodityId;
  String? thumbnailUrl;
  int? sessionId;
  String? sessionName;
  String? name;
  String? consignee;
  String? phone;
  String? region;
  String? address;
  int? parentId;

  OrderItem(
      {this.id,
      this.tradeState,
      this.price,
      this.newPrice,
      this.charge,
      this.commission,
      this.tradeNo,
      this.tradeMethod,
      this.createdAt,
      this.hasTrade,
      this.tradeTime,
      this.hasConfirm,
      this.confirmTime,
      this.hasDeliver,
      this.deliverTime,
      this.hasReceive,
      this.receiveTime,
      this.hasShelf,
      this.shelfTime,
      this.hasCancel,
      this.cancelTime,
      this.hasComplete,
      this.completeTime,
      this.hasTradeUrl,
      this.tradeUrl,
      this.fromUserIsAdmin,
      this.fromUserId,
      this.fromUserNickname,
      this.fromUserPhone,
      this.toUserId,
      this.toUserNickname,
      this.toUserPhone,
      this.toUserFromUserId,
      this.toUserFromUserNickname,
      this.toUserFromUserFromUserId,
      this.toUserFromUserFromUserNickname,
      this.commodityId,
      this.thumbnailUrl,
      this.sessionId,
      this.sessionName,
      this.name,
      this.consignee,
      this.phone,
      this.region,
      this.address,
      this.parentId});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tradeState = json['tradeState'];
    price = json['price'];
    newPrice = json['newPrice'];
    charge = json['charge'];
    commission = json['commission'];
    tradeNo = json['tradeNo'];
    tradeMethod = json['tradeMethod'];
    createdAt = json['createdAt'];
    hasTrade = json['hasTrade'];
    tradeTime = json['tradeTime'];
    hasConfirm = json['hasConfirm'];
    confirmTime = json['confirmTime'];
    hasDeliver = json['hasDeliver'];
    deliverTime = json['deliverTime'];
    hasReceive = json['hasReceive'];
    receiveTime = json['receiveTime'];
    hasShelf = json['hasShelf'];
    shelfTime = json['shelfTime'];
    hasCancel = json['hasCancel'];
    cancelTime = json['cancelTime'];
    hasComplete = json['hasComplete'];
    completeTime = json['completeTime'];
    hasTradeUrl = json['hasTradeUrl'];
    tradeUrl = json['tradeUrl'];
    fromUserIsAdmin = json['fromUserIsAdmin'];
    fromUserId = json['fromUserId'];
    fromUserNickname = json['fromUserNickname'];
    fromUserPhone = json['fromUserPhone'];
    toUserId = json['toUserId'];
    toUserNickname = json['toUserNickname'];
    toUserPhone = json['toUserPhone'];
    toUserFromUserId = json['toUserFromUserId'];
    toUserFromUserNickname = json['toUserFromUserNickname'];
    toUserFromUserFromUserId = json['toUserFromUserFromUserId'];
    toUserFromUserFromUserNickname = json['toUserFromUserFromUserNickname'];
    commodityId = json['commodityId'];
    thumbnailUrl = json['thumbnailUrl'];
    sessionId = json['sessionId'];
    sessionName = json['sessionName'];
    name = json['name'];
    consignee = json['consignee'];
    phone = json['phone'];
    region = json['region'];
    address = json['address'];
    parentId = json['parentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tradeState'] = this.tradeState;
    data['price'] = this.price;
    data['newPrice'] = this.newPrice;
    data['charge'] = this.charge;
    data['commission'] = this.commission;
    data['tradeNo'] = this.tradeNo;
    data['tradeMethod'] = this.tradeMethod;
    data['createdAt'] = this.createdAt;
    data['hasTrade'] = this.hasTrade;
    data['tradeTime'] = this.tradeTime;
    data['hasConfirm'] = this.hasConfirm;
    data['confirmTime'] = this.confirmTime;
    data['hasDeliver'] = this.hasDeliver;
    data['deliverTime'] = this.deliverTime;
    data['hasReceive'] = this.hasReceive;
    data['receiveTime'] = this.receiveTime;
    data['hasShelf'] = this.hasShelf;
    data['shelfTime'] = this.shelfTime;
    data['hasCancel'] = this.hasCancel;
    data['cancelTime'] = this.cancelTime;
    data['hasComplete'] = this.hasComplete;
    data['completeTime'] = this.completeTime;
    data['hasTradeUrl'] = this.hasTradeUrl;
    data['tradeUrl'] = this.tradeUrl;
    data['fromUserIsAdmin'] = this.fromUserIsAdmin;
    data['fromUserId'] = this.fromUserId;
    data['fromUserNickname'] = this.fromUserNickname;
    data['fromUserPhone'] = this.fromUserPhone;
    data['toUserId'] = this.toUserId;
    data['toUserNickname'] = this.toUserNickname;
    data['toUserPhone'] = this.toUserPhone;
    data['toUserFromUserId'] = this.toUserFromUserId;
    data['toUserFromUserNickname'] = this.toUserFromUserNickname;
    data['toUserFromUserFromUserId'] = this.toUserFromUserFromUserId;
    data['toUserFromUserFromUserNickname'] =
        this.toUserFromUserFromUserNickname;
    data['commodityId'] = this.commodityId;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['sessionId'] = this.sessionId;
    data['sessionName'] = this.sessionName;
    data['name'] = this.name;
    data['consignee'] = this.consignee;
    data['phone'] = this.phone;
    data['region'] = this.region;
    data['address'] = this.address;
    data['parentId'] = this.parentId;
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
