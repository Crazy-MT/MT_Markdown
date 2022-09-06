import 'package:code_zero/network/convert_interface.dart';

class ShoppingCartListModel extends ConvertInterface {
  List<ShoppingCartItem>? items;

  ShoppingCartListModel({this.items});

  ShoppingCartListModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ShoppingCartItem>[];
      json['items'].forEach((v) {
        items!.add(new ShoppingCartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return ShoppingCartListModel.fromJson(json);
  }
}

class ShoppingCartItem {
  int? id;
  int? userId;
  int? commodityId;
  String? commodityName;
  double? commodityPrice;
  int? commodityCount;
  String? commodityThumbnail;

  ShoppingCartItem({this.id, this.userId, this.commodityId, this.commodityName, this.commodityPrice, this.commodityCount, this.commodityThumbnail});

  ShoppingCartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    commodityId = json['commodityId'];
    commodityName = json['commodityName'];
    commodityPrice = double.tryParse(json['commodityPrice'].toString());
    commodityCount = json['commodityCount'];
    commodityThumbnail = json['commodityThumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['commodityId'] = this.commodityId;
    data['commodityName'] = this.commodityName;
    data['commodityPrice'] = this.commodityPrice;
    data['commodityCount'] = this.commodityCount;
    data['commodityThumbnail'] = this.commodityThumbnail;
    return data;
  }
}
