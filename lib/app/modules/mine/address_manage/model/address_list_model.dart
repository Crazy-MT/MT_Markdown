import 'package:code_zero/network/convert_interface.dart';

class AddressListModel extends ConvertInterface {
  List<AddressItem>? items;

  AddressListModel({this.items});

  @override
  fromJson(Map<String, dynamic> json) {
    return AddressListModel.fromJson(json);
  }

  AddressListModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <AddressItem>[];
      json['items'].forEach((v) {
        items!.add(new AddressItem.fromJson(v));
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
}

class AddressItem {
  int? id;
  String? consignee;
  String? phone;
  String? region;
  String? address;
  int? isDefault;
  int? userId;

  AddressItem({this.id, this.consignee, this.phone, this.region, this.address, this.isDefault, this.userId});

  AddressItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    consignee = json['consignee'];
    phone = json['phone'];
    region = json['region'];
    address = json['address'];
    isDefault = json['isDefault'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['consignee'] = this.consignee;
    data['phone'] = this.phone;
    data['region'] = this.region;
    data['address'] = this.address;
    data['isDefault'] = this.isDefault;
    data['userId'] = this.userId;
    return data;
  }
}
