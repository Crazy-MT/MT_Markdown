// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:mt_markdown/app/modules/markdown/custom_node.dart';
import 'package:mt_markdown/app/modules/markdown/main_markdown/main_markdown_controller.dart';
import 'package:mt_markdown/common/common.dart';
import 'package:mt_markdown/utils/log_utils.dart';
import 'package:mt_markdown/utils/platform_detector/platform_detector.dart';
import 'package:cross_file/cross_file.dart';
import 'package:date_format/date_format.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:re_editor/re_editor.dart';
import 'package:url_launcher/url_launcher.dart';

import 'editor_large_text.dart';
import 'markdown_page.dart';
import 'package:flutter_highlight/themes/a11y-light.dart';

class EditMarkdownPage extends StatefulWidget {
  final TextEditingController? controller;
  final CodeLineEditingController? codeLineEditingController;

  final String title;
  final String filePath;

  const EditMarkdownPage(
      {Key? key,
      this.controller,
      required this.title,
      required this.filePath,
      required this.codeLineEditingController})
      : super(key: key);

  @override
  _EditMarkdownPageState createState() => _EditMarkdownPageState();
}

class _EditMarkdownPageState extends State<EditMarkdownPage> {
  bool isPreviewDisplaying = false;
  bool isTaped = false;
  CodeScrollController _scrollController = CodeScrollController();
  double _scrollProgress = 0.0;

  var _tocController = TocController();

  bool get isMobile =>
      PlatformDetector.isAllMobile; // mobile or web-android/web-iOS

  TextEditingController _searchController = TextEditingController();
  List<TextSpan> _highlightedTextSpans = [];

/*
  void _search(String query) {
    String content = widget.controller?.text ?? "";
    _highlightedTextSpans.clear();

    int startIndex = 0;
    while (startIndex < content.length) {
      int index = content.indexOf(query, startIndex);
      if (index == -1) break;

      _highlightedTextSpans.add(TextSpan(
        text: content.substring(startIndex, index),
        style: TextStyle(color: Colors.black),
      ));
      _highlightedTextSpans.add(TextSpan(
        text: query,
        style: TextStyle(backgroundColor: Colors.yellow, color: Colors.black),
      ));
      startIndex = index + query.length;
      widget.controller?.selection =
          TextSelection(baseOffset: startIndex, extentOffset: index);
    }
    _highlightedTextSpans.add(TextSpan(
      text: content.substring(startIndex),
      style: TextStyle(color: Colors.black),
    ));
    lLog(
        'MTMTMT _EditMarkdownPageState._search ${_highlightedTextSpans.length} ');
    setState(() {});
  }
*/

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

    _scrollController.verticalScroller.addListener(_updateScrollProgress);

    eventBus.on().listen((event) async {
      if (event == "save") {
        if (widget.filePath.isEmpty) {
          final FileSaveLocation? result =
              await getSaveLocation(suggestedName: widget.title);
          if (result == null) {
            showToast('保存失败');
            return;
          }
          await saveFile(result.path);
          XFile xFile = XFile(result.path);
          lLog('MTMTMT _EditMarkdownPageState.initState ${xFile.name} ');
          Get.find<MainMarkdownController>().modifyLast(
              name: xFile.name,
              path: result.path,
              lastModified: formatDate(DateTime.now(),
                  [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]));
          // widget.controller?.text = "";
        } else {
          await saveFile(widget.filePath);
          Get.find<MainMarkdownController>().modifyLast(
              path: widget.filePath,
              lastModified: formatDate(DateTime.now(),
                  [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]));
        }
      }

      /*if (event == "search") {
        lLog('MTMTMT _EditMarkdownPageState.initState search} ');
        *//*setState(() {
          widget.controller?.text = '### nihao';
        });*//*
        // _search("down");
      }*/
    });
  }

  void _updateScrollProgress() {
    setState(() {
      _scrollProgress = _scrollController.verticalScroller.offset /
          _scrollController.verticalScroller.position.maxScrollExtent;
      int toc = (_tocController.tocList.length * _scrollProgress).toInt();
      if (toc < _tocController.tocList.length) {
        _tocController.jumpToIndex(_tocController.tocList[toc].widgetIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 40,
            child: Stack(children: [
              Center(child: Text(widget.title)),
              Positioned(
                right: 10,
                top: 0,
                bottom: 0,
                child: IconButton(
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      isPreviewDisplaying = !isPreviewDisplaying;
                    });
                  },
                  icon: Icon(
                    isPreviewDisplaying
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye,
                    size: 20,
                  ),
                ),
              ),
              Positioned(
                right: 50,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onTapUp: (_) {
                    setState(() {
                      isTaped = false;
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      isTaped = true;
                      saveFile(widget.filePath);
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      isTaped = false;
                    });
                  },
                  child: Icon(
                    isTaped ? Icons.save_as : Icons.save,
                    size: 20,
                  ),
                ),
              )
            ]),
          ),
          Expanded(child: buildDisplay()),
        ],
      ),
      floatingActionButton: isMobile
          ? FloatingActionButton(
              onPressed: () {
                isPreviewDisplaying = !isPreviewDisplaying;
                refresh();
              },
              child: Icon(
                isPreviewDisplaying
                    ? Icons.remove_red_eye_outlined
                    : Icons.remove_red_eye,
              ),
            )
          : null,
    );
  }

  Widget buildDisplay() {
    // preview
    if (isPreviewDisplaying)
      return MarkdownPage(markdownData: widget.controller?.text);
    return buildEditor();
  }

  Widget buildEditor() => isMobile ? buildMobileBody() : buildClientBody();

  Widget buildMobileBody() {
    return buildEditText();
  }

  Widget buildClientBody() {
    return Row(
      children: <Widget>[
        Expanded(child: buildEditText()),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: MarkdownWidget(
              tocController: _tocController,
              data: widget.controller?.text ?? "",
              config: MarkdownConfig(configs: [
                PreConfig(theme: a11yLightTheme),
              ]),
              markdownGeneratorConfig: MarkdownGeneratorConfig(
                  generators: [],
                  inlineSyntaxList: [],
                  textGenerator: (node, config, visitor) =>
                      CustomTextNode(node.textContent, config, visitor)),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEditText() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.all(Radius.circular(30)),
        border: Border(
            right: BorderSide(
          color: Colors.grey,
          width: 1,
        )),
      ),
      // child: LargeTextEditor(),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification &&
              notification.depth == 0) {
            _updateScrollProgress();
          }
          return false;
        },
        child: LargeTextEditor(
          codeLineEditingController: widget.codeLineEditingController,
          data: widget.controller?.text ?? "",
          onChanged: (text) {
            if (widget.title == '未命名' && text.contains('\n')) {
              Get.find<MainMarkdownController>().modifyLast(
                  name: text.split('\n').first + ".md",
                  lastModified: formatDate(DateTime.now(),
                      [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]));
            }
            widget.controller?.text = text;
            refresh();
          },
          scrollController: _scrollController,
        ),
      ),
    );
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  Future saveFile(String filePath) async {
    File file = File(filePath);
    try {
      await file.writeAsString(widget.controller?.text ?? "").then(
            (value) => showToast("保存成功"),
          );
    } catch (_) {
      showToast("保存失败");
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.dispose();

    _scrollController.dispose();
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
