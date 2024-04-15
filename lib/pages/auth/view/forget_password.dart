import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/auth/controller/auth_controller.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/utils/progress_dialog.dart';

class ForgetPassword extends StatelessWidget {
  final controller = Get.put(AuthController());

  ForgetPassword({super.key});
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
                    cacheHeight: 157,
                    cacheWidth: 372,
                  ),
                ),
              ),
              const Text(
                'Forgot password?',
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
                'Enter your account phone number and we will',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              const Text(
                'send you an OTP to reset your password.',
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
                child: TextFormField(
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const SizedBox(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          '+88',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(
                        top: 10, right: 20, bottom: 10, left: 20),
                    isDense: true,
                    hintText: '01xxxxxxxxx',
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
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: CustomColors.inputBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 350,
              ),
              GestureDetector(
                onTap: () {
                  String phone = controller.phoneController.text;

                  bool isValidInput = (phone.length != 11) ? false : true;

                  if (phone.length != 11) {
                    showMobileError();
                  }

                  if (isValidInput) {
                    controller.params.clear();

                    controller.params['phone'] = phone;

                    progressDialog(context);
                    controller.getOtp(context);
                  }
                },
                child: const CommonButton(title: 'Continue'),
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
