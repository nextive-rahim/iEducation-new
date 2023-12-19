import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/api-controller/api.dart';
import 'package:ieducation/pages/about-us/model/about_us_model.dart';
import 'package:ieducation/utils/handleErrorMessage.dart';

class AboutUsController extends GetxController {
  var isRefreshing = false.obs;

  RxList<AboutUsData> aboutUsDataList = <AboutUsData>[].obs;

  Map<String, dynamic> params = <String, dynamic>{};

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  void getAboutUsData(context) async {
    var result;
    isRefreshing.value = true;
    result = await api.aboutUsDataApi();
    isRefreshing.value = false;
    if (result['statusCode'] == 200) {
      aboutUsDataList.clear();
      aboutUsDataList.add(result['data'].data);
      aboutUsDataList.refresh();
    } else {
      handleErrorMessage(context, result);
    }
  }

  void submitContactUs(context) async {
    var result = await api.contactUsApi(params);
    Get.back();
    if (result['statusCode'] == 200) {
      messageController.clear();
      subjectController.clear();
      Get.snackbar(
        'Success',
        'We have received your message. We will contact you as soon as possible.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
      );
    } else {
      handleErrorMessage(context, result);
    }
  }
}
