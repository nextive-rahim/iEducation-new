import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/auth/controller/auth_controller.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/utils/progress_dialog.dart';

class CreateNewPassword extends StatelessWidget {
  final controller = Get.put(AuthController());

   CreateNewPassword({super.key});
  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 140, bottom: 15),
                height: 60,
                width: 161,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    scale: 1,
                  ),
                ),
              ),
              const Text(
                'Create new password',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Set up a new password to login your account.',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 41,
                width: responsiveWidth,
                child: Obx(() {
                  return TextFormField(
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    controller: controller.passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: controller.hidePassword.value,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 10, right: 20, bottom: 10, left: 20),
                      isDense: true,
                      hintText: 'New password',
                      hintStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.black38),
                      fillColor: Colors.transparent,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: CustomColors.inputBorderColor,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.hidePassword.value =
                              !controller.hidePassword.value;
                        },
                        icon: Icon(
                          controller.hidePassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: CustomColors.btnBackground,
                          size: 20,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: CustomColors.inputBorderColor,
                          width: 0.5,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 41,
                width: responsiveWidth,
                child: Obx(() {
                  return TextFormField(
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    controller: controller.confirmPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: controller.hidePassword.value,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 10, right: 20, bottom: 10, left: 20),
                      isDense: true,
                      hintText: 'Confirm new password',
                      hintStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.black38),
                      fillColor: Colors.transparent,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: CustomColors.inputBorderColor,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.hideConfirmPassword.value =
                              !controller.hideConfirmPassword.value;
                        },
                        icon: Icon(
                          controller.hideConfirmPassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: CustomColors.btnBackground,
                          size: 20,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: CustomColors.inputBorderColor,
                          width: 0.5,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 58,
              ),
              GestureDetector(
                onTap: () {
                  String password = controller.passwordController.text;
                  String passwordConfirmation =
                      controller.confirmPasswordController.text;
                  String phone = controller.phoneController.text;
                  String otp = controller.otpController.text;

                  bool isValidInput = (password.length < 6 ||
                          passwordConfirmation != password ||
                          phone.length != 11)
                      ? false
                      : true;

                  if (password.length < 6) {
                    showPasswordError();
                  }

                  if (password != passwordConfirmation) {
                    Get.snackbar('Error', 'Password not match');
                  }

                  if (isValidInput) {
                    controller.params['password'] = password;
                    controller.params['phone'] = phone;
                    controller.params['otp'] = otp;

                    progressDialog(context);
                    controller.resetPassword(context);
                  }
                },
                child: const CommonButton(title: 'Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showMobileError() {
    Get.snackbar('Error', 'Mobile Number must be of 11 digit');
  }

  void showPasswordError() {
    Get.snackbar('Error', 'Password must be at last 6 digits');
  }
}
