import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'c2c_risk_controller.dart';

class C2cRiskPage extends GetView<C2cRiskController> {
  const C2cRiskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        titleText: "C2C个人支付风险提示",
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF14181F),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "C2C个人支付风险提示",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF111111),
                      ),
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    Text(
                      '''
温馨提示:

线下付款时，不推荐您使用花呗或信用卡付款,有政策违规风险,由此造成的个人损失,后果自担,请您谨慎操作!线下收款时，不推荐您使用商家收款码收款,面临被第三方支付公司直接扣除收款手续费的风险,由此造成的个人损失,后果自担,请您谨慎操作!

1.用户在委托转卖、购买商品的支付方式为买家个人对卖家个人的支付方式。卖家需向买家提供实名认证的银行账户支付方式

2.买家在付款的时候，请核实卖家的信息是否为真实信息,是否是为实名认证，是否信息正确。确认信息无误后，方可向卖家付款。

3.在付款过程中，若发现卖家的账号异常或信息未实名认证,请谨慎付款。-旦付款,所造成的经济损失,均由买家自行承担，与本平台无关。

4买家付款后，卖家并未收到款，提供的付款信息错误或账户异常等。请点击订单投诉。

5.买家付款后，卖家并点击确认收款,请与卖家电话或微信等方式沟通协商,若卖家依旧不点击“确认收款" ,请联系本平台介入进行查明原因,并协调处理。6.以上所有的支付行为,均为用户自愿行为.本平台不收取任何的费用。若出现任何支付风险,造成财产经济损失,均由客户自行承担，本平台协助协调或协助司法机关追究违约方，但本平台不承担因C2C自由交易带来的财产损失的连带责任。
''',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF111111),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
