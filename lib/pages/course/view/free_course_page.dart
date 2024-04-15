import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/app.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/routes.dart';
import 'package:ieducation/utils/cached_network_image.dart';

class FreeCoursePage extends StatefulWidget {
  const FreeCoursePage({super.key});

  @override
  State<FreeCoursePage> createState() => _FreeCoursePageState();
}

class _FreeCoursePageState extends State<FreeCoursePage> {
  CourseController controller = Get.find();
  String courseTitle = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Get.arguments != null) {
      courseTitle =
          (Get.arguments[0] == 'free') ? "Free Courses" : "All Courses";
    } else {
      courseTitle = 'All Courses';
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (Get.arguments != null) {
      //   controller.getFreeCourses(
      //       context, Get.arguments[0] == 'free' ? 'free' : "");
      ///  } else {

      //controller.getFreeCourses(context, "");
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveHeight = MediaQuery.of(context).size.height - 200;
    double imageWidth = (responsiveWidth / 10.0) * 4;
    double descriptionWidth = (responsiveWidth / 10.0) * 6;
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            commonHeader('Courses', context),
            const SizedBox(
              height: 25,
            ),
            leftAlignTitle(courseTitle),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: responsiveHeight,
              width: responsiveWidth,
              child: SingleChildScrollView(
                child: Obx(() {
                  if (controller.courseRefreshing.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (controller.freeCourseList.isEmpty) {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
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
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
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
                              controller.freeCourseList.elementAt(index);
                          controller.getIndividualCourse(
                              context,
                              controller.freeCourseList
                                  .elementAt(index)
                                  .slug
                                  .toString());
                          if (controller.freeCourseList
                                  .elementAt(index)
                                  .subscriptionStatus ==
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
                                  child: AppCachedNetworkImage(
                                    imageUrl: controller.freeCourseList
                                        .elementAt(index)
                                        .photo
                                        .toString(),
                                    fit: BoxFit.cover,
                                    cachedHeight: 219,
                                    cachedWidth: 390,
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
                                        controller.freeCourseList
                                            .elementAt(index)
                                            .title
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            fontFamily: 'Poppins'),
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
                                                controller.freeCourseList
                                                    .elementAt(index)
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
                    itemCount: controller.freeCourseList.length,
                    primary: false,
                    shrinkWrap: true,
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getPrice(index) {
    double price = double.parse(AppConstants.getValueOrZero(
        controller.freeCourseList.elementAt(index).price.toString()));
    double discountedPrice = double.parse(AppConstants.getValueOrZero(
        controller.freeCourseList.elementAt(index).discountedPrice.toString()));

    if (controller.freeCourseList.elementAt(index).subscriptionStatus ==
        "active") {
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

    if (discountedPrice == price) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            children: [
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
