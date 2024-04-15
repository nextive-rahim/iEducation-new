import 'package:get/get.dart';
import 'package:ieducation/authentication/authentication_controller.dart';
import 'package:ieducation/authentication/authentication_service.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationController(
        Get.put(UserAuthenticationService(), permanent: true)));
  }
}
