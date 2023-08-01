// Reset:   \x1B[0m
// Black:   \x1B[30m
// White:   \x1B[37m
// Red:     \x1B[31m
// Green:   \x1B[32m
// Yellow:  \x1B[33m
// Blue:    \x1B[34m
// Cyan:    \x1B[36m
import 'dart:developer';

import 'package:stack_trace/stack_trace.dart';

lLog(
  String message, {
  bool needLogStack = false,
}) {
  log(message);
  if (needLogStack) {
    stackLog(prefixColor: 'g');
  }
}

errorLog(String message, {StackTrace? stackTrace}) {
  log(message);
  stackLog(prefixColor: 'r', stackTrace: stackTrace);
}

debugLog(String message) {
  log(message);
}

stackLog({prefixColor = 'b', StackTrace? stackTrace}) {
  final chain = Chain.forTrace(stackTrace ?? StackTrace.current);
  final frames = chain.toTrace().frames;
  int hideCount = 0;
  for (var frame in frames) {
    if (frame.location.startsWith("package:flutter") || frame.location.startsWith("dart:")) {
      hideCount++;
      continue;
    }
    log("所在文件：${frame.location},line:${frame.line},column:${frame.column}");
  }
  log("隐藏了一共$hideCount个调用栈的输出");
}
