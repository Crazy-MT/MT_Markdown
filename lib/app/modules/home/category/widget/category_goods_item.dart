import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/S.dart';

class CategoryGoodsItem extends StatelessWidget {
  const CategoryGoodsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl:
                  'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ff70181a20931f7807418b722b4accf9cbd89d0c6c08a-s3JzNf_fw658&refer=http%3A%2F%2Fhbimg.b0.upaiyun.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663056542&t=17f6675c5cb02a4c4c23dd11959387e9',
              width: 90.w,
              height: 90.w,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    '1019翡翠玻璃种镶玫瑰金叶子吊坠',
                    style: TextStyle(
                      color: Color(0xff141519),
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                _priceAndCount(),
              ],
            ),
          ),
        ],
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
            color: S.colors.red,
            fontSize: 10.sp,
          ),
        ),
        Text(
          '30000',
          style: TextStyle(
            color: S.colors.red,
            fontSize: 18.sp,
          ),
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }
}
