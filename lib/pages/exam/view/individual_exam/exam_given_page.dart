import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/pages/exam/controller/exam_controller.dart';
import 'package:ieducation/pages/exam/widget/mcq_item.dart';
import 'package:ieducation/utils/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

class ExamGivenPage extends StatefulWidget {
  const ExamGivenPage({super.key});

  @override
  _ExamGivenPageState createState() => _ExamGivenPageState();
}

class _ExamGivenPageState extends State<ExamGivenPage> {
  CountdownTimerController? controllerTimer;
  ExamController controller = Get.find();
  int endTime = 120;
  bool clicked = false;
  bool calledOneTime = false;

  @override
  void initState() {
    // TODO: implement initState
    endTime = (DateTime.now().millisecondsSinceEpoch +
            1000 *
                controller.mcqExamPageDetail.elementAt(0).duration!.toInt() *
                60)
        .toInt();

    controllerTimer = CountdownTimerController(endTime: endTime, onEnd: onEnd);

    super.initState();
  }

  void onEnd() {
    if (!clicked && calledOneTime == false) {
      setState(() {
        calledOneTime = true;
      });
      controller.submitExam(
          context, controller.mcqExamPageDetail.elementAt(0).id.toString());
    }
  }

  @override
  void dispose() {
    controllerTimer!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width;
    double responsiveHeight = MediaQuery.of(context).size.height - 180;
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        bool haveInput = true;
        if (haveInput == true) {
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(('Submit exam')),
                  content: const Text(('Are you sure?')),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        ('No'),
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                        child: const Text(
                          ('Yes'),
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Get.back();
                          setState(() {
                            clicked = true;
                          });
                          progressDialog(context);
                          controller.submitExam(
                            context,
                            controller.mcqExamPageDetail
                                .elementAt(0)
                                .id
                                .toString(),
                          );
                        })
                  ],
                );
              });
        } else {
          Navigator.of(context).pop();
        }

        return willLeave;
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  commonHeader('Exam', context),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      leftAlignTitle('Remaining time:'),
                      CountdownTimer(
                        controller: controllerTimer,
                        onEnd: onEnd,
                        endTime: endTime,
                        textStyle: const TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: MCQButtonColors.timeColor),
                        endWidget: const Text(
                          'Time expired',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: MCQButtonColors.timeColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              width: responsiveWidth,
              height: responsiveHeight,
              color: CustomColors.pageBackground,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    leftAlignTitle('Questions'),
                    getContents(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getContents() {
    return Obx(() {
      if (controller.mcqListRefreshing.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (controller.mcqExamPageDetail.isEmpty) {
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
                  'No detail is found',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return MCGItem(
                    McqItem: controller.mcqExamPageDetail
                        .elementAt(0)
                        .mcqs!
                        .elementAt(index),
                    index: index);
              },
              itemCount: controller.mcqExamPageDetail.elementAt(0).mcqs!.length,
              primary: false,
              shrinkWrap: true,
            ),
            const SizedBox(
              height: 25,
            ),
            !clicked
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(('Submit exam')),
                              content: const Text(('Are you sure?')),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    ('No'),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                    child: const Text(
                                      ('Yes'),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                      setState(() {
                                        clicked = true;
                                      });
                                      progressDialog(context);
                                      controller.submitExam(
                                        context,
                                        controller.mcqExamPageDetail
                                            .elementAt(0)
                                            .id
                                            .toString(),
                                      );
                                    })
                              ],
                            );
                          });
                    },
                    child: const CommonButton(
                      title: 'Finish Exam',
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      );
    });
  }
}
