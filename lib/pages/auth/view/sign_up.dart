import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/auth/controller/auth_controller.dart';
import 'package:ieducation/pages/auth/view/login_page.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/utils/progress_dialog.dart';

class SignUpPage extends StatelessWidget {
  final controller = Get.put(AuthController());

  SignUpPage({super.key});
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
                'Sign Up',
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
                'Sign up to create and account',
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
                  controller: controller.nameController,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        top: 10, right: 20, bottom: 10, left: 20),
                    isDense: true,
                    hintText: 'Full Name',
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
                height: 15,
              ),
              SizedBox(
                height: 41,
                width: responsiveWidth,
                child: TextFormField(
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        top: 10, right: 20, bottom: 10, left: 20),
                    isDense: true,
                    hintText: 'Email',
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
                height: 15,
              ),
              SizedBox(
                height: 41,
                width: responsiveWidth,
                child: TextFormField(
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  controller: controller.institutionController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        top: 10, right: 20, bottom: 10, left: 20),
                    isDense: true,
                    hintText: 'Current Institution',
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
                height: 15,
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
                height: 15,
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
                      hintText: 'Password',
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
                      hintText: 'Confirm Password',
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
                  String name = controller.nameController.text;
                  String phone = controller.phoneController.text;
                  String email = controller.emailController.text;
                  String currentInstitution =
                      controller.institutionController.text;
                  String password = controller.passwordController.text;
                  String passwordConfirmation =
                      controller.confirmPasswordController.text;
                  bool isValidInput = (phone.length != 11 ||
                          password.length < 6 ||
                          !name.isNotEmpty ||
                          !currentInstitution.isNotEmpty ||
                          passwordConfirmation != password ||
                          !email.isNotEmpty)
                      ? false
                      : true;
                  if (phone.length != 11) {
                    showMobileError();
                  }
                  if (password.length < 6) {
                    showPasswordError();
                  }

                  if (password != passwordConfirmation) {
                    Get.snackbar('Error', 'Password not match');
                  }

                  if (isValidInput) {
                    controller.params.clear();
                    controller.params['name'] = name;
                    controller.params['phone'] = phone;
                    controller.params['email'] = email;
                    controller.params['current_institution'] =
                        currentInstitution;
                    controller.params['password'] = password;
                    controller.params['password_confirmation'] =
                        passwordConfirmation;
                    progressDialog(context);
                    controller.signUp(context);
                  }
                },
                child: const CommonButton(title: 'Signup'),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have account?',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => LoginPage());
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: CustomColors.btnBackground,
                      ),
                    ),
                  )
                ],
              )
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
