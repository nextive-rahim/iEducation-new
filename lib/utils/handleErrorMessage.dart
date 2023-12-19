import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void handleErrorMessage(BuildContext context, result) async {
  if (result['singleMessage'] != '') {
    Get.snackbar('Failed', result['singleMessage'].toString(),
        snackPosition: SnackPosition.BOTTOM);
  } else {
    final Map<String, dynamic> error = jsonDecode(result['message'].toString());
    String finalError = '';
    error.forEach((key, value) => finalError = value[0].toString());
    print(finalError.toString());
    //other way
/*    error.forEach((key, value) => {
      if (key == 'phone') {finalError = value[0].toString()}
    });*/
    Get.snackbar('Failed', finalError.toString(),
        snackPosition: SnackPosition.BOTTOM);
  }
}
