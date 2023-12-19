import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/auth/controller/auth_controller.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/routes.dart';
import 'package:ieducation/utils/progress_dialog.dart';

class ConfirmPhoneNumber extends StatefulWidget {
  const ConfirmPhoneNumber({super.key});

  @override
  State<ConfirmPhoneNumber> createState() => _ConfirmPhoneNumberState();
}

class _ConfirmPhoneNumberState extends State<ConfirmPhoneNumber> {
  final controller = Get.put(AuthController());
  CountdownTimerController? controllerTimer;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  @override
  void initState() {
    super.initState();
    controllerTimer = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    print('onEnd');
  }

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
                  controller: controller.otpController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        top: 10, right: 20, bottom: 10, left: 20),
                    isDense: true,
                    hintText: 'OTP',
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
                height: 30,
              ),
              const Text(
                'Didn’t get a code?',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.black54),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Resend code in  :  ',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.black54),
                  ),
                  CountdownTimer(
                    controller: controllerTimer,
                    onEnd: onEnd,
                    endTime: endTime,
                    textStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: MCQButtonColors.timeColor),
                    endWidget: GestureDetector(
                      onTap: () {
                        progressDialog(context);
                        controller.getOtp(context);
                      },
                      child: const Text(
                        ' Resend',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: MCQButtonColors.timeColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 320,
              ),
              GestureDetector(
                onTap: () {
                  String otp = controller.otpController.text;

                  bool isValidInput = !otp.isNotEmpty ? false : true;

                  if (isValidInput) {
                    controller.params.clear();

                    controller.params['otp'] = otp;
                    Get.toNamed(RoutesPath.createNewPassword);
                  } else {
                    Get.snackbar('Error', 'Input field is empty!');
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
