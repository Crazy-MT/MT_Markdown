// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:code_zero/app/modules/markdown/custom_node.dart';
import 'package:code_zero/utils/platform_detector/platform_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'markdown_page.dart';

class EditMarkdownPage extends StatefulWidget {
  // final String initialData;
  final TextEditingController? controller;

  const EditMarkdownPage({Key? key, this.controller}) : super(key: key);

  @override
  _EditMarkdownPageState createState() => _EditMarkdownPageState();
}

class _EditMarkdownPageState extends State<EditMarkdownPage> {
  bool isMobileDisplaying = false;

  bool get isMobile => PlatformDetector.isAllMobile;

  @override
  void initState() {
    // final text = widget.initialData;
    // controller = TextEditingController(text: text);
    /*if (text.isEmpty) {
      rootBundle.loadString('assets/editor.md').then((value) {
        controller.text = value;
        refresh();
      });
    }*/
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildDisplay(),
      floatingActionButton: isMobile
          ? FloatingActionButton(
              onPressed: () {
                isMobileDisplaying = !isMobileDisplaying;
                refresh();
              },
              child: Icon(
                isMobileDisplaying
                    ? Icons.remove_red_eye_outlined
                    : Icons.remove_red_eye,
              ),
            )
          : null,
    );
  }

  Widget buildDisplay() {
    if (isMobileDisplaying) return MarkdownPage(markdownData: widget.controller?.text);
    return buildEditor();
  }

  Widget buildEditor() => isMobile ? buildMobileBody() : buildWebBody();

  Widget buildMobileBody() {
    return buildEditText();
  }

  Widget buildWebBody() {
    return Row(
      children: <Widget>[
        Expanded(child: buildEditText()),
        Expanded(
          child: MarkdownWidget(
            data:  widget.controller?.text ?? "",
            config: MarkdownConfig.defaultConfig,
            markdownGeneratorConfig: MarkdownGeneratorConfig(
                generators: [],
                inlineSyntaxList: [],
                textGenerator: (node, config, visitor) =>
                    CustomTextNode(node.textContent, config, visitor)),
          ),
        ),
      ],
    );
  }

  Widget buildEditText() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
      ),
      child: TextFormField(
        expands: true,
        maxLines: null,
        textInputAction: TextInputAction.newline,
        controller: widget.controller,
        onChanged: (text) {
          refresh();
        },
        style: TextStyle(textBaseline: TextBaseline.alphabetic),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            border: InputBorder.none,
            hintText: 'Input Here...',
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.dispose();
  }
}

launchURL(String? url) async {
  if (url == null) throw 'No url found!';
  Uri? uri = Uri.tryParse(url);
  if (uri == null) throw '$url unavailable';
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}
