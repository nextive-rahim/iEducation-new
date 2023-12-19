import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/exam/controller/exam_controller.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class ExamDetailPage extends StatefulWidget {
  const ExamDetailPage({super.key});

  @override
  State<ExamDetailPage> createState() => _ExamDetailPageState();
}

class _ExamDetailPageState extends State<ExamDetailPage> {
  final controller = Get.put(ExamController());
  Timer? timer;
  int counter = 0;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => addValue());
  }

  @override
  void deactivate() {
    // Pauses timer while navigating to next page.
    timer?.cancel();
    super.deactivate();
  }

  void addValue() {
    String startTime = controller.selectedExamData!.exam!.startTime.toString();
    String resultPublishTime =
        controller.selectedExamData!.exam!.resultPublishTime.toString();
    DateTime start =
        DateTime.parse(startTime.substring(0, startTime.length - 1))
            .add(const Duration(hours: 6));
    DateTime end = DateTime.parse(
            resultPublishTime.substring(0, resultPublishTime.length - 1))
        .add(const Duration(hours: 6));
    final now = DateTime.now();
    int difference1 = start.difference(now).inSeconds;
    int difference2 = end.difference(now).inSeconds;
    if (difference1 == 0 || difference2 == 0) {
      controller.examRefreshing.value = true;
    } else {
      controller.examRefreshing.value = false;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        title: Text(
          controller.selectedExamData!.title.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: CustomColors.pageBackground,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshInfoList,
        child: Obx(() {
          if (controller.examRefreshing.value) {
            return Center(
                child: Image.asset(
              'assets/images/loading.gif',
              height: 150,
              fit: BoxFit.scaleDown,
            ));
          }
          if (controller.examRefreshing.value) {
            return Center(
                child: Image.asset(
              'assets/images/loading.gif',
              height: 150,
              fit: BoxFit.scaleDown,
            ));
          }
          if (!controller.examRefreshing.value &&
              controller.selectedExamData == null) {
            return Center(
              child: Card(
                elevation: 8,
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: 250,
                  height: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.search,
                        size: 50,
                      ),
                      Text(
                        'No details is found!'.tr,
                        style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SizedBox(
              height: 700,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    controller.selectedExamData!.exam!.result != null
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  Text(
                                    'ফলাফল',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23),
                                  ),
                                  SizedBox(),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              RowItem(
                                'প্রাপ্ত নাম্বার',
                                (controller.selectedExamData!.exam!.result!
                                            .obtainedMark
                                            .toString() !=
                                        'null'
                                    ? controller.selectedExamData!.exam!.result!
                                        .obtainedMark
                                        .toString()
                                    : 'N/A out of ${controller.selectedExamData!.exam!
                                            .result!.totalMark}'),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              RowItem(
                                'সঠিক',
                                (controller
                                    .selectedExamData!.exam!.result!.correct
                                    .toString()),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              RowItem(
                                'ভুল',
                                (controller
                                    .selectedExamData!.exam!.result!.wrong
                                    .toString()),
                              )
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Text(
                          'বিস্তারিত',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 23),
                        ),
                        SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RowItem('মোট প্রশ্ন',
                        controller.selectedExamData!.exam!.mcqCount.toString()),
                    const SizedBox(
                      height: 5,
                    ),
                    RowItem(
                        'সময়',
                        ('${controller.selectedExamData!.exam!.duration} মিনিট')),
                    const SizedBox(
                      height: 5,
                    ),
                    RowItem(
                        'প্রতি প্রশ্নের নাম্বার',
                        (controller.selectedExamData!.exam!.perQuestionMark
                            .toString())),
                    const SizedBox(
                      height: 5,
                    ),
                    RowItem(
                        'প্রতি ভুল উত্তরে নাম্বার কাটবে',
                        (controller.selectedExamData!.exam!.negativeMark
                            .toString())),
                    const SizedBox(
                      height: 5,
                    ),
                    RowItem(
                        'পরীক্ষা শুরু',
                        (dates(controller.selectedExamData!.exam!.startTime
                            .toString()))),
                    const SizedBox(
                      height: 5,
                    ),
                    RowItem(
                        'পরীক্ষা শেষ',
                        (dates(controller.selectedExamData!.exam!.endTime
                            .toString()))),
                    const SizedBox(
                      height: 5,
                    ),
                    RowItem(
                        'ফলাফল প্রকাশ',
                        (dates(controller
                            .selectedExamData!.exam!.resultPublishTime
                            .toString()))),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        examStarted() &&
                                !examFinish() &&
                                controller.selectedExamData!.exam!.result ==
                                    null
                            ? Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    timer?.cancel();
                                    /*       ProgressDialog.show(
                                        Get.context!, "Processing..");
                                    controller.startExam(controller
                                        .selectedExam!.exam!.id
                                        .toString());*/
                                  },
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                        child: Text(
                                      'পরীক্ষা দিন',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        resultPublish() &&
                                controller.selectedExamData!.exam!.result !=
                                    null
                            ? Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    timer?.cancel();
/*
                                    controller.getMCQExamDetail(controller
                                        .selectedExam!.exam!.id
                                        .toString());*/
                                    /*       controller.ExamDetailTitle = 'ফলাফল দেখুন';*/
                                  },
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                        child: Text(
                                      'ফলাফল দেখুন',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        examFinish() &&
                                resultPublish() &&
                                controller.selectedExamData!.exam!.result ==
                                    null
                            ? Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    /*                          timer?.cancel();
                                    controller.getMCQExamDetail(controller
                                        .selectedExam!.exam!.id
                                        .toString());
                                    controller.ExamDetailTitle =
                                        'উত্তরপত্র দেখুন';*/
                                  },
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                        child: Text(
                                      'উত্তরপত্র দেখুন',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          width: 5,
                        ),
                        resultPublish() &&
                                controller.selectedExamData!.exam!.result !=
                                    null
                            ? Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    /*            timer?.cancel();
                                    controller.getRankingList(controller
                                        .selectedExam!.slug
                                        .toString());
                                    Get.toNamed(RoutesPath.rankingListPage);*/
                                  },
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                        child: Text(
                                      'রেঙ্কিং দেখুন ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  int getTimeDifference(String date) {
    if (date != 'null') {
      DateTime end = DateTime.parse(date.substring(0, date.length - 1))
          .add(const Duration(hours: 6));
      final date2 = DateTime.now();
      int difference = end.difference(date2).inSeconds;
      return difference;
    }
    return -1;
  }

  bool examStarted() {
    String startTime = controller.selectedExamData!.exam!.startTime.toString();
    return getTimeDifferenceFunction(startTime);
  }

  bool examFinish() {
    String endTime = controller.selectedExamData!.exam!.endTime.toString();
    return getTimeDifferenceFunction(endTime);
  }

  bool resultPublish() {
    String resultPublishTime =
        controller.selectedExamData!.exam!.resultPublishTime.toString();
    return getTimeDifferenceFunction(resultPublishTime);
  }

  bool getTimeDifferenceFunction(String date) {
    if (date != 'null') {
      DateTime start = DateTime.parse(date.substring(0, date.length - 1))
          .add(const Duration(hours: 6));
      final now = DateTime.now();
      int difference = start.difference(now).inSeconds;
      if (difference >= 0) {
        return false;
      } else {
        return true;
      }
    }
    return true;
  }

  Widget RowItem(Key, Value) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.black12, width: 1))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Key.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 8,
                  ),
                  child: Text(
                    Value.toString() != 'null' ? Value.toString() : 'N/A',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String dates(String s) {
    if (s == 'null') {
      return 'N/A';
    }
    DateTime end = DateTime.parse(s.substring(0, s.length - 1))
        .add(const Duration(hours: 6));
    final date2 = DateTime.now();
    final difference = end.difference(date2).inSeconds;
    DateTime tempDate = DateFormat("hh:mm")
        .parse("${end.hour}:${end.minute}");
    var dateFormat = DateFormat("h:mm a"); // you can change the format here
    String Final = '${end.day} ${month(end.month.toString())} ${end.year} - ${dateFormat.format(tempDate)}';
    return Final;
  }

  String month(String m) {
    if (m == '1') {
      return 'Jan';
    } else if (m == '2')
      return 'Feb';
    else if (m == '3')
      return 'Mar';
    else if (m == '4')
      return 'Apr';
    else if (m == '5')
      return 'May';
    else if (m == '6')
      return 'Jun';
    else if (m == '7')
      return 'Jul';
    else if (m == '8')
      return 'Aug';
    else if (m == '9')
      return 'Sept';
    else if (m == '10')
      return 'Oct';
    else if (m == '11')
      return 'Nov';
    else
      return 'Dec';
  }

  Future<Null> _refreshInfoList() async {}
}
