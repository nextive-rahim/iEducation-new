
import 'package:get/get.dart';

void errorHandler(
    Object e,
    StackTrace stackTrace, {
      String feedback = "Something went wrong",
      bool disableFeedback = false,
    }) {
  Get.snackbar(
    'Failed',
    feedback,
    snackPosition: SnackPosition.BOTTOM,
  );
}