import 'package:get/get.dart';
import 'package:ieducation/authentication/authentication_controller.dart';

class BottomNavigationController extends GetxController {
  late AuthenticationController authenticationController;

  @override
  void onInit() {
    authenticationController = Get.find();

    super.onInit();
  }
}
