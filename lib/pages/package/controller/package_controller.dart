import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/api-controller/api.dart';
import 'package:ieducation/model/coupon_model.dart';
import 'package:ieducation/pages/blogs/model/blog_model.dart';
import 'package:intl/intl.dart';
import 'package:ieducation/pages/package/model/package_model.dart';
import 'package:ieducation/pages/package/model/single_package_model.dart';
import 'package:ieducation/utils/handleErrorMessage.dart';

class PackageController extends GetxController {
  var packageIsRefreshing = false.obs;
  var singlePackageRefreshing = false.obs;
  RxList<PackageModelData> packageList = <PackageModelData>[].obs;
  Map<String, dynamic> params = <String, dynamic>{};
  RxList<SinglePackageModelData> packageCourseList =
      <SinglePackageModelData>[].obs;

  PackageModelData? selectedPackageModel;

  String? discountedPriceMain;

  int selectedPackageIndex = 0;

  TextEditingController bodyController = TextEditingController();

  BlogDataList? selectedBlog;
  CouponModel? appliedCoupon;
  TextEditingController code = TextEditingController();

  void getPackageList(context) async {
    var result;
    packageIsRefreshing.value = true;
    result = await api.getPackageListApi();
    packageIsRefreshing.value = false;
    if (result['statusCode'] == 200) {
      packageList.clear();
      packageList.addAll(result['data'].data.toList());
      packageList.refresh();
    } else {
      // handleErrorMessage(context, result);
    }
  }

  void getSinglePackage(context, url) async {
    var result;

    singlePackageRefreshing.value = true;
    result = await api.getSinglePackageApi(url);
    singlePackageRefreshing.value = false;

    if (result['statusCode'] == 200) {
      packageCourseList.clear();
      packageCourseList.add(result['data'].data);
      packageCourseList.refresh();
    } else {
      handleErrorMessage(context, result);
    }
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
        packageList[selectedPackageIndex].discountedPrice =
            currentPrice.toString();
        packageList.refresh();
        Get.snackbar('Success', 'Coupon applied successfully');
      } else {
        Get.snackbar('Error', result['data'].message);
      }
    } else {
      handleErrorMessage(context, result);
    }
  }

  String dates(String s) {
    if (s == 'null') {
      return 'N/A';
    }
    DateTime end = DateTime.parse(s.substring(0, s.length - 1))
        .add(const Duration(hours: 6));
    final date2 = DateTime.now();
    final difference = end.difference(date2).inSeconds;
    DateTime tempDate = DateFormat("hh:mm")
        .parse("${end.hour}:${end.minute}");
    var dateFormat = DateFormat("h:mm a"); // you can change the format here
    String Final = '${end.day} ${month(end.month.toString())} ${end.year}';
    return Final;
  }

  String getTime(String s) {
    if (s == 'null') {
      return 'N/A';
    }
    DateTime end = DateTime.parse(s.substring(0, s.length - 1))
        .add(const Duration(hours: 6));
    final date2 = DateTime.now();
    final difference = end.difference(date2).inSeconds;
    DateTime tempDate = DateFormat("hh:mm")
        .parse("${end.hour}:${end.minute}");
    var dateFormat = DateFormat("h:mm a"); // you can change the format here
    String Final = dateFormat.format(tempDate).toString();
    return Final;
  }

  String month(String m) {
    if (m == '1') {
      return 'Jan';
    } else if (m == '2') {
      return 'Feb';
    } else if (m == '3') {
      return 'Mar';
    } else if (m == '4') {
      return 'Apr';
    } else if (m == '5') {
      return 'May';
    } else if (m == '6') {
      return 'Jun';
    } else if (m == '7') {
      return 'Jul';
    } else if (m == '8') {
      return 'Aug';
    } else if (m == '9') {
      return 'Sept';
    } else if (m == '10') {
      return 'Oct';
    } else if (m == '11') {
      return 'Nov';
    } else {
      return 'Dec';
    }
  }
}
