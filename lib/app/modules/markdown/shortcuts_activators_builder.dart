import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:re_editor/re_editor.dart';

class ShortcutsActivatorsBuilder extends CodeShortcutsActivatorsBuilder {

  const ShortcutsActivatorsBuilder();

  @override
  List<ShortcutActivator>? build(CodeShortcutType type) {
    return kIsMacOS ? _kDefaultMacCodeShortcutsActivators[type] :
      _kDefaultCommonCodeShortcutsActivators[type];
  }

}




const Map<CodeShortcutType, List<ShortcutActivator>> _kDefaultMacCodeShortcutsActivators = {
  CodeShortcutType.selectAll: [
    SingleActivator(LogicalKeyboardKey.keyA, meta: true)
  ],
  CodeShortcutType.cut: [
    SingleActivator(LogicalKeyboardKey.keyX, meta: true)
  ],
  CodeShortcutType.copy: [
    SingleActivator(LogicalKeyboardKey.keyC, meta: true)
  ],
  CodeShortcutType.paste: [
    SingleActivator(LogicalKeyboardKey.keyV, meta: true)
  ],
  CodeShortcutType.delete: [
    SingleActivator(LogicalKeyboardKey.delete,),
    SingleActivator(LogicalKeyboardKey.delete, shift: true),
    SingleActivator(LogicalKeyboardKey.delete, meta: true),
    SingleActivator(LogicalKeyboardKey.delete, meta: true, shift: true),
    SingleActivator(LogicalKeyboardKey.delete, alt: true),
    SingleActivator(LogicalKeyboardKey.delete, alt: true, shift: true),
  ],
  CodeShortcutType.backspace: [
    SingleActivator(LogicalKeyboardKey.backspace,),
    SingleActivator(LogicalKeyboardKey.backspace, shift: true),
    SingleActivator(LogicalKeyboardKey.backspace, meta: true),
    SingleActivator(LogicalKeyboardKey.backspace, meta: true, shift: true),
    SingleActivator(LogicalKeyboardKey.backspace, alt: true),
    SingleActivator(LogicalKeyboardKey.backspace, alt: true, shift: true),
  ],
  CodeShortcutType.undo: [
    SingleActivator(LogicalKeyboardKey.keyZ, meta: true)
  ],
  CodeShortcutType.redo: [
    SingleActivator(LogicalKeyboardKey.keyZ, meta: true, shift: true)
  ],
  CodeShortcutType.lineSelect: [
    SingleActivator(LogicalKeyboardKey.keyL, meta: true)
  ],
  CodeShortcutType.lineDelete: [
    SingleActivator(LogicalKeyboardKey.keyD, meta: true)
  ],
  CodeShortcutType.lineMoveUp: [
    SingleActivator(LogicalKeyboardKey.arrowUp, alt: true)
  ],
  CodeShortcutType.lineMoveDown: [
    SingleActivator(LogicalKeyboardKey.arrowDown, alt: true)
  ],
  CodeShortcutType.cursorMoveUp: [
    SingleActivator(LogicalKeyboardKey.arrowUp)
  ],
  CodeShortcutType.cursorMoveDown: [
    SingleActivator(LogicalKeyboardKey.arrowDown)
  ],
  CodeShortcutType.cursorMoveForward: [
    SingleActivator(LogicalKeyboardKey.arrowRight)
  ],
  CodeShortcutType.cursorMoveBackward: [
    SingleActivator(LogicalKeyboardKey.arrowLeft)
  ],
  CodeShortcutType.cursorMoveLineStart: [
    SingleActivator(LogicalKeyboardKey.arrowLeft, meta: true),
    SingleActivator(LogicalKeyboardKey.home)
  ],
  CodeShortcutType.cursorMoveLineEnd: [
    SingleActivator(LogicalKeyboardKey.arrowRight, meta: true),
    SingleActivator(LogicalKeyboardKey.end),
  ],
  CodeShortcutType.cursorMovePageStart: [
    SingleActivator(LogicalKeyboardKey.arrowUp, meta: true),
    SingleActivator(LogicalKeyboardKey.home, control: true)
  ],
  CodeShortcutType.cursorMovePageEnd: [
    SingleActivator(LogicalKeyboardKey.arrowDown, meta: true),
    SingleActivator(LogicalKeyboardKey.end, control: true)
  ],
  CodeShortcutType.cursorMoveWordBoundaryForward: [
    SingleActivator(LogicalKeyboardKey.arrowLeft, alt: true)
  ],
  CodeShortcutType.cursorMoveWordBoundaryBackward: [
    SingleActivator(LogicalKeyboardKey.arrowRight, alt: true)
  ],
  CodeShortcutType.selectionExtendUp: [
    SingleActivator(LogicalKeyboardKey.arrowUp, shift: true)
  ],
  CodeShortcutType.selectionExtendDown: [
    SingleActivator(LogicalKeyboardKey.arrowDown, shift: true)
  ],
  CodeShortcutType.selectionExtendForward: [
    SingleActivator(LogicalKeyboardKey.arrowRight, shift: true)
  ],
  CodeShortcutType.selectionExtendBackward: [
    SingleActivator(LogicalKeyboardKey.arrowLeft, shift: true)
  ],
  CodeShortcutType.selectionExtendPageStart: [
    SingleActivator(LogicalKeyboardKey.arrowUp, shift: true, meta: true),
    SingleActivator(LogicalKeyboardKey.home, shift: true, meta: true)
  ],
  CodeShortcutType.selectionExtendPageEnd: [
    SingleActivator(LogicalKeyboardKey.arrowDown, shift: true, meta: true),
    SingleActivator(LogicalKeyboardKey.end, shift: true, meta: true)
  ],
  CodeShortcutType.selectionExtendLineStart: [
    SingleActivator(LogicalKeyboardKey.arrowLeft, shift: true, meta: true),
    SingleActivator(LogicalKeyboardKey.home, shift: true)
  ],
  CodeShortcutType.selectionExtendLineEnd: [
    SingleActivator(LogicalKeyboardKey.arrowRight, shift: true, meta: true),
    SingleActivator(LogicalKeyboardKey.end, shift: true)
  ],
  CodeShortcutType.selectionExtendWordBoundaryForward: [
    SingleActivator(LogicalKeyboardKey.arrowLeft, shift: true, alt: true)
  ],
  CodeShortcutType.selectionExtendWordBoundaryBackward: [
    SingleActivator(LogicalKeyboardKey.arrowRight, shift: true, alt: true)
  ],
  CodeShortcutType.indent: [
    SingleActivator(LogicalKeyboardKey.tab)
  ],
  CodeShortcutType.outdent: [
    SingleActivator(LogicalKeyboardKey.tab, shift: true)
  ],
  CodeShortcutType.newLine: [
    SingleActivator(LogicalKeyboardKey.enter),
    SingleActivator(LogicalKeyboardKey.enter, shift: true),
    SingleActivator(LogicalKeyboardKey.enter, meta: true),
    SingleActivator(LogicalKeyboardKey.enter, meta: true, shift: true)
  ],
  CodeShortcutType.transposeCharacters: [
    SingleActivator(LogicalKeyboardKey.keyT, control: true)
  ],
  CodeShortcutType.singleLineComment: [
    SingleActivator(LogicalKeyboardKey.slash, meta: true)
  ],
  CodeShortcutType.multiLineComment: [
    SingleActivator(LogicalKeyboardKey.slash, meta: true, shift: true)
  ],
  CodeShortcutType.find: [
    SingleActivator(LogicalKeyboardKey.keyF, meta: true)
  ],
  CodeShortcutType.findToggleMatchCase: [
    SingleActivator(LogicalKeyboardKey.keyC, meta: true, alt: true)
  ],
  CodeShortcutType.findToggleRegex: [
    SingleActivator(LogicalKeyboardKey.keyR, meta: true, alt: true)
  ],
  CodeShortcutType.replace: [
    SingleActivator(LogicalKeyboardKey.keyF, meta: true, alt: true)
  ],
  // CodeShortcutType.save: [
  //   SingleActivator(LogicalKeyboardKey.keyS, meta: true)
  // ],
  CodeShortcutType.esc: [
    SingleActivator(LogicalKeyboardKey.escape)
  ],
};

