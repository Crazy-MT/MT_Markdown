import 'create_file/create_page.dart';
// import 'create_file/create_service.dart';

// final menu = Menu(["Yes", "No"], title: "Choose");
// final result = menu.choose();
// print(result.index);
void main(List<String> args) {
  print("args.length:${args.length},$args");
  if (args.length < 2) {
    print("\x1B[31mUnknown command\x1B[0m");
    return;
  }
  String command = args[0];
  if (command == "create") {
    String params = args[1];
    if (params.startsWith("service:")) {
      // createService(params.split(":")[1]);
    } else if (params.startsWith("page:")) {
      if (args.length >= 4 && args[2] == "on") {
        createPage(params.split(":")[1], targetService: args[3]);
      } else {
        createPage(params.split(":")[1]);
      }
    }
  }
}
