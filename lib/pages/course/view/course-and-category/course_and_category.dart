import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/app.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/course/model/category_children_model.dart'
    as CategoryChildrenData;
import 'package:ieducation/pages/course/model/course_children_model.dart';
import 'package:ieducation/pages/course/model/course_model.dart';
import 'package:ieducation/routes.dart';
import 'package:ieducation/utils/cached_network_image.dart';

class CourseAndCategoryPage extends StatefulWidget {
  const CourseAndCategoryPage({super.key});

  @override
  State<CourseAndCategoryPage> createState() => _CourseAndCategoryPageState();
}

class _CourseAndCategoryPageState extends State<CourseAndCategoryPage> {
  final CourseController controller = Get.find();

  List<CategoryChildrenData.Child>? categoriesChild = [];
  List<CourseChildrenData>? courseChildList = [];
  String? slug;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.arguments != null) {
        setState(() {
          slug = Get.arguments[0];
        });
        controller
            .getCourseCategories(context, slug)
            .then((value) => setState(() {
                  categoriesChild = value;
                }));
        controller
            .getCourseByCategory(context, slug)
            .then((value) => setState(() {
                  courseChildList = value;
                }));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height - 128;
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
            Container(
              height: responsiveHeight,
              color: CustomColors.bodyBackground,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    leftAlignTitle('Courses'),
                    getContents(),
                    const SizedBox(
                      height: 20,
                    ),
                    leftAlignTitle('Categories'),
                    getCategories(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getContents() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double imageWidth = (responsiveWidth / 10.0) * 4;
    double descriptionWidth = (responsiveWidth / 10.0) * 6;
    if (controller.courseRefreshing.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (courseChildList == null || !courseChildList!.isNotEmpty) {
      return Center(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
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
    return SizedBox(
      width: responsiveWidth,
      child: ListView.builder(
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setSelectedCourse(index);

              if (courseChildList!.elementAt(index).subscriptionStatus ==
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
                        imageUrl:
                            courseChildList!.elementAt(index).photo.toString(),
                        fit: BoxFit.cover,
                        cachedHeight: 221,
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
                            courseChildList!.elementAt(index).title.toString(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    courseChildList!
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
        itemCount: courseChildList!.length,
        primary: false,
        shrinkWrap: true,
      ),
    );
  }

  Widget getPrice(index) {
    double price = double.parse(AppConstants.getValueOrZero(
        courseChildList!.elementAt(index).price.toString()));
    double discountedPrice = double.parse(AppConstants.getValueOrZero(
        courseChildList!.elementAt(index).discountedPrice.toString()));

    if (courseChildList!.elementAt(index).subscriptionStatus == "active") {
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

  Widget getCategories() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    if (controller.categoryRefreshing.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (categoriesChild == null || !categoriesChild!.isNotEmpty) {
      return Center(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
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
                'No category is found',
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
    return Column(
      children: [
        Container(
          width: responsiveWidth,
          decoration: const BoxDecoration(
            color: CustomColors.pageBackground,
          ),
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: categoriesChild!.length,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Get.to(() => const CourseAndCategoryPage(),
                    arguments: [
                      categoriesChild!.elementAt(index).slug.toString()
                    ],
                    preventDuplicates: false);
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: CachedNetworkImage(
                        imageUrl:
                            categoriesChild!.elementAt(index).photo.toString(),
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    categoriesChild!.elementAt(index).name.toString(),
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )
                ],
              ),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0),
          ),
        ),
      ],
    );
  }

  void setSelectedCourse(index) {
    CourseModelData tempCourseData = CourseModelData();
    tempCourseData.id = courseChildList!.elementAt(index).id;
    tempCourseData.createdBy = courseChildList!.elementAt(index).createdBy;
    tempCourseData.title = courseChildList!.elementAt(index).title;
    tempCourseData.slug = courseChildList!.elementAt(index).slug;
    tempCourseData.video = courseChildList!.elementAt(index).video;
    tempCourseData.photo = courseChildList!.elementAt(index).photo;
    tempCourseData.photo = courseChildList!.elementAt(index).photo;
    tempCourseData.subtitle = courseChildList!.elementAt(index).subtitle;
    tempCourseData.subtitle = courseChildList!.elementAt(index).subtitle;
    tempCourseData.description = courseChildList!.elementAt(index).description;
    tempCourseData.difficulty = courseChildList!.elementAt(index).difficulty;
    tempCourseData.language = courseChildList!.elementAt(index).language;
    tempCourseData.requirement = courseChildList!.elementAt(index).requirement;
    tempCourseData.outcome = courseChildList!.elementAt(index).outcome;
    tempCourseData.featured = courseChildList!.elementAt(index).featured;
    tempCourseData.duration = courseChildList!.elementAt(index).duration;
    tempCourseData.price = courseChildList!.elementAt(index).price;
    tempCourseData.discount = courseChildList!.elementAt(index).discount;
    tempCourseData.discountTill =
        courseChildList!.elementAt(index).discountTill;
    tempCourseData.discountedPrice =
        courseChildList!.elementAt(index).discountedPrice;
    tempCourseData.approved = courseChildList!.elementAt(index).approved;
    tempCourseData.active = courseChildList!.elementAt(index).active;
    tempCourseData.courseFeatures =
        courseChildList!.elementAt(index).courseFeatures;
    tempCourseData.subscriptionStatus =
        courseChildList!.elementAt(index).subscriptionStatus;
    tempCourseData.requireGuardiansPhone =
        courseChildList!.elementAt(index).requireGuardiansPhone;
    tempCourseData.rating = courseChildList!.elementAt(index).rating;
    tempCourseData.usersCount = courseChildList!.elementAt(index).usersCount;
    tempCourseData.fakeUserCount =
        courseChildList!.elementAt(index).fakeUserCount;
    tempCourseData.videoCount = courseChildList!.elementAt(index).videoCount;
    tempCourseData.audioCount = courseChildList!.elementAt(index).audioCount;
    tempCourseData.examCount = courseChildList!.elementAt(index).examCount;
    tempCourseData.pdfCount = courseChildList!.elementAt(index).pdfCount;
    tempCourseData.noteCount = courseChildList!.elementAt(index).noteCount;
    tempCourseData.linkCount = courseChildList!.elementAt(index).linkCount;
    tempCourseData.liveCount = courseChildList!.elementAt(index).liveCount;
    tempCourseData.zipCount = courseChildList!.elementAt(index).zipCount;
    tempCourseData.fileCount = courseChildList!.elementAt(index).fileCount;
    tempCourseData.writtenExamCount =
        courseChildList!.elementAt(index).writtenExamCount;
    controller.selectedFreeCourse = tempCourseData;
    controller.getIndividualCourse(
        context, courseChildList!.elementAt(index).slug.toString());
  }

  String getEnrolledString(value) {
    if (value.toString() == "active") {
      return "Enrolled";
    }
    return '';
  }

  Future<Null> _refreshInfoList() async {}
}
