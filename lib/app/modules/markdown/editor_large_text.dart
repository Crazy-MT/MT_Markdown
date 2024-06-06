import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mt_markdown/app/modules/markdown/shortcuts_activators_builder.dart';
import 'package:mt_markdown/utils/log_utils.dart';
import 'package:re_editor/re_editor.dart';

import 'find.dart';
import 'menu.dart';

class LargeTextEditor extends StatefulWidget {
  final String data;
  final ValueChanged<String>? onChanged;
  final CodeScrollController? scrollController;
  final CodeLineEditingController? codeLineEditingController;

  const LargeTextEditor({
    required this.data,
    required this.codeLineEditingController,
    this.onChanged,
    this.scrollController
  });

  @override
  State<StatefulWidget> createState() => _LargeTextEditorState();
}

class _LargeTextEditorState extends State<LargeTextEditor> {
  // final CodeLineEditingController _controller = CodeLineEditingController();

  @override
  void didUpdateWidget(covariant LargeTextEditor oldWidget) {
    // _controller.text = widget.data;
    super.didUpdateWidget(oldWidget);

    // lLog('MTMTMT _LargeTextEditorState.didUpdateWidget } ');

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CodeEditor(
      scrollController: widget.scrollController,
      style: CodeEditorStyle(
        fontSize: 18,
      ),
      controller: widget.codeLineEditingController,
      wordWrap: true,
      onChanged: (text) {
        if (widget.data != widget.codeLineEditingController?.text) {
          widget.onChanged?.call(widget.codeLineEditingController?.text ?? "");
        }
      },
      indicatorBuilder:
          (context, editingController, chunkController, notifier) {
        return Row(
          children: [
            /*DefaultCodeLineNumber(
              controller: editingController,
              notifier: notifier,
            ),*/
            /*DefaultCodeChunkIndicator(
                width: 20, controller: chunkController, notifier: notifier)*/
          ],
        );
      },
      findBuilder: (context, controller, readOnly) =>
          CodeFindPanelView(controller: controller, readOnly: readOnly),
      shortcutsActivatorsBuilder: const ShortcutsActivatorsBuilder(),
      // toolbarController: const ContextMenuControllerImpl(),
      // sperator: Container(width: 1, color: Colors.blue),
    );
  }
}
