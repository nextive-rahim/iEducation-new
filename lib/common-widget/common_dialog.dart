import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';

commonDialog({
  required BuildContext context,
  bool? isDismissible = true,
  final String? title,
  final String? description,
  final String? yesButtonText,
  final String? noButtonText,
  final Widget? bodyContent,
  required Function() onYesPressed,
  Function()? onNoPressed,
  bool? showNoButton = true,
}) {
  showDialog(
    context: context,
    barrierDismissible: isDismissible ?? false,
    builder: (_) {
      return WillPopScope(
        onWillPop: () async => isDismissible ?? false,
        child: AlertDialog(
          elevation: 0,
          contentPadding: const EdgeInsets.only(
            top: 30,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                bodyContent ??
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title ?? 'Are you sure?',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            height: 21 / 20,
                            color: CustomColors.mainColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          description ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 18 / 14,
                            color: CustomColors.lightBlack40,
                          ),
                        ),
                      ],
                    ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (showNoButton == true)
                        ? Container(
                            height: 34,
                            width: 100,
                            margin: const EdgeInsets.only(right: 25),
                            child: GestureDetector(
                              onTap: onNoPressed ?? () => Get.back(),
                              child: CommonButton(
                                title: noButtonText ?? 'Cancel',
                                backgroundColor: CustomColors.red,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 34,
                      width: 100,
                      child: GestureDetector(
                        onTap: onYesPressed,
                        child: CommonButton(
                          title: yesButtonText ?? 'Confirm',
                          backgroundColor: CustomColors.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
