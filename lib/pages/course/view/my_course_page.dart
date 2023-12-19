import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/app.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/routes.dart';

class MyCoursePage extends StatefulWidget {
  const MyCoursePage({super.key});

  @override
  State<MyCoursePage> createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage> {
  CourseController controller = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getMyCourses(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveHeight = MediaQuery.of(context).size.height - 180;
    double imageWidth = (responsiveWidth / 10.0) * 4;
    double descriptionWidth = (responsiveWidth / 10.0) * 6;
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            commonHeader('Courses', context),
            const SizedBox(
              height: 25,
            ),
            leftAlignTitle('My Courses'),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: responsiveHeight,
              width: responsiveWidth,
              child: Obx(
                () {
                  if (controller.courseRefreshing.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (controller.myCourseList.isEmpty) {
                    return SingleChildScrollView(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.only(top: 20),
                          width: 250,
                          height: 120,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                size: 50,
                              ),
                              Text(
                                'No course is found',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectedFreeCourse =
                              controller.myCourseList[index];
                          controller.getIndividualCourse(context,
                              controller.myCourseList[index].slug.toString());
                          if (controller
                                  .myCourseList[index].subscriptionStatus ==
                              "active") {
                            Get.toNamed(RoutesPath.courseContentPage);
                          } else {
                            Get.toNamed(RoutesPath.courseDetail);
                          }
                        },
                        child: Card(
                          child: SizedBox(
                            height: 100,
                            width: descriptionWidth,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: imageWidth,
                                  child: Image.network(
                                    controller.myCourseList[index].photo
                                        .toString(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    const SizedBox(height: 9),
                                    SizedBox(
                                      width: descriptionWidth - 20.0,
                                      height: 70,
                                      child: Text(
                                        controller.myCourseList[index].title
                                            .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 18,
                                      width: descriptionWidth - 25.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 18,
                                                width: 17,
                                                child: Center(
                                                  child: Image.asset(
                                                    'assets/images/enrolled.png',
                                                    scale: 1,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 9,
                                              ),
                                              Text(
                                                controller.myCourseList[index]
                                                    .usersCount
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: CustomColors
                                                      .enrolledColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          getPrice(index)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.myCourseList.length,
                    primary: false,
                    shrinkWrap: true,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getPrice(index) {
    double price = double.parse(AppConstants.getValueOrZero(
        controller.myCourseList.elementAt(index).price.toString()));
    double discountedPrice = double.parse(AppConstants.getValueOrZero(
        controller.myCourseList.elementAt(index).discountedPrice.toString()));

    if (controller.myCourseList[index].subscriptionStatus == "active") {
      return const Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: Text(
          'Enrolled',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: Colors.green,
              fontSize: 14),
        ),
      );
    }
    if (controller.myCourseList[index].subscriptionStatus == "expired") {
      return const Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: Text(
          'Expired',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: Colors.red,
              fontSize: 14),
        ),
      );
    }

    if (price <= 0) {
      return const Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: Text(
          'Free',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: Colors.blue,
              fontSize: 14),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Row(
          children: [
            Text(
              '৳ $price',
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: CustomColors.discountColor,
                  decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '৳ $discountedPrice',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
          ],
        )
      ],
    );
  }
}
