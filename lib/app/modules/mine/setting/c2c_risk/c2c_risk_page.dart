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
        titleText: "平台社区公约",
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
                    // Text(
                    //   "C2C个人支付风险提示",
                    //   style: TextStyle(
                    //     fontSize: 18.sp,
                    //     fontWeight: FontWeight.w500,
                    //     color: Color(0xFF111111),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20.w,
                    // ),
                    Text(
                      '''“让闲置流通起来”，我们认为建立彼此的信任是平台社区最重要的事情。为此，我们建立了《平台社区公约》（以下简称“《公约》”）来指引我们，让我们的闲置资源交易社区能更好地持续健康发展。

 

平台社区是我们大家共同的社区，不断完善我们的《公约》变得极为重要，我们会随时向我们的社区传递什么行为是我们反对的，什么行为是我们鼓励支持的，并根据情况适时修订《公约》。下面这三条公约是迄今为止我们从社区用户了解到的核心理念，我们会努力确保执行这些公约。

 

第一条 真实

既然我们认为建立彼此的信任是我们社区最重要的事情，那么网络社区中的您是否是一个真实的人就变得至关重要。虽然认证成本高昂，但我们依然相信，实人认证是真实的基础。当然您所有的信息安全和隐私都会被我们当成生命一样去重视和保护。

 

1、身份认证

通过实名认证：

当您登录平台社区发布信息、互动或交易时，需要先通过实名认证；

通过实人认证：

当您发布闲置物品、商品/服务时，需要先通过实人认证；

当然实人认证不是终身有效的，为了确保认证信息真实及持续有效，我们会在不同场景中要求您再次进行实人认证。

 

2、承诺履行

不论您在平台社区转让闲置还是社区互动，请遵守您与用户的约定并按约定履行，建立彼此信任从你我做起。

 

第二条 安全

只有当您觉得这个社区是安全的，一切才有可能。正因如此，安全是我们的重要条件。

1、非法、违规信息及行为严肃处置

平台用户在平台社区的行为、发布的物品、商品/服务及信息不得违反国家法律法规及平台社区相关要求，违规场景及处置措施详见《平台社区管理规范》；

2、担保交易保障交易安全

平台联合支付宝提供担保交易，保障您的钱款安全，买卖双方选择平台线上交易的，须遵守《平台交易超时说明》的相关要求，个人闲置物品、商品/服务不支持七天无理由退换货，双方另行约定的除外。

3、隐私保护

为了保障平台社区用户在社区中的安全，平台非常重视个人隐私保护，会积极维护网络数据和用户信息安全，严格按照法律及相关法规采取技术保护措施并进行安全评估。

用户不得发布或提供泄露他人隐私的信息，包括但不限于：公开他人真实姓名及身份证号、电话号码、住址等隐私信息。

 

第三条 平等

我们希望这里是闲置资源交易社区，希望每个人得到的机会都是平等的，让我们真正实现闲置资源的流通。

1、身份平等

我们彼此是平等的，因此每一次互动中都应该尊重对方。在遵守所有适用法律的基础上，社区用户公平享有闲置自由交易等权利。

平台用户交易遵循平等、公平、自愿的原则。

2、交易平等

平台社区是一个闲置交易社区，因此，我们鼓励闲置资源公平享有流通的权利。

本公约中已有规定的从本公约，本公约未有规定的依据《平台社区管理规范》等相关规则执行。

 

本公约生效时间为：2022年10月1日，最新修订时间为2022年11月25日。''',
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
