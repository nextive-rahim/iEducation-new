import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/pages/exam/controller/exam_controller.dart';

class FreeExamPage extends StatefulWidget {
  const FreeExamPage({super.key});

  @override
  State<FreeExamPage> createState() => _FreeExamPageState();
}

class _FreeExamPageState extends State<FreeExamPage> {
  final controller = Get.put(ExamController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            commonHeader('Exams', context),
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
    double responsiveHeight = MediaQuery.of(context).size.height - 120;
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
          if (!controller.examRefreshing.value &&
              controller.freeExamList
                  .elementAt(controller.selectedExamIndex)
                  .contents!
                  .isEmpty) {
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
                      'No exam is found',
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
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              String availableAt = controller.freeExamList
                  .elementAt(controller.selectedExamIndex)
                  .contents!
                  .elementAt(index)
                  .availableAt
                  .toString();
              String title = controller.freeExamList
                  .elementAt(controller.selectedExamIndex)
                  .contents!
                  .elementAt(index)
                  .title
                  .toString();
              String id = controller.freeExamList
                  .elementAt(controller.selectedExamIndex)
                  .contents!
                  .elementAt(index)
                  .id
                  .toString();
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.examPageComeFrom = 'free_exam';
                      controller.getIndividualExam(context, id);
                    },
                    child: Container(
                      height: 86,
                      width: responsiveWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: CustomColors.btnBackground),
                      ),
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 9),
                          Row(
                            children: [
                              SizedBox(
                                width: responsiveWidth - 40.0,
                                height: 45,
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                availableAt != 'null'
                                    ? Text(
                                        controller.dates(availableAt),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          color: CustomColors.enrolledColor,
                                        ),
                                      )
                                    : const SizedBox(),
                                availableAt != 'null'
                                    ? Text(
                                        controller.getTime(availableAt),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          color: CustomColors.enrolledColor,
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              );
            },
            itemCount: controller.freeExamList
                .elementAt(controller.selectedExamIndex)
                .contents!
                .length,
            primary: false,
            shrinkWrap: true,
          );
        }),
      ),
    );
  }
}
