import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ieducation/api-controller/api.dart';
import 'package:ieducation/authentication/authentication_controller.dart';
import 'package:ieducation/authentication/authentication_state.dart';
import 'package:ieducation/pages/auth/view/login_page.dart';
import 'package:ieducation/pages/bottom-navigation/view/bottom_navigation.dart';
import 'package:ieducation/routes.dart';
import 'package:ieducation/utils/handleErrorMessage.dart';

class AuthController extends GetxController {
  final AuthenticationController authenticationController = Get.find();
  Map<String, dynamic> params = <String, dynamic>{};

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController institutionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var selectedProfileImgPath;
  var hidePassword = true.obs;
  var hideConfirmPassword = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void login(context) async {
    await collectInfo();
    var result = await api.loginApi(params);
    Get.back();
    if (result['statusCode'] == 200) {
      authenticationController.state = Authenticated(user: result['data']);

      Get.offAll(() => const BottomNavigation());
      Get.snackbar(
        'Success',
        'Login Successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      handleErrorMessage(
        context,
        result,
      );
    }
  }

  Future<void> collectInfo() async {
    // await getApnToken();
/*    await getDeviceInfo();*/
  }

/*  Future<void> getDeviceInfo() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      params['os'] = 'Android';
      params['version'] = androidInfo.version.sdkInt.toString();
      params['device'] =
      '${androidInfo.manufacturer}-${androidInfo.brand}-${androidInfo.device}-${androidInfo.model}';
    }

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;

      params['os'] = 'iOS';
      params['version'] = iosInfo.systemVersion;
      params['device'] = "${iosInfo.utsname.machine}";
    }
  }*/

  void signUp(context) async {
    var result = await api.signUpApi(params);
    Get.back();
    if (result['statusCode'] == 200) {
      passwordController.clear();
      Get.snackbar('Success', 'Register Successfully',
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(() => LoginPage());
    } else {
      handleErrorMessage(context, result);
    }
  }

  void updateUser(context, id) async {
    params['_method'] = 'PUT';
    var result = await api.updateUserApi(params, selectedProfileImgPath, id);
    Get.back();
    if (result['statusCode'] == 200) {
      Get.back();
      Get.offAll(() => const BottomNavigation());
      Get.snackbar('Success', 'Profile Update successfully',
          snackPosition: SnackPosition.BOTTOM);
      Get.back();
    } else {
      handleErrorMessage(context, result);
    }
  }

  void resetPassword(context) async {
    var result = await api.resetPasswordApi(params);
    Get.back();
    if (result['statusCode'] == 200) {
      passwordController.clear();
      Get.snackbar('Success', 'Password reset Successfully',
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(() => LoginPage());
    } else {
      handleErrorMessage(context, result);
    }
  }

  void getOtp(context) async {
    var result = await api.getOTPApi(params);
    Get.back();
    if (result['statusCode'] == 200) {
      Get.snackbar('Success', 'OTP Sent Successfully',
          snackPosition: SnackPosition.BOTTOM);
      Get.toNamed(RoutesPath.confirmPhoneNumber);
    } else {
      handleErrorMessage(context, result);
    }
  }

  void signOut() async {
    authenticationController.signOut();
    Get.offAll(() => LoginPage());
    Get.snackbar(
      'Success',
      'Logout Successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
