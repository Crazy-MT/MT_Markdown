import 'dart:io';

import '../utils/formatter_dart_file.dart';

createService(String serviceName) async {
  File serviceTemplateFile = File("./ftr/sample_file/service/service_template");
  String serviceTemplateContent = await serviceTemplateFile.readAsString();
  serviceTemplateContent = serviceTemplateContent.replaceAll("\$ServiceName", serviceName);

  File serviceImplTemplateFile = File("./ftr/sample_file/service/service_impl_template");
  String serviceImplTemplateContent = await serviceImplTemplateFile.readAsString();
  serviceImplTemplateContent = serviceImplTemplateContent.replaceAll("\$ServiceName", serviceName);
  //start create service file
  var dir = Directory("../lib/FTServices/$serviceName");
  var exist = dir.existsSync();
  if (!exist) {
    await dir.create();
  }

  File createServiceFile = File("${dir.path}/$serviceName.dart");
  await createServiceFile.create();
  await createServiceFile.writeAsString(formatterDartFile(serviceTemplateContent));
  print("\x1B[32mSuccessful create : ${createServiceFile.path}\x1B[0m");
  //complete create service file
  //start create service file
  var dirImp = Directory("../lib/${serviceName}Imp");
  exist = dirImp.existsSync();
  if (!exist) {
    await dirImp.create();
  }

  File createServiceImpFile = File("${dirImp.path}/${serviceName}Imp.dart");
  await createServiceImpFile.create();
  await createServiceImpFile.writeAsString(formatterDartFile(serviceImplTemplateContent));
  print("\x1B[32mSuccessful create : ${createServiceImpFile.path}\x1B[0m");
  //complete create service file

  //update main file
  File mainFile = File("../lib/main.dart");
  String mainContent = await mainFile.readAsString();
  mainContent = mainContent.replaceAll("void _registerServices() {", '''
  void _registerServices() {
    ///$serviceName
    FTServices.services.register($serviceName, () => ${serviceName}Imp());''');

  mainContent = mainContent.replaceAll("\nvoid main() {", '''
  import 'FTServices/$serviceName/$serviceName.dart';
  import '${serviceName}Imp/${serviceName}Imp.dart';

  void main() {
  ''');
  await mainFile.writeAsString(formatterDartFile(mainContent));
  print("\x1B[32mService registe success : ${mainFile.path}\x1B[0m");
  //update main file success
}
