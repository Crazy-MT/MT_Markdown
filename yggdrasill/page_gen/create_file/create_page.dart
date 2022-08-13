import 'dart:io';

import '../utils/formatter_dart_file.dart';

createPage(String params, {String? targetService}) async {
  String _pageName = params;

  String _pageDirPath = "";
  if (targetService == null) {
    _pageDirPath = "../lib/app/modules/$_pageName";
  } else {
    _pageDirPath = "../lib/app/modules/$targetService/$_pageName";
  }

  var dir = Directory(_pageDirPath);
  var exist = dir.existsSync();
  if (!exist) {
    await dir.create();
  }
  if (_pageName.endsWith("Page")) {
    _pageName = _pageName.substring(0, _pageName.length - 4);
  }

  await _createPageFile(_pageName, _pageDirPath);
  await _createControllerFile(_pageName, _pageDirPath);
  await _createBindingFile(_pageName, _pageDirPath);
  await _insertRoute(_pageName, _pageDirPath);
}

_createPageFile(String pageName, String targetDirPath) async {
  String pageNameHump = toHumpStr(pageName);
  File pageTemplateFile = File("./page_gen/sample_file/page/page_template");
  String pageTemplateContent = await pageTemplateFile.readAsString();
  pageTemplateContent =
      pageTemplateContent.replaceAll("\$PageName", pageNameHump).replaceAll("\$PageControllerFileName", pageName + "_controller").replaceAll("\$PageClassName", pageNameHump + "Page");
  File createPageFile = File(targetDirPath + "/${pageName}_page.dart");
  await createPageFile.create();
  await createPageFile.writeAsString(formatterDartFile(pageTemplateContent));
  print("\x1B[32mSuccessful create : ${createPageFile.path}\x1B[0m");
}

_createControllerFile(String pageName, String targetDirPath) async {
  String pageNameHump = toHumpStr(pageName);
  File controllerTemplateFile = File("./page_gen/sample_file/page/controller_template");
  String pageTemplateContent = await controllerTemplateFile.readAsString();
  pageTemplateContent = pageTemplateContent.replaceAll("\$PageName", pageNameHump);
  File createControllerFile = File(targetDirPath + "/${pageName}_controller.dart");
  await createControllerFile.create();
  await createControllerFile.writeAsString(formatterDartFile(pageTemplateContent));
  print("\x1B[32mSuccessful create : ${createControllerFile.path}\x1B[0m");
}

_createBindingFile(String pageName, String targetDirPath) async {
  String pageNameHump = toHumpStr(pageName);
  File bindingTemplateFile = File("./page_gen/sample_file/page/binding_template");
  String pageTemplateContent = await bindingTemplateFile.readAsString();
  pageTemplateContent = pageTemplateContent.replaceAll("\$PageName", pageNameHump).replaceAll("\$PageControllerFileName", pageName + "_controller");
  File createBindingFile = File(targetDirPath + "/${pageName}_binding.dart");
  await createBindingFile.create();
  await createBindingFile.writeAsString(formatterDartFile(pageTemplateContent));
  print("\x1B[32mSuccessful create : ${createBindingFile.path}\x1B[0m");
}

_insertRoute(String originPageName, String targetDirPath) async {
  String pageNameHump = toHumpStr(originPageName);
  String pageName = pageNameHump + "Page";
  File pageIdFile = File("../lib/app/routes/app_routes.dart");
  // pageName = pageName.replaceAllMapped(RegExp(r'[A-Z]'), (Match m) => '_${m[0]}');
  // if (pageName.startsWith("_")) {
  //   pageName = pageName.replaceFirst("_", "");
  // }
  pageName = insertUnderscoresToFileName(pageName);
  String pageIdContent = await pageIdFile.readAsString();
  pageIdContent = pageIdContent.replaceAll("class RoutesID {", '''
 class RoutesID {
  static const ${pageName.toUpperCase()} = "/${pageName.toLowerCase()}";''');
  await pageIdFile.writeAsString(formatterDartFile(pageIdContent));
  print("\x1B[32mPage ID insert success : ${pageIdFile.path}\x1B[0m");

  File routeFile = File("../lib/app/routes/app_pages.dart");
  String routeFileContent = await routeFile.readAsString();
  routeFileContent = routeFileContent.replaceAll("static final List<GetPage> _routes = [", '''
  static final List<GetPage> _routes = [
      // $originPageName
      GetPage(
        name: RoutesID.${pageName.toUpperCase()},
        page: () => const ${pageNameHump}Page(),
        binding: ${pageNameHump}Binding(),
      ),
  ''');

  routeFileContent = routeFileContent.replaceAll("\nclass AppPages {", '''
import '${targetDirPath.replaceFirst("../lib/app/", "../")}/${originPageName}_binding.dart';
import '${targetDirPath.replaceFirst("../lib/app/", "../")}/${originPageName}_page.dart';

class AppPages {
''');
  await routeFile.writeAsString(formatterDartFile(routeFileContent));
  print("\x1B[32mRoute insert success : ${routeFile.path}\x1B[0m");
}

toHumpStr(String string) {
  List<String> strs = string.split("_");
  String result = "";
  for (var str in strs) {
    result += "${str[0].toUpperCase()}${str.substring(1)}";
  }
  return result;
}
