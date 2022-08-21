import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class _BuyDialog extends StatelessWidget {
  final bool isAddToCat;

  const _BuyDialog({Key? key, required this.isAddToCat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        width: 375.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.w),
          ),
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 268.w,
                maxHeight: 420.w,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.w),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ff70181a20931f7807418b722b4accf9cbd89d0c6c08a-s3JzNf_fw658&refer=http%3A%2F%2Fhbimg.b0.upaiyun.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663056542&t=17f6675c5cb02a4c4c23dd11959387e9',
                            width: 120.w,
                            height: 120.w,
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 120.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.close_outlined,
                                      color: Color(0xFFABAAB9),
                                    ),
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "¥",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "30000",
                                        style: TextStyle(
                                          fontSize: 22.sp,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ".00",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4.w,
                                ),
                                Text(
                                  "库存：300件",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color(0xFFABAAB9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "数量",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text_dark,
                          ),
                        ),
                        Container(
                          width: 72.w,
                          height: 22.w,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12.w,
            ),
            SizedBox(
              width: 335.w,
              height: 44.w,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                ).copyWith(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.green,
                  ),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: Text(
                  isAddToCat ? "加入购物车" : "立即购买",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> showByDialog({bool isAddToCat = false}) async {
  var result = await showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _BuyDialog(
          isAddToCat: isAddToCat,
        );
      });
  return result is String ? result : "";
}
