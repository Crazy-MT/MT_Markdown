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

Map _loggerColors = {
  'd': '\x1B[0m',
  'b': '\x1B[34m',
  'w': '\x1B[37m',
  'r': '\x1B[31m',
  'g': '\x1B[32m',
  'y': '\x1B[33m',
  'c': '\x1B[36m',
};
lLog(
  String message, {
  bool needLogStack = false,
}) {
  log(_loggerColors['g'] + message + _loggerColors['d']);
  if (needLogStack) {
    stackLog(prefixColor: 'g');
  }
}

errorLog(String message, {StackTrace? stackTrace}) {
  log(_loggerColors['r'] + message + _loggerColors['d']);
  stackLog(prefixColor: 'r', stackTrace: stackTrace);
}

debugLog(String message) {
  log(_loggerColors['y'] + message + _loggerColors['d']);
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
    log("${_loggerColors[prefixColor]}所在文件：${frame.location},line:${frame.line},column:${frame.column}${_loggerColors['d']}");
  }
  log("${_loggerColors['y']} 隐藏了一共$hideCount个调用栈的输出 ${_loggerColors['d']}");
}
