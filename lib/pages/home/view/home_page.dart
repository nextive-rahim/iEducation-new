import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ieducation/app.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common_dialog.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/drawer/drawer.dart';
import 'package:ieducation/pages/home/controller/home_controller.dart';
import 'package:ieducation/pages/settings/controller/settings_controller.dart';
import 'package:ieducation/routes.dart';
import 'package:ieducation/utils/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.find<HomeController>();
  final courseController = Get.find<CourseController>();
  final settingsController = Get.put(SettingsController());
  bool settingsControllerIsInitiated = Get.isRegistered<SettingsController>();

  @override
  void initState() {
    super.initState();
    if (settingsControllerIsInitiated) {
      settingsController.getAllSettings().then((value) {
        if (settingsController.hasNewUpdate == true &&
            settingsController.showUpdateDialog == true) {
          _newUpdateDialog(
            context,
            isForceUpdate: settingsController.isForceUpdate!,
            appLink:
                'https://play.google.com/store/apps/details?id=com.nextive.ieducation',
            settingsControllerIsInitiated: settingsControllerIsInitiated,
          );
        }
      });
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //    // controller.onRefresh();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      drawer: const GetDrawer(),
      appBar: getAppHeader(),
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 10,
              ),
              child: RefreshIndicator(
                onRefresh: controller.onRefresh,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      /* getBannerPart(),*/
                      getFreeContents(),
                      getCategories(),
                      getFeaturedCourses(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar getAppHeader() {
    return AppBar(
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      backgroundColor: CustomColors.pageBackground,
      elevation: 0,
      toolbarHeight: 65,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () => scaffoldKey.currentState!.openDrawer(),
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

  Widget getBannerPart() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 188,
          child: Center(
            child: Image.asset(
              'assets/images/carousel.png',
              scale: 1,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 7,
          child: Center(
            child: Image.asset(
              'assets/images/carousel_bottom.png',
              scale: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget getFreeContents() {
    return Column(
      children: [
        leftAlignTitle('Free contents'),
        const SizedBox(height: 10),
        Row(
          children: [
            getFreeContentsItem('exam'),
            const SizedBox(width: 20),
            getFreeContentsItem('course'),
          ],
        )
      ],
    );
  }

  Widget getFreeContentsItem(type) {
    double itemWidth =
        ((MediaQuery.of(context).size.width - 60.0) / 2).toPrecision(0);

    String icon = (type == "exam")
        ? 'assets/images/free_exam.png'
        : 'assets/images/free_course.png';

    String text = (type == "exam") ? 'Free Exams' : 'Free Courses';

    return GestureDetector(
      onTap: () {
        switch (type) {
          case 'exam':
            {
              Get.toNamed(RoutesPath.examCategories);
            }
            break;
          case 'course':
            {
              Get.toNamed(RoutesPath.freeCoursePage, arguments: ['free']);
            }
            break;
        }
      },
      child: Container(
        width: itemWidth,
        height: 113,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11.0),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: Center(
                  child: Image.asset(
                    icon,
                    scale: 1,
                    cacheHeight: 131,
                    cacheWidth: 131,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getCategories() {
    return Column(
      children: [
        const SizedBox(height: 20),
        leftAlignTitle('Categories'),
        const SizedBox(height: 10),
        Obx(() {
          return GridView.builder(
            shrinkWrap: true,
            itemCount: courseController.courseCategories.length,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                bool isBook = courseController.courseCategories
                        .elementAt(index)
                        .photo
                        .toString() ==
                    "assets/images/bookHouse.png";
                if (isBook) {
                  Get.toNamed(RoutesPath.productPage);
                } else {
                  Get.toNamed(
                    RoutesPath.courseAndCategoryPage,
                    arguments: [
                      courseController.courseCategories
                          .elementAt(index)
                          .slug
                          .toString()
                    ],
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: courseController.courseCategories
                                .elementAt(index)
                                .photo
                                .toString() ==
                            "assets/images/bookHouse.png"
                        ? Image.asset(
                            'assets/images/bookHouse.png',
                            scale: 1,
                            cacheHeight: 143,
                            cacheWidth: 390,
                          )
                        : AppCachedNetworkImage(
                            imageUrl: courseController.courseCategories
                                .elementAt(index)
                                .photo
                                .toString(),
                            cachedHeight: 180,
                            cachedWidth: 290,
                          ),
                  ),
                ),
              ),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
        }),
      ],
    );
  }

  Widget getFeaturedCourses() {
    return Column(
      children: [
        const SizedBox(height: 20),
        leftAlignTitle('Featured Courses'),
        const SizedBox(height: 10),
        getContents(),
      ],
    );
  }

  Widget getContents() {
    double responsiveWidth = MediaQuery.of(context).size.width - 20;
    double descriptionWidth = (responsiveWidth / 10.0) * 6;
    return SizedBox(
      width: responsiveWidth,
      child: SingleChildScrollView(
        child: Obx(() {
          if (courseController.courseRefreshing.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!courseController.courseRefreshing.value &&
              courseController.freeCourseList.isEmpty) {
            return Center(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
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
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  courseController.selectedFreeCourse =
                      courseController.freeCourseList.elementAt(index);
                  courseController.getIndividualCourse(
                      context,
                      courseController.freeCourseList
                          .elementAt(index)
                          .slug
                          .toString());
                  if (courseController.freeCourseList
                          .elementAt(index)
                          .subscriptionStatus ==
                      "active") {
                    Get.toNamed(RoutesPath.courseContentPage);
                  } else {
                    Get.toNamed(RoutesPath.courseDetail);
                  }
                  /*             Get.toNamed(RoutesPath.courseDetail);*/
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
                            imageUrl: courseController.freeCourseList
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: descriptionWidth - 20.0,
                              child: Text(
                                courseController.freeCourseList
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
                                        courseController.freeCourseList
                                            .elementAt(index)
                                            .usersCount
                                            .toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: CustomColors.enrolledColor,
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
            itemCount: courseController.freeCourseList.length,
            primary: false,
            shrinkWrap: true,
          );
        }),
      ),
    );
  }

  Widget getPrice(index) {
    double price = double.parse(AppConstants.getValueOrZero(
        courseController.freeCourseList.elementAt(index).price.toString()));
    double discountedPrice = double.parse(AppConstants.getValueOrZero(
        courseController.freeCourseList
            .elementAt(index)
            .discountedPrice
            .toString()));
    if (courseController.freeCourseList.elementAt(index).subscriptionStatus ==
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

  void _newUpdateDialog(
    BuildContext context, {
    required bool isForceUpdate,
    required String? appLink,
    bool? settingsControllerIsInitiated,
  }) {
    return WidgetsBinding.instance.addPostFrameCallback((_) {
      commonDialog(
        context: context,
        isDismissible: false,
        bodyContent: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Column(
            children: [
              const Text(
                'New Update Available!',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 21 / 16,
                  letterSpacing: 0.2,
                  color: CustomColors.mainColor,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/new_update.png',
                fit: BoxFit.contain,
                height: 220,
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Please update to the latest version',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        height: 21 / 14,
                        color: CustomColors.lightBlack80,
                      ),
                    ),
                  ),
                ],
              ),
              isForceUpdate
                  ? const Text(
                      'to continue using the app!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        height: 21 / 14,
                        color: CustomColors.lightBlack80,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        noButtonText: isForceUpdate ? 'Later' : null,
        yesButtonText: 'Update',
        onYesPressed: () async {
          if (await canLaunch(appLink ?? '')) {
            await launch(appLink ?? '');
          } else {
            throw 'Could not launch $appLink';
          }
        },
        onNoPressed: () {
          if (settingsControllerIsInitiated == false) {
            Get.find<SettingsController>().showUpdateDialog = false;
            Get.back();
            return;
          }
          if (isForceUpdate) {
            SystemNavigator.pop();
          } else {
            Get.find<SettingsController>().showUpdateDialog = false;
            Get.back();
          }
        },
      );
    });
  }
}
