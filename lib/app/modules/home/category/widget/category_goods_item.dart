import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common/S.dart';

class CategoryGoodsItem extends StatelessWidget {
  final CommodityItem item;
  const CategoryGoodsItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeTapWidget(
      onTap: () {
        Get.toNamed(RoutesID.GOODS_DETAIL_PAGE, arguments: {
          "from": RoutesID.CATEGORY_PAGE,
          "good": item,
          // "startTime": Get.arguments['startTime'],
          // "endTime": Get.arguments['endTime'],
        });
      },
      child: Container(
        height: 110.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: item.thumbnails?.first ?? "",
                width: 90.w,
                height: 90.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? "",
                    style: TextStyle(
                      color: Color(0xff141519),
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 10.w,),
                  _priceAndCount(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceAndCount() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '￥',
          style: TextStyle(
            color: Color(0xFFD0A06D),
            fontSize: 12.sp,
          ),
        ),
        Text(
          item.currentPrice ?? "",
          style: TextStyle(
            color: Color(0xFFD0A06D),
            fontSize: 18.sp,
          ),
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }
}
