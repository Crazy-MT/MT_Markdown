import 'package:photo_view/photo_view.dart';

import 'photo_view_controller.dart' as a;
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoViewPage extends GetView<a.PhotoViewController> {
  const PhotoViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(
        Get.arguments?['url'] ?? "",
        // maxWidth: 115,
        // maxHeight: 123,
        // fit: BoxFit.fitWidth,
      ),
    );
  }
}
