import 'package:code_zero/app/modules/mine/red_envelope_withdrawal/custom_stepper.dart'
as customStepper;
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/S.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'red_envelope_withdrawal_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RedEnvelopeWithdrawalPage
    extends GetView<RedEnvelopeWithdrawalController> {
  const RedEnvelopeWithdrawalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg_gray,
      appBar: CommonAppBar(
        titleText: "红包提现",
        centerTitle: true,
      ),
      body: Obx(
            () =>
            FTStatusPage(
              type: controller.pageStatus.value,
              errorMsg: controller.errorMsg.value,
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    Image.asset('assets/icons/task_bg.png'),
                    Column(
                      children: [
                        SizedBox(
                          height: 14.w,
                        ),
                        _buildTitle(),
                        SizedBox(
                          height: 14.w,
                        ),
                        _buildTaskNum(),
                        SizedBox(
                          height: 14.w,
                        ),
                        _buildTaskList()
                      ],
                    )
                  ],
                );
              },
            ),
      ),
    );
  }

  _buildTitle() {
    return RichText(
        text: TextSpan(children: [
          TextSpan(
              text: '尊敬的用户，截止',
              style: TextStyle(color: S.colors.white, fontSize: 12.sp)),
          TextSpan(text: controller.task.value?.expiredAt ?? ""),
          TextSpan(text: '您参与任务情况如下：')
        ]));
  }

  _buildTaskNum() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.task.value?.unfinishedOrderNum.toString() ?? "0",
                style: TextStyle(
                  fontSize: 24.sp,
                  color: S.colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 8.w,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "待完成单数",
                      // text: '00000000.00',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: S.colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.task.value?.completedOrderNum.toString() ?? "0",
                style: TextStyle(
                  fontSize: 24.sp,
                  color: S.colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 8.w,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "已完成单数",
                      // text: "00000000.00",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: S.colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  _buildTaskList() {
    return Expanded(
      child: Container(
        width: 345.w,
        decoration: BoxDecoration(
          color: AppColors.bg_gray,
          borderRadius: BorderRadius.all(
            Radius.circular(5.w),
          ),
        ),
        child: Column(
          children: [_buildListTitle(), _buildList()],
        ),
      ),
    );
  }

  Container _buildListTitle() {
    return Container(
      height: 50.w,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 15.w,
          ),
          Text(
            '任务详情',
            style: TextStyle(
                fontSize: 18.sp,
                color: Color(0xff111111),
                fontWeight: FontWeight.bold),
          ),
          Expanded(child: SizedBox()),
          Obx(() {
            return Container(
                decoration: BoxDecoration(
                    color: Color(0xffDBF1E0),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.w),
                        bottomLeft: Radius.circular(15.w))),
                padding: EdgeInsets.only(
                    left: 15.w, top: 6.w, bottom: 6.w, right: 6.w),
                child: controller.task.value?.isCompleted == 1
                    ? _doneHint()
                    : _undoneHint());
          }),
        ],
      ),
    );
  }

  _undoneHint() {
    return Obx(() {
      return RichText(
        text: TextSpan(
            text: '必须完成',
            style: TextStyle(fontSize: 12.sp, color: S.colors.black11),
            children: [
              TextSpan(
                  text:
                  controller.task.value?.taskItemList?.length.toString() ??
                      ""),
              TextSpan(text: '单，才能提现哦')
            ]),
      );
    });
  }

  _doneHint() {
    return Row(
      children: [
        Image.asset(
          'assets/images/shopping_cart/goods_selected.png',
          width: 17.w,
        ),
        SizedBox(
          width: 6.w,
        ),
        Text(
          '任务已达标，快去提现吧！',
          style: TextStyle(color: S.colors.black11, fontSize: 12.sp),
        )
      ],
    );
  }

  _buildList() {
    return Expanded(
        child: Container(
          width: double.infinity,
          color: S.colors.white,
          child: Column(
            children: [
              _buildStep(),
              _buildToWithdrawal(),
            ],
          ),
        ));
  }

  _buildStep() {
    var currentStep = 3;
    return Obx(() {
      if (controller.task.value?.taskItemList == null) {
        return Container();
      }
      return customStepper.CustomStepper(
        currentStep: currentStep,
        controlsBuilder:
            (BuildContext context, customStepper.ControlsDetails details) {
          return Row(
            children: <Widget>[],
          );
        },
        steps: controller.task.value!.taskItemList!
            .map((e) =>
            customStepper.Step(
              icon: Image.asset(
                e.isCompleted == 1
                    ? 'assets/icons/task_done.png'
                    : 'assets/icons/task_undone.png',
                width: 40.w,
                height: 40.w,
              ),
              title: Text(e.desc ?? "",
                  style:
                  TextStyle(fontSize: 15.sp, color: S.colors.black11)),
              subtitle: Text(
                e.completedAt ?? '',
                style: TextStyle(fontSize: 11.sp, color: Color(0xffABAAB9)),
              ),
              action: Container(
                padding: EdgeInsets.only(
                    top: 5.w, bottom: 5.w, left: 15.w, right: 15.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color((0xFFFF746D)),
                  borderRadius: BorderRadius.circular(22.w),
                ),
                child: Text(
                  e.isCompleted == 1 ? '已完成' : '去完成',
                  style: e.isCompleted == 1 ? TextStyle(
                    color: S.colors.text_dark,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ) : TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ))
            .toList(), /*<customStepper.Step>[

*/ /*
          customStepper.Step(
            icon: Image.asset(
              'assets/icons/task_undone.png',
              width: 40.w,
              height: 40.w,
            ),
            title: Text('完成抢购 3 单',
                style: TextStyle(fontSize: 15.sp, color: S.colors.black11)),
            subtitle: Text(
              '2022-11-01 14:28:04',
              style: TextStyle(fontSize: 11.sp, color: Color(0xffABAAB9)),
            ),
            action: Container(
              padding:
              EdgeInsets.only(top: 5.w, bottom: 5.w, left: 15.w, right: 15.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color((0xFFFF746D)),
                borderRadius: BorderRadius.circular(22.w),
              ),
              child: Text(
                '去完成',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          customStepper.Step(
              icon: Image.asset(
                'assets/icons/task_undone.png',
                width: 40.w,
                height: 40.w,
              ),
              title: Text('完成抢购 2 单',
                  style: TextStyle(fontSize: 15.sp, color: S.colors.black11)),
              subtitle: Text(
                '2022-11-01 14:28:04',
                style: TextStyle(fontSize: 11.sp, color: Color(0xffABAAB9)),
              ),
              action: Container(
                padding: EdgeInsets.only(
                    top: 5.w, bottom: 5.w, left: 15.w, right: 15.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color((0xFFFF746D)),
                  borderRadius: BorderRadius.circular(22.w),
                ),
                child: Text(
                  '去完成',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )),
          customStepper.Step(
              icon: Image.asset(
                'assets/icons/task_undone.png',
                width: 40.w,
                height: 40.w,
              ),
              title: Text('完成抢购 1 单',
                  style: TextStyle(fontSize: 15.sp, color: S.colors.black11)),
              subtitle: Text(
                '2022-11-01 14:28:04',
                style: TextStyle(fontSize: 11.sp, color: Color(0xffABAAB9)),
              ),
              state: customStepper.StepState.complete,
              action: Container(
                padding: EdgeInsets.only(
                    top: 5.w, bottom: 5.w, left: 15.w, right: 15.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color((0xFFF3F9FB)),
                  borderRadius: BorderRadius.circular(22.w),
                ),
                child: Text(
                  '已完成',
                  style: TextStyle(
                    color: S.colors.text_dark,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )),
          customStepper.Step(
              icon: Image.asset(
                'assets/icons/reg_suc.png',
                width: 40.w,
                height: 40.w,
              ),
              title: Text('注册完成',
                  style: TextStyle(fontSize: 15.sp, color: S.colors.black11)),
              subtitle: Text(
                '2022-11-01 14:28:04',
                style: TextStyle(fontSize: 11.sp, color: Color(0xffABAAB9)),
              ),
              state: customStepper.StepState.complete,
              action: Container(
                padding: EdgeInsets.only(
                    top: 5.w, bottom: 5.w, left: 15.w, right: 15.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color((0xFFF3F9FB)),
                  borderRadius: BorderRadius.circular(22.w),
                ),
                child: Text(
                  '已完成',
                  style: TextStyle(
                    color: S.colors.text_dark,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ))*/ /*
        ],*/
      );
    });
  }

  _buildToWithdrawal() {
    return Obx(() {
      return SafeTapWidget(
        onTap: () {
          if(controller.task.value?.isCompleted == 1) {
            Get.toNamed(RoutesID.DRAWING_PAGE);
          }
        },
        child: Container(
          width: 315.w,
          height: 44.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color((0xFFFF746D)).withOpacity(controller.task.value?.isCompleted == 1 ? 1 : 0.4),
            borderRadius: BorderRadius.circular(22.w),
          ),
          child: Text(
            '去提现',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }
}