const Map<CodeShortcutType, List<ShortcutActivator>> _kDefaultCommonCodeShortcutsActivators = {
  CodeShortcutType.selectAll: [
    SingleActivator(LogicalKeyboardKey.keyA, control: true)
  ],
  CodeShortcutType.cut: [
    SingleActivator(LogicalKeyboardKey.keyX, control: true)
  ],
  CodeShortcutType.copy: [
    SingleActivator(LogicalKeyboardKey.keyC, control: true)
  ],
  CodeShortcutType.paste: [
    SingleActivator(LogicalKeyboardKey.keyV, control: true)
  ],
  CodeShortcutType.delete: [
    SingleActivator(LogicalKeyboardKey.delete,),
    SingleActivator(LogicalKeyboardKey.delete, shift: true),
    SingleActivator(LogicalKeyboardKey.delete, control: true),
    SingleActivator(LogicalKeyboardKey.delete, control: true, shift: true),
    SingleActivator(LogicalKeyboardKey.delete, alt: true),
    SingleActivator(LogicalKeyboardKey.delete, alt: true, shift: true),
  ],
  CodeShortcutType.backspace: [
    SingleActivator(LogicalKeyboardKey.backspace,),
    SingleActivator(LogicalKeyboardKey.backspace, shift: true),
    SingleActivator(LogicalKeyboardKey.backspace, control: true),
    SingleActivator(LogicalKeyboardKey.backspace, control: true, shift: true),
    SingleActivator(LogicalKeyboardKey.backspace, alt: true),
    SingleActivator(LogicalKeyboardKey.backspace, alt: true, shift: true),
  ],
  CodeShortcutType.undo: [
    SingleActivator(LogicalKeyboardKey.keyZ, control: true)
  ],
  CodeShortcutType.redo: [
    SingleActivator(LogicalKeyboardKey.keyZ, control: true, shift: true)
  ],
  CodeShortcutType.lineSelect: [
    SingleActivator(LogicalKeyboardKey.keyL, control: true)
  ],
  CodeShortcutType.lineDelete: [
    SingleActivator(LogicalKeyboardKey.keyD, control: true)
  ],
  CodeShortcutType.lineMoveUp: [
    SingleActivator(LogicalKeyboardKey.arrowUp, alt: true)
  ],
  CodeShortcutType.lineMoveDown: [
    SingleActivator(LogicalKeyboardKey.arrowDown, alt: true)
  ],
  CodeShortcutType.cursorMoveUp: [
    SingleActivator(LogicalKeyboardKey.arrowUp)
  ],
  CodeShortcutType.cursorMoveDown: [
    SingleActivator(LogicalKeyboardKey.arrowDown)
  ],
  CodeShortcutType.cursorMoveForward: [
    SingleActivator(LogicalKeyboardKey.arrowRight)
  ],
  CodeShortcutType.cursorMoveBackward: [
    SingleActivator(LogicalKeyboardKey.arrowLeft)
  ],
  CodeShortcutType.cursorMoveLineStart: [
    SingleActivator(LogicalKeyboardKey.arrowLeft, control: true),
    SingleActivator(LogicalKeyboardKey.home)
  ],
  CodeShortcutType.cursorMoveLineEnd: [
    SingleActivator(LogicalKeyboardKey.arrowRight, control: true),
    SingleActivator(LogicalKeyboardKey.end)
  ],
  CodeShortcutType.cursorMovePageStart: [
    SingleActivator(LogicalKeyboardKey.arrowUp, control: true),
    SingleActivator(LogicalKeyboardKey.home, control: true)
  ],
  CodeShortcutType.cursorMovePageEnd: [
    SingleActivator(LogicalKeyboardKey.arrowDown, control: true),
    SingleActivator(LogicalKeyboardKey.end, control: true)
  ],
  CodeShortcutType.cursorMoveWordBoundaryForward: [
    SingleActivator(LogicalKeyboardKey.arrowLeft, alt: true)
  ],
  CodeShortcutType.cursorMoveWordBoundaryBackward: [
    SingleActivator(LogicalKeyboardKey.arrowRight, alt: true)
  ],
  CodeShortcutType.selectionExtendUp: [
    SingleActivator(LogicalKeyboardKey.arrowUp, shift: true)
  ],
  CodeShortcutType.selectionExtendDown: [
    SingleActivator(LogicalKeyboardKey.arrowDown, shift: true)
  ],
  CodeShortcutType.selectionExtendForward: [
    SingleActivator(LogicalKeyboardKey.arrowRight, shift: true)
  ],
  CodeShortcutType.selectionExtendBackward: [
    SingleActivator(LogicalKeyboardKey.arrowLeft, shift: true)
  ],
  CodeShortcutType.selectionExtendPageStart: [
    SingleActivator(LogicalKeyboardKey.home, shift: true, control: true)
  ],
  CodeShortcutType.selectionExtendPageEnd: [
    SingleActivator(LogicalKeyboardKey.end, shift: true, control: true)
  ],
  CodeShortcutType.selectionExtendLineStart: [
    SingleActivator(LogicalKeyboardKey.home, shift: true)
  ],
  CodeShortcutType.selectionExtendLineEnd: [
    SingleActivator(LogicalKeyboardKey.end, shift: true)
  ],
  CodeShortcutType.selectionExtendWordBoundaryForward: [
    SingleActivator(LogicalKeyboardKey.arrowLeft, shift: true, alt: true)
  ],
  CodeShortcutType.selectionExtendWordBoundaryBackward: [
    SingleActivator(LogicalKeyboardKey.arrowRight, shift: true, alt: true)
  ],
  CodeShortcutType.indent: [
    SingleActivator(LogicalKeyboardKey.tab)
  ],
  CodeShortcutType.outdent: [
    SingleActivator(LogicalKeyboardKey.tab, shift: true)
  ],
  CodeShortcutType.newLine: [
    SingleActivator(LogicalKeyboardKey.enter),
    SingleActivator(LogicalKeyboardKey.enter, shift: true),
    SingleActivator(LogicalKeyboardKey.enter, control: true),
    SingleActivator(LogicalKeyboardKey.enter, control: true, shift: true)
  ],
  CodeShortcutType.transposeCharacters: [
    SingleActivator(LogicalKeyboardKey.keyT, control: true)
  ],
  CodeShortcutType.singleLineComment: [
    SingleActivator(LogicalKeyboardKey.slash, control: true)
  ],
  CodeShortcutType.multiLineComment: [
    SingleActivator(LogicalKeyboardKey.slash, control: true, shift: true)
  ],
  CodeShortcutType.find: [
    SingleActivator(LogicalKeyboardKey.keyF, control: true)
  ],
  CodeShortcutType.findToggleMatchCase: [
    SingleActivator(LogicalKeyboardKey.keyC, control: true, alt: true)
  ],
  CodeShortcutType.findToggleRegex: [
    SingleActivator(LogicalKeyboardKey.keyR, control: true, alt: true)
  ],
  CodeShortcutType.replace: [
    SingleActivator(LogicalKeyboardKey.keyF, control: true, alt: true)
  ],
  CodeShortcutType.save: [
    SingleActivator(LogicalKeyboardKey.keyS, control: true)
  ],
  CodeShortcutType.esc: [
    SingleActivator(LogicalKeyboardKey.escape)
  ],
};
