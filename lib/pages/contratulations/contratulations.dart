import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/bottom-navigation/view/bottom_navigation.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';

class Contratulations extends StatefulWidget {
  const Contratulations({super.key});

  @override
  State<Contratulations> createState() => _ContratulationsState();
}

class _ContratulationsState extends State<Contratulations> {
  String item = 'course';
  @override
  void initState() {
    // TODO: implement initState
    if (Get.arguments != null) {
      item = Get.arguments[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height - 260;
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: responsiveHeight,
              ),
              const Center(
                child: Text(
                  'Congratulations!!',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
              ),
              Center(
                child: Text(
                  'You have successfully purchased this $item.',
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54),
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              GestureDetector(
                  onTap: () {
                    Get.offAll(() => const BottomNavigation());
                  },
                  child: const CommonButton(title: 'Back to Main'))
            ],
          ),
        ),
      ),
    );
  }
}
