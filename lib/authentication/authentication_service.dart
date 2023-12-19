import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ieducation/pages/auth/controller/auth_controller.dart';
import 'package:ieducation/pages/auth/model/user_model.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/home/controller/home_controller.dart';
import 'package:ieducation/pages/package/controller/package_controller.dart';

abstract class AuthenticationService extends GetxService {
  Future<UserModel?> getCurrentUser();

  Future<void> signOut();
}

class UserAuthenticationService extends AuthenticationService {
  @override
  Future<UserModel?> getCurrentUser() async {
    var currentUser = GetStorage("Auth").read('user');
    if (currentUser != null) {
      return UserModel.fromJson(currentUser);
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    Get.delete<HomeController>();
    Get.delete<AuthController>();
    Get.delete<CourseController>();
    Get.delete<PackageController>();
    try {
      GetStorage().erase();
      GetStorage("Auth").erase();
      debugPrint('StorageCleared');
    } catch (e) {
      e.printError(info: 'StorageCleared');
    }
  }
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});
}
