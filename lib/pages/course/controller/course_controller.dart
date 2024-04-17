import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/api-controller/api.dart';
import 'package:ieducation/model/coupon_model.dart';
import 'package:ieducation/pages/course/model/category_children_model.dart'
    as CategoryChildrenData;
import 'package:ieducation/pages/course/model/course_category_model.dart';
import 'package:ieducation/pages/course/model/course_children_model.dart';
import 'package:ieducation/pages/course/model/course_model.dart';
import 'package:ieducation/pages/course/model/individual_course_model.dart';
import 'package:ieducation/utils/handleErrorMessage.dart';

class CourseController extends GetxController {
  RxList<CourseModelData> freeCourseList = <CourseModelData>[].obs;
  RxList<CourseModelData> allCourseList = <CourseModelData>[].obs;
  RxList<CourseModelData> featureCourseList = <CourseModelData>[].obs;
  RxList<CourseModelData> myCourseList = <CourseModelData>[].obs;
  RxList<CourseModelData> courseList = <CourseModelData>[].obs;
  RxList<CourseCategoryData> courseCategories = <CourseCategoryData>[].obs;
  RxList<CategoryChildrenData.Child> categoriesChild =
      <CategoryChildrenData.Child>[].obs;
  RxList<CourseChildrenData> courseChildList = <CourseChildrenData>[].obs;
  CourseCategoryData? selectedCategories;
  var categoryRefreshing = false.obs;
  RxList<Section> selectedCourseSections = <Section>[].obs;
  Map<String, dynamic> params = <String, dynamic>{};
  CouponModel? appliedCoupon;
  Section? selectedCourseSection;
  Content? selectedCourseContent;
  int? selectedCourseContentIndex;
  IndividualCourseData? selectedCourseData;
  CourseModelData? selectedFreeCourse;
  String? discountedPriceMain;
  CourseModelData? selectedCourse;

  TextEditingController paidToInput = TextEditingController();
  TextEditingController paidFromInput = TextEditingController();
  TextEditingController transactionIdInput = TextEditingController();
  TextEditingController paymentMethodInput = TextEditingController();
  TextEditingController code = TextEditingController();

  String coursePageTitle = '';

  var courseRefreshing = false.obs;
  var allCourseRefreshing = false.obs;
  var featureCourseRefreshing = false.obs;
  @override
  void onInit() {
    getFeatureCourses('feature');
    getAllCourses('');
    getFreeCourses('free');

    // TODO: implement onInit
    super.onInit();
  }

  void getFreeCourses(url) async {
    courseRefreshing.value = true;
    var result = await api.getCourseApi(url);
    courseRefreshing.value = false;
    if (result['statusCode'] == 200) {
      freeCourseList.value = result['data'].data;
    } else {
      /*handleErrorMessage(context, result);*/
    }
  }

  void getAllCourses(url) async {
    allCourseRefreshing.value = true;
    var result = await api.getCourseApi(url);
    allCourseRefreshing.value = false;
    if (result['statusCode'] == 200) {
      allCourseList.value = result['data'].data;
    } else {
      /*handleErrorMessage(context, result);*/
    }
  }

  void getFeatureCourses(url) async {
    featureCourseRefreshing.value = true;
    var result = await api.getCourseApi(url);
    featureCourseRefreshing.value = false;
    if (result['statusCode'] == 200) {
      featureCourseList.value = result['data'].data;
    } else {
      /*handleErrorMessage(context, result);*/
    }
  }

  void getMyCourses(url) async {
    courseRefreshing.value = true;
    var result = await api.getMyCoursesApi();

    courseRefreshing.value = false;
    if (result['statusCode'] == 200) {
      myCourseList.value = result['data'].data;
    } else if (result['statusCode'] == 401 || result['statusCode'] == 403) {
      Get.snackbar(
        'Unauthenticated',
        'Account is logged in another device',
      );
    } else {
      Get.snackbar(
        'Failed',
        'Fetching courses failed',
      );
    }
  }

  void getIndividualCourse(context, slug) async {
    courseRefreshing.value = true;
    var result = await api.getIndividualCourseApi(slug);
    courseRefreshing.value = false;
    if (result['statusCode'] == 200) {
      selectedCourseData = result['data'].data;

      discountedPriceMain = selectedCourseData!.discountedPrice;

      selectedCourseSections.value = selectedCourseData!.sections ?? [];
    } else {
      handleErrorMessage(context, result);
    }
  }

  Future<List<CourseChildrenData>?> getCourseByCategory(context, url) async {
    courseRefreshing.value = true;
    var result = await api.getCourseByCategoryApi(url);
    courseRefreshing.value = false;
    if (result != null) {
      return result.data!.toList();
    }
    return null;
  }

  Future<List<CategoryChildrenData.Child>?> getCourseCategories(
      context, url) async {
    categoryRefreshing.value = true;
    var result = await api.getCourseCategoryApi(url);
    categoryRefreshing.value = false;

    if (result != null) {
      return result.data!.children!.toList();
    }
    return null;
  }

  void validateCoupon(context) async {
    var result;
    result = await api.validateCouponApi(params);
    if (result['statusCode'] == 200) {
      String discountString = result['data'].discount.toString();
      if (discountString != 'null') {
        appliedCoupon = result['data'];
        double currentPrice = double.parse(discountedPriceMain.toString()) -
            double.parse(discountString);
        selectedCourseData!.discountedPrice = currentPrice.toString();

        Get.snackbar(
          'Success',
          'Coupon applied successfully',
        );
      } else {
        Get.snackbar(
          'Error',
          result['data'].message,
        );
      }
    } else {
      handleErrorMessage(context, result);
    }
  }

  void getCourseCategoriesOnlyHome(context) async {
    categoryRefreshing.value = true;
    var result = await api.getCourseCategoryOnlyHomeApi();
    categoryRefreshing.value = false;
    if (result['statusCode'] == 200) {
      courseCategories.value = result['data'].data;
      if (courseCategories.isNotEmpty) {
        CourseCategoryData book = CourseCategoryData();
        book.photo = "assets/images/bookHouse.png";
        courseCategories.add(book);
      }

      courseCategories.refresh();
    } else {
/*      handleErrorMessage(context, result);*/
    }
  }
}

/*  void getCourseCategories(context, url) async {
    categoryRefreshing.value = true;
    var result = await api.getCourseCategoryApi(url);
    categoryRefreshing.value = false;
    if (result != null) {
      categoriesChild.clear();
      categoriesChild.addAll(result.data!.children!.toList());
      categoriesChild.refresh();
    } else {
      handleErrorMessage(context, result);
    }
  }*/

/*  void getCourseByCategory(context, url) async {
    courseRefreshing.value = true;
    var result = await api.getCourseByCategoryApi(url);
    courseRefreshing.value = false;
    if (result != null) {
      courseChildList.clear();
      courseChildList.addAll(result.data!.toList());
      courseChildList.refresh();
    } else {
      handleErrorMessage(context, result);
    }
  }*/
