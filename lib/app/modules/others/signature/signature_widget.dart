import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as rotateImage;
import 'package:code_zero/app/modules/others/signature/flutter_signature_pad.dart';
import 'package:code_zero/app/modules/others/signature/signature_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_editor/image_editor.dart';
// import 'package:flutter_image_editor/flutter_image_editor.dart';
class SignatureWidget extends StatefulWidget {
  SignatureWidget({Key? key}) : super(key: key);

  @override
  _SignatureWidgetState createState() => _SignatureWidgetState();
}
class _SignatureWidgetState extends State<SignatureWidget> {
  ByteData _img = ByteData(0);
  var color = Colors.black;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Signature(
                color: color,
                key: _sign,
                onSign: () {
                  final sign = _sign.currentState;
                  debugPrint('${sign} points in the signature');
                },
                // backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                strokeWidth: strokeWidth,
              ),
            ),
            color: Colors.black12,
          ),
        ),
        _img.buffer.lengthInBytes == 0 ? Container() : LimitedBox(maxHeight: 200.0, child: Image.memory(_img.buffer.asUint8List())),
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                    color: Colors.green,
                    onPressed: () async {
                      final sign = _sign.currentState;
                      //retrieve image data, do whatever you want with it (send to server, save locally...)
                      final image = await sign?.getData();
                      ByteData? data = await image?.toByteData(format: ui.ImageByteFormat.png);
                      sign?.clear();
                      if(data != null) {

                        ImageEditorOption option = ImageEditorOption();
                        option.addOption(RotateOption(-90));
                        Uint8List? dataList =  await ImageEditor.editImage(image: data.buffer.asUint8List(), imageEditorOption: option);

                        // await PictureEditor.rotateImage(data.buffer.asUint8List(), 90);
                        // final encoded = base64.encode(data.buffer.asUint8List() );
                        setState(() {
                          _img = data;
                          Get.find<SignatureController>().saveSignature(dataList);
                        });
                      }

                    },
                    child: Text("Save")),
                MaterialButton(
                    color: Colors.grey,
                    onPressed: () {
                      final sign = _sign.currentState;
                      sign?.clear();
                      setState(() {
                        _img = ByteData(0);
                      });
                      debugPrint("cleared");
                    },
                    child: Text("Clear")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        color = color == Colors.green ? Colors.red : Colors.green;
                      });
                      debugPrint("change color");
                    },
                    child: Text("Change color")),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        int min = 1;
                        int max = 10;
                        int selection = min + (Random().nextInt(max - min));
                        strokeWidth = selection.roundToDouble();
                        debugPrint("change stroke width to $selection");
                      });
                    },
                    child: Text("Change stroke width")),
              ],
            ),
          ],
        )
      ],
    );
  }
}