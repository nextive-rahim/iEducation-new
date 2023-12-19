import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ieducation/app.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/pages/course/widgets/course_section.dart';
import 'package:ieducation/pages/course/widgets/course_title_section.dart';
import 'package:ieducation/pages/course/view/course-detail/course-detail-section/course-detail-section.dart';
import 'package:ieducation/pages/orders/controller/order_controller.dart';
import 'package:ieducation/utils/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  final controller = Get.find<CourseController>();
  final orderController = Get.put(OrderController());

  bool showContent = false;

  @override
  void initState() {
    // TODO: implement initState
    controller.code.clear();
    controller.appliedCoupon = null;
    setState(() {
      showContent = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height - 140;
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              commonHeader('Course Details', context),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: responsiveHeight,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      getVideoSection(),
                      const SizedBox(
                        height: 25,
                      ),
                      CourseTitleSection(
                        title: controller.selectedFreeCourse!.title.toString(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      getInstructorSection(),
                      getDescription(),
                      const SizedBox(
                        height: 30,
                      ),
                      getCourseContents(),
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

  Widget getVideoSection() {
    String url = controller.selectedFreeCourse!.video.toString();
    String photo = controller.selectedFreeCourse!.photo.toString();
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white),
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxHeight: 200,
            ),
            width: responsiveWidth,
            child: photo != 'null'
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      photo,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(
                    Icons.error,
                    color: Colors.orangeAccent,
                    size: 40,
                  ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              getVideoSectionBottomItem('class'),
              getVideoSectionBottomItem('note'),
              getVideoSectionBottomItem('exam'),
              getVideoSectionBottomItem('user'),
            ],
          )
        ],
      ),
    );
  }

  Widget getVideoSectionBottomItem(String title) {
    String titleString = '';
    String imageUrl = '';
    String tempValue = '0';
/*    String titleString = title == "live" ? "লাইভ ক্লাস" : "কোর্সটি করেছেন";
    String imageUrl = title == "live"
        ? "assets/images/live_class.png"
        : 'assets/images/enrolled_count.png';*/
/*    String tempValue = title == "live"
        ? controller.selectedFreeCourse!.liveCount.toString()
        : controller.selectedFreeCourse!.usersCount.toString();*/

    switch (title) {
      case 'class':
        titleString = 'ক্লাস';
        imageUrl = "assets/images/videocontent.png";
        tempValue = (int.parse(AppConstants.getValueOrZero(
                    controller.selectedFreeCourse!.videoCount.toString())) +
                int.parse(AppConstants.getValueOrZero(
                    controller.selectedFreeCourse!.videoCount.toString())))
            .toString();
        break;
      case 'note':
        titleString = 'নোট';
        imageUrl = "assets/images/pdfcontent.png";
        tempValue = (int.parse(AppConstants.getValueOrZero(
                    controller.selectedFreeCourse!.pdfCount.toString())) +
                int.parse(AppConstants.getValueOrZero(
                    controller.selectedFreeCourse!.noteCount.toString())))
            .toString();
        break;
      case 'exam':
        titleString = 'এক্সাম ';
        imageUrl = "assets/images/examcontent.png";
        tempValue = AppConstants.getValueOrZero(
            controller.selectedFreeCourse!.examCount.toString());
        break;
      case 'user':
        titleString = 'শিক্ষার্থী';
        imageUrl = "assets/images/enrolled_count.png";
        tempValue = AppConstants.getValueOrZero(
            controller.selectedFreeCourse!.usersCount.toString());
    }
    String value = AppConstants.getValueOrZero(tempValue);

    return Column(
      children: [
        Image.asset(
          imageUrl,
          height: 44,
          width: 50,
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          titleString,
          style: const TextStyle(
              fontFamily: 'HindSiliguri',
              fontWeight: FontWeight.w400,
              fontSize: 12),
        ),
        Text(
          value,
          style: const TextStyle(
              fontFamily: 'HindSiliguri',
              fontWeight: FontWeight.w400,
              fontSize: 12),
        ),
      ],
    );
  }

  Widget getInstructorSection() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveTextWidth = MediaQuery.of(context).size.width - 130;
    return Obx(() {
      if (controller.courseRefreshing.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (controller.selectedCourseData == null) {
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
                  'No instructor is found',
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
          const Row(
            children: [
              Text(
                'ইনস্ট্রাক্টর',
                style: TextStyle(
                  fontFamily: 'HindSiliguri',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              String imageUrl =
                  controller.selectedCourseData!.users![index].photo.toString();

              String name = AppConstants.nullString(
                  controller.selectedCourseData!.users![index].name.toString());

              String currentInstitution = AppConstants.nullString(controller
                  .selectedCourseData!.users![index].currentInstitution
                  .toString());

              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 86,
                    width: responsiveWidth,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 58,
                          width: 58,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 17,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: responsiveTextWidth,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: responsiveTextWidth,
                              child: Text(
                                currentInstitution,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              );
            },
            itemCount: controller.selectedCourseData!.users!.length,
            primary: false,
            shrinkWrap: true,
          ),
        ],
      );
    });
  }

  Widget getDescription() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    String description = controller.selectedFreeCourse!.description.toString();
    if (description == 'null') return const SizedBox();
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Text(
              'কোর্স ডিটেইলস:',
              style: TextStyle(
                  fontFamily: 'HindSiliguri',
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

  Widget getCourseContents() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    String imageUrl = 'assets/images/arrow_up.png';

    return Column(
      children: [
        const Row(
          children: [
            Text(
              'এই কোর্সটি থেকে যা শিখবেন:',
              style: TextStyle(
                  fontFamily: 'HindSiliguri',
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Contents',
                    style: TextStyle(
                        fontFamily: 'HindSiliguri',
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showContent = !showContent;
                      });
                    },
                    child: Transform.scale(
                      scaleY: showContent ? 1 : -1,
                      child: Image.asset(
                        imageUrl,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ],
              ),
              showContent ? const CourseDetailSection() : const SizedBox()
            ],
          ),
        )
      ],
    );
  }

  Widget getSectionItem() {
    return Obx(() {
      if (controller.courseRefreshing.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return CourseSection(
            section: controller.selectedCourseSections.elementAt(index),
          );
        },
        itemCount: controller.selectedCourseSections.length,
        primary: false,
        shrinkWrap: true,
      );
    });
  }

  Widget buyCourseSection() {
    double multipleItem = (MediaQuery.of(context).size.width - 130) / 2;
    double singleItem = (MediaQuery.of(context).size.width - 40);
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
                      controller.selectedFreeCourse!.id.toString();
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
          if (controller.courseRefreshing.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.selectedCourseData == null) {
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
                      'No instructor is found',
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
              double price = double.parse(AppConstants.getValueOrZero(
                  controller.selectedCourseData!.price.toString()));
              Map<String, dynamic> item = <String, dynamic>{};
              if (price < 1) {
                orderController.params.clear();
                item['id'] = controller.selectedCourseData!.id;
                item['type'] = 'course';
                orderController.params['item'] = item;
                progressDialog(context);
                orderController.createFreeOrder(context);
              } else {
                orderController.params.clear();
                orderController.params['type'] = "course";
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

                item['item_id'] = controller.selectedCourseData!.id.toString();
                item['type'] = "course";
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
              title: 'Enroll this Course at ৳${AppConstants.getValueOrZero(
                controller.selectedCourseData!.discountedPrice.toString(),
              )}',
            ),
          );
        }),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  bool getPrice(index) {
    double price = double.parse(AppConstants.getValueOrZero(
        controller.freeCourseList.elementAt(index).price.toString()));
    if (price <= 0) {
      return true;
    }
    return false;
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

  Future<void> _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
