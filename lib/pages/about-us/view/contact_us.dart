import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/pages/about-us/controller/about_us_controller.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/pages/home/controller/home_controller.dart';
import 'package:ieducation/utils/progress_dialog.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final controller = Get.put(AboutUsController());
  final homeController = Get.find<HomeController>();
  @override
  void initState() {
    // TODO: implement initState
    controller.nameController.text =
        homeController.myInfo.elementAt(0).name.toString();
    controller.phoneController.text =
        homeController.myInfo.elementAt(0).phone.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            commonHeader('  Contact Us', context),
            const SizedBox(
              height: 25,
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
                  hintText: 'Name',
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
              child: TextFormField(
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                controller: controller.subjectController,
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
                  hintText: 'Subject',
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
              height: 200,
              width: responsiveWidth,
              child: TextFormField(
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                controller: controller.messageController,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
                maxLines: 15,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      top: 10, right: 20, bottom: 10, left: 20),
                  isDense: true,
                  hintText: 'Message',
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
              height: 58,
            ),
            GestureDetector(
              onTap: () {
                String name = controller.nameController.text;
                String phone = controller.phoneController.text;
                String message = controller.messageController.text;
                String subject = controller.subjectController.text;

                if (name.isNotEmpty &&
                    phone.isNotEmpty &&
                    message.isNotEmpty &&
                    subject.isNotEmpty) {
                  controller.params.clear();
                  controller.params['name'] = name;
                  controller.params['phone'] = phone;
                  controller.params['message'] = message;
                  controller.params['subject'] = subject;
                  progressDialog(context);
                  controller.submitContactUs(context);
                } else {
                  Get.snackbar('Error', 'Fill up the fields');
                }
              },
              child: const CommonButton(title: 'Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
