import 'dart:io';

import 'menu.dart';

//TODO:利用Menu来进行创建路径选择
class PathUtils {
  static String _basePath = "../lib/";
  static Future<String> selectPath(String defaultPath) async {
    List<String> pathList = [defaultPath];
    Directory dir = Directory(_basePath);
    Stream<FileSystemEntity> fileList = dir.list();

    await for (FileSystemEntity fileSystemEntity in fileList) {
      if (FileSystemEntity.typeSync(fileSystemEntity.path) == FileSystemEntityType.directory) pathList.add(fileSystemEntity.path);
    }

    final menu = Menu(pathList, title: "select path:");
    final result = menu.choose();
    print(result.index);
    return defaultPath;
  }
}
