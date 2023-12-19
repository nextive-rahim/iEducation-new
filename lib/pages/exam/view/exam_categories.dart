import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/pages/exam/controller/exam_controller.dart';
import 'package:ieducation/routes.dart';

class ExamCategories extends StatefulWidget {
  const ExamCategories({super.key});

  @override
  State<ExamCategories> createState() => _ExamCategoriesState();
}

class _ExamCategoriesState extends State<ExamCategories> {
  final controller = Get.put(ExamController());
  @override
  void initState() {
    super.initState();
    controller.getFreeExam(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            commonHeader('Exam Category', context),
            const SizedBox(
              height: 20,
            ),
            getExams(),
          ],
        ),
      ),
    );
  }

  Widget getExams() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveHeight = MediaQuery.of(context).size.height - 180;
    double imageWidth = (responsiveWidth / 10.0) * 4;
    double descriptionWidth = (responsiveWidth / 10.0) * 6;
    return SizedBox(
      height: responsiveHeight,
      width: responsiveWidth,
      child: SingleChildScrollView(
        child: Obx(() {
          if (controller.examRefreshing.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.freeExamList.isEmpty) {
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
                  setState(() {
                    controller.selectedExamIndex = index;
                  });
                  Get.toNamed(RoutesPath.freeExamPage);
                },
                child: Card(
                  child: SizedBox(
                    height: 100,
                    width: descriptionWidth,
                    child: Row(
                      children: [
                        SizedBox(
                          width: imageWidth,
                          child: CachedNetworkImage(
                            imageUrl: controller.freeExamList
                                .elementAt(index)
                                .photo
                                .toString(),
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return const Icon(Icons.error);
                            },
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
                                controller.freeExamList
                                    .elementAt(index)
                                    .title
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: controller.freeExamList.length,
            primary: false,
            shrinkWrap: true,
          );
        }),
      ),
    );
  }
}
