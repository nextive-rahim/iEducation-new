import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/app.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/drawer/drawer.dart';
import 'package:ieducation/routes.dart';
import 'package:ieducation/utils/cached_network_image.dart';

class AllCoursePage extends StatefulWidget {
  const AllCoursePage({super.key});

  @override
  State<AllCoursePage> createState() => _AllCoursePageState();
}

class _AllCoursePageState extends State<AllCoursePage> {
  CourseController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getAllCourses('');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 20;

    double descriptionWidth = (responsiveWidth / 10.0) * 6;
    return Scaffold(
      key: scaffoldKey2,
      backgroundColor: CustomColors.pageBackground,
      drawer: const GetDrawer(),
      appBar: getAppHeader(),
      // AppBar(
      //   leadingWidth: 0,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   toolbarHeight: 65,
      //   title: const Text('Courses'),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            children: [
              // commonHeader('Courses', context),
              // const SizedBox(height: 5),
              leftAlignTitle('All Courses'),
              const SizedBox(height: 10),
              Obx(() {
                if (controller.allCourseRefreshing.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.allCourseList.isEmpty) {
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
                  padding: const EdgeInsets.only(bottom: 10),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedFreeCourse =
                            controller.allCourseList.elementAt(index);
                        controller.getIndividualCourse(
                            context,
                            controller.allCourseList
                                .elementAt(index)
                                .slug
                                .toString());
                        if (controller.allCourseList
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
                          height: 80,
                          width: descriptionWidth,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 120,
                                height: 80,
                                child: AppCachedNetworkImage(
                                  imageUrl: controller.allCourseList
                                      .elementAt(index)
                                      .photo
                                      .toString(),
                                  fit: BoxFit.fill,
                                  cachedHeight: 143,
                                  cachedWidth: 256,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: descriptionWidth - 20.0,
                                    child: Text(
                                      controller.allCourseList
                                          .elementAt(index)
                                          .title
                                          .toString(),
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
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
                                              controller.allCourseList
                                                  .elementAt(index)
                                                  .usersCount
                                                  .toString(),
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color:
                                                    CustomColors.enrolledColor,
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
                  itemCount: controller.allCourseList.length,
                  primary: false,
                  shrinkWrap: true,
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget getPrice(index) {
    double price = double.parse(AppConstants.getValueOrZero(
        controller.allCourseList.elementAt(index).price.toString()));
    double discountedPrice = double.parse(AppConstants.getValueOrZero(
        controller.allCourseList.elementAt(index).discountedPrice.toString()));

    if (controller.allCourseList.elementAt(index).subscriptionStatus ==
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

  AppBar getAppHeader() {
    return AppBar(
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 65,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () => scaffoldKey2.currentState!.openDrawer(),
              child: SizedBox(
                height: 45,
                width: 45,
                child: Center(
                  child: Image.asset(
                    'assets/images/head_menu.png',
                    scale: 1,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: SizedBox(
              height: 50,
              width: 97,
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  scale: 1,
                  cacheHeight: 131,
                  cacheWidth: 310,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                Get.toNamed(RoutesPath.noticePage);
              },
              child: SizedBox(
                height: 45,
                width: 45,
                child: Center(
                  child: Image.asset(
                    'assets/images/head_notification.png',
                    scale: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
