import 'package:chat_app/Controllers/chat_controller.dart';
import 'package:chat_app/Controllers/login_controller.dart';
import 'package:get/get.dart';

class ChatBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogInController());
    Get.lazyPut(() => ChatController());
  }
}
