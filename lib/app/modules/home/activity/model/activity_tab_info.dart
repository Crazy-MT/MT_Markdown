import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ActivityTabInfo {
  final String text;
  final int id;
  final RefreshController refreshController;
  int currentPage;
  RxList<CommodityItem> commodityList;
  var isChoose = false.obs;

  ActivityTabInfo(this.text, this.id, this.refreshController, this.currentPage,
      this.commodityList, this.isChoose);
}

class ActivityTab extends StatefulWidget {
  final String text;
  final bool choose;

  const ActivityTab({Key? key, required this.text, required this.choose})
      : super(key: key);

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Image.asset(widget.choose
              ? 'assets/images/activity/bg_tab_choose.png'
              : 'assets/images/activity/bg_tab_unchoose.png'),
          Row(
            children: [
              SizedBox(
                width: 4.w,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 10.w),
                decoration: BoxDecoration(
                  color: widget.choose ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.text,
                  style: TextStyle(fontFamily: 'TabTitle'),
                ),
              ),

              // SizedBox(width: 10.w,),
              Text(
                '专场',
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              )
            ],
          )
        ],
      ),
    );
  }
}
