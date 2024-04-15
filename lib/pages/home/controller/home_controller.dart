import 'package:get/get.dart';
import 'package:ieducation/api-controller/api.dart';
import 'package:ieducation/authentication/authentication_controller.dart';
import 'package:ieducation/authentication/authentication_state.dart';
import 'package:ieducation/pages/auth/model/user_model.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/package/controller/package_controller.dart';
import 'package:ieducation/routes.dart';

class HomeController extends GetxController {
  late AuthenticationController authenticationController;
  final courseController = Get.put(CourseController());
  final packageController = Get.put(PackageController());
  Map<String, dynamic> params = <String, dynamic>{};
  late UserModel currentUser;
  var hidePassword = true.obs;
  RxList<User> myInfo = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    authenticationController = Get.find();
    initData();
  }

  void initData() {
    if (authenticationController.state is Authenticated) {
      currentUser = (authenticationController.state as Authenticated).user;
      User me = User();
      me.id = currentUser.user!.id;
      me.name = currentUser.user!.name;
      me.username = currentUser.user!.username;
      me.photo = currentUser.user!.photo;
      me.phone = currentUser.user!.phone;
      me.email = currentUser.user!.email;
      me.type = currentUser.user!.type;
      me.gender = currentUser.user!.gender;
      me.dob = currentUser.user!.dob;
      me.currentInstitution = currentUser.user!.currentInstitution;
      me.varsity = currentUser.user!.varsity;
      me.college = currentUser.user!.college;
      me.school = currentUser.user!.school;
      me.lastLoginTime = currentUser.user!.lastLoginTime;
      me.approved = currentUser.user!.approved;
      me.active = currentUser.user!.active;
      me.permissions = currentUser.user!.permissions;
      myInfo.clear();
      myInfo.add(me);
      me.permissions = currentUser.user!.permissions;
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getUserInfo();
    courseController.getCourseCategoriesOnlyHome('context');
    courseController.getFreeCourses('featured');
    packageController.getPackageList('context');
    super.onReady();
  }

  void getUserInfo() async {
    var result = await api.userApiInfo();
    if (result['statusCode'] == 200) {
      initData();
    } else if (result['statusCode'] == 401 || result['statusCode'] == 403) {
      Get.snackbar(
        'Unauthenticated',
        'Account is logged in another device',
      );
      signOut();
    }
  }

  void signOut() async {
    authenticationController.signOut();
    Get.offNamed(RoutesPath.login);
  }

  Future<void> onRefresh() async {
    getUserInfo();
    courseController.getCourseCategoriesOnlyHome('context');
    courseController.getFreeCourses('featured');
  }
}
