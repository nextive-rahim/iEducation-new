import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ieducation/app.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/course/model/course_model.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/pages/course/widgets/course_title_section.dart';
import 'package:ieducation/pages/orders/controller/order_controller.dart';
import 'package:ieducation/pages/package/controller/package_controller.dart';
import 'package:ieducation/pages/package/model/single_package_model.dart';
import 'package:ieducation/routes.dart';
import 'package:ieducation/utils/progress_dialog.dart';

class PackageBuyPage extends StatefulWidget {
  const PackageBuyPage({super.key});

  @override
  State<PackageBuyPage> createState() => _PackageBuyPageState();
}

class _PackageBuyPageState extends State<PackageBuyPage> {
  final controller = Get.put(PackageController());
  final orderController = Get.put(OrderController());
  final courseController = Get.put(CourseController());

  bool showContent = true;

  @override
  void initState() {
    // TODO: implement initState
    controller.code.clear();
    controller.appliedCoupon = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height - 140;
    String imageUrl = controller.packageList
        .elementAt(controller.selectedPackageIndex)
        .photo
        .toString();
    String title = controller.packageList
        .elementAt(controller.selectedPackageIndex)
        .title
        .toString();
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              commonHeader('Package Details', context),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: responsiveHeight,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CourseTitleSection(
                        title: title,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      leftAlignTitle('Courses in this Category'),
                      const SizedBox(
                        height: 30,
                      ),
                      getCourses(),
                      const SizedBox(
                        height: 30,
                      ),
                      buyCourseSection()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getCourses() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double imageWidth = (responsiveWidth / 10.0) * 4;
    double descriptionWidth = (responsiveWidth / 10.0) * 6;
    return SizedBox(
      width: responsiveWidth,
      child: SingleChildScrollView(
        child: Obx(() {
          if (controller.singlePackageRefreshing.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.packageCourseList.elementAt(0).courses!.isEmpty) {
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
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  SinglePackageModelData data = controller.packageCourseList
                      .elementAt(0)
                      .courses!
                      .elementAt(index);

                  CourseModelData courseModelData = CourseModelData();
                  courseModelData.id = data.id;
                  courseModelData.createdBy = data.createdBy;
                  courseModelData.title = data.title;
                  courseModelData.slug = data.slug;
                  courseModelData.video = data.video;
                  courseModelData.photo = data.photo;
                  courseModelData.subtitle = data.subtitle;
                  courseModelData.description = data.description;
                  courseModelData.difficulty = data.difficulty;
                  courseModelData.language = data.language;
                  courseModelData.requirement = data.requirement;
                  courseModelData.outcome = data.outcome;
                  courseModelData.featured = data.featured;
                  courseModelData.duration = data.duration;
                  courseModelData.price = data.price;
                  courseModelData.discount = data.discount;
                  courseModelData.discountTill = data.discountTill;
                  courseModelData.discountedPrice = data.discountedPrice;
                  courseModelData.approved = data.approved;
                  courseModelData.active = data.active;
                  courseModelData.courseFeatures = data.courseFeatures;
                  courseModelData.subscriptionStatus = data.subscriptionStatus;
                  courseModelData.requireGuardiansPhone =
                      data.requireGuardiansPhone;
                  courseModelData.rating = double.parse(data.rating.toString());
                  courseModelData.usersCount = data.usersCount;
                  courseModelData.videoCount = data.videoCount;
                  courseModelData.audioCount = data.audioCount;
                  courseModelData.examCount = data.examCount;
                  courseModelData.pdfCount = data.pdfCount;
                  courseModelData.noteCount = data.noteCount;
                  courseModelData.linkCount = data.linkCount;
                  courseModelData.liveCount = data.liveCount;
                  courseModelData.zipCount = data.photo;
                  courseModelData.fileCount = data.photo;
                  courseModelData.writtenExamCount = data.photo;
                  courseModelData.fakeUserCount = data.fakeUserCount;

                  courseController.selectedFreeCourse = courseModelData;

                  courseController.getIndividualCourse(
                      context,
                      controller.packageCourseList
                          .elementAt(0)
                          .courses!
                          .elementAt(index)
                          .slug
                          .toString());
                  if (controller.packageCourseList
                          .elementAt(0)
                          .courses!
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
                          child: Image.network(
                            controller.packageCourseList
                                .elementAt(0)
                                .courses!
                                .elementAt(index)
                                .photo
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
                                controller.packageCourseList
                                    .elementAt(0)
                                    .courses!
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
                                        AppConstants.getValueOrZero(controller
                                            .packageCourseList
                                            .elementAt(0)
                                            .courses!
                                            .elementAt(index)
                                            .usersCount
                                            .toString()),
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
            itemCount:
                controller.packageCourseList.elementAt(0).courses!.length,
            primary: false,
            shrinkWrap: true,
          );
        }),
      ),
    );
  }

  Widget getPrice(index) {
    double price = double.parse(AppConstants.getValueOrZero(controller
        .packageCourseList
        .elementAt(0)
        .courses!
        .elementAt(index)
        .price
        .toString()));
    double discountedPrice = double.parse(AppConstants.getValueOrZero(controller
        .packageCourseList
        .elementAt(0)
        .courses!
        .elementAt(index)
        .discountedPrice
        .toString()));

    if (controller.packageCourseList
            .elementAt(0)
            .courses!
            .elementAt(index)
            .subscriptionStatus ==
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

  Widget getDescription() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    String description =
        controller.selectedPackageModel!.description.toString();
    if (description == 'null') return const SizedBox();
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'এই কোর্সটি থেকে যা শিখবেন:',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          width: responsiveWidth,
          padding: const EdgeInsets.all(10),
          child: HtmlWidget(
            description,
          ),
        )
      ],
    );
  }

  Widget buyCourseSection() {
    double multipleItem = (MediaQuery.of(context).size.width - 130) / 2;
    print(controller.selectedPackageModel!.toJson().toString());
    if (controller.selectedPackageModel!.subscriptionStatus == "active") {
      return const SizedBox();
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftAlignTitle('Coupon'),
            SizedBox(
              height: 41,
              width: multipleItem,
              child: TextFormField(
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                controller: controller.code,
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
                  hintText: 'Coupon',
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
            GestureDetector(
                onTap: () {
                  String code = controller.code.text.toString();
                  controller.params.clear();
                  controller.params['code'] = code;
                  controller.params['couponable_type'] = 'course';
                  controller.params['couponable_id'] =
                      controller.selectedPackageModel!.id.toString();
                  if (code.isNotEmpty) {
                    controller.validateCoupon(context);
                  }
                },
                child: getButton('Apply', multipleItem)),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() {
          if (controller.packageIsRefreshing.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.packageList.isEmpty) {
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
                      'No package is found',
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
          return GestureDetector(
            onTap: () {
              double price = double.parse(AppConstants.getValueOrZero(controller
                  .packageList
                  .elementAt(controller.selectedPackageIndex)
                  .price
                  .toString()));
              Map<String, dynamic> item = <String, dynamic>{};
              if (price < 1) {
                orderController.params.clear();
                item['id'] = controller.packageList
                    .elementAt(controller.selectedPackageIndex)
                    .id;
                item['type'] = 'package';
                orderController.params['item'] = item;
                progressDialog(context);
                orderController.createFreeOrder(context);
              } else {
                orderController.params.clear();
                orderController.params['type'] = "package";
                orderController.params['address_id'] = null;
                orderController.params['delivery_option_id'] = null;
                orderController.params['discount'] = null;
                orderController.params['coupon'] = '';
                if (controller.appliedCoupon != null) {
                  orderController.params['discount'] =
                      controller.appliedCoupon!.discount.toString();
                  orderController.params['coupon'] =
                      controller.appliedCoupon!.code.toString();
                }

                item['item_id'] = controller.packageList
                    .elementAt(controller.selectedPackageIndex)
                    .id
                    .toString();
                item['type'] = "package";
                item['quantity'] = 1;
                item['coupon'] = '';
                if (controller.appliedCoupon != null) {
                  item['coupon'] = controller.appliedCoupon!.code.toString();
                }
                orderController.params['items'] = [
                  item,
                ];
                progressDialog(context);
                orderController.createOrder(context);
              }
            },
            child: CommonButton(
              title: 'Enroll this Package at ৳${AppConstants.getValueOrZero(
                controller.packageList
                    .elementAt(controller.selectedPackageIndex)
                    .discountedPrice
                    .toString(),
              )}',
            ),
          );
        }),
      ],
    );
  }

  Widget getButton(title, btnWidth) {
    return Container(
      width: btnWidth,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CustomColors.btnBackground),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: MCQButtonColors.timeColor,
          ),
        ),
      ),
    );
  }
}
