import '../../../../../network/convert_interface.dart';

class CommodityModel extends ConvertInterface {
    CommodityModel({
        this.items,
        this.totalCount,
    });

    List<CommodityItem>? items;
    int? totalCount;

    Map<String, dynamic> toJson() => {
        "items": items == null ? List<dynamic>.from(items!.map((x) => x.toJson())) : [],
        "totalCount": totalCount,
    };

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) => CommodityModel(
      items: List<CommodityItem>.from(json["items"].map((x) => CommodityItem.fromJson(x))),
      totalCount: json["totalCount"],
  );
}

class CommodityItem {
    CommodityItem({
        this.id,
        this.name,
        this.commodityType,
        this.sessionId,
        this.sessionName,
        this.categoryId,
        this.categoryName,
        this.originalPrice,
        this.currentPrice,
        this.orderNo,
        this.showParams,
        this.isDelete,
        this.status,
        this.shelfId,
        this.shelfNickname,
        this.shelfPhone,
        this.shelfAt,
        this.ownerIsAdmin,
        this.inventory,
        this.transCount,
        this.thumbnails,
        this.parameterImages,
        this.images,
    });

    int? id;
    String? name;
    int? commodityType;
    int? sessionId;
    String? sessionName;
    int? categoryId;
    String? categoryName;
    String? originalPrice;
    String? currentPrice;
    int? orderNo;
    List<Map>? showParams;
    int? isDelete;
    int? status;
    int? shelfId;
    String? shelfNickname;
    String? shelfPhone;
    DateTime? shelfAt;
    int? ownerIsAdmin;
    int? inventory;
    int? transCount;
    List<String>? thumbnails;
    List<String>? parameterImages;
    List<String>? images;

    factory CommodityItem.fromJson(Map<String, dynamic> json) => CommodityItem(
        id: json["id"],
        name: json["name"],
        commodityType: json["commodityType"],
        sessionId: json["sessionId"],
        sessionName: json["sessionName"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        originalPrice: json["originalPrice"],
        currentPrice: json["currentPrice"],
        orderNo: json["orderNo"],
        showParams: List<Map>.from(json["showParams"]),
        isDelete: json["isDelete"],
        status: json["status"],
        shelfId: json["shelfId"],
        shelfNickname: json["shelfNickname"],
        shelfPhone: json["shelfPhone"],
        shelfAt: DateTime.parse(json["shelfAt"]),
        ownerIsAdmin: json["ownerIsAdmin"],
        inventory: json["inventory"],
        transCount: json["transCount"],
        thumbnails: List<String>.from(json["thumbnails"].map((x) => x)),
        parameterImages: List<String>.from(json["parameterImages"].map((x) => x)),
        images: List<String>.from(json["images"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "commodityType": commodityType,
        "sessionId": sessionId,
        "sessionName": sessionName,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "originalPrice": originalPrice,
        "currentPrice": currentPrice,
        "orderNo": orderNo,
        "showParams": showParams != null ? showParams : [],
        "isDelete": isDelete,
        "status": status,
        "shelfId": shelfId,
        "shelfNickname": shelfNickname,
        "shelfPhone": shelfPhone,
        "shelfAt": shelfAt?.toIso8601String(),
        "ownerIsAdmin": ownerIsAdmin,
        "inventory": inventory,
        "transCount": transCount,
        "thumbnails": thumbnails != null ? List<dynamic>.from(thumbnails!.map((x) => x)) : [],
        "parameterImages": parameterImages != null ? List<dynamic>.from(parameterImages!.map((x) => x))  : [],
        "images": images != null ? List<dynamic>.from(images!.map((x) => x)) : [],
    };
}