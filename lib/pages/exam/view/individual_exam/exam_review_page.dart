import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ieducation/app.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/pages/exam/controller/exam_controller.dart';

class ExamReviewPage extends StatefulWidget {
  const ExamReviewPage({super.key});

  @override
  State<ExamReviewPage> createState() => _ExamReviewPageState();
}

class _ExamReviewPageState extends State<ExamReviewPage> {
  final controller = Get.put(ExamController());

  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveHeight = MediaQuery.of(context).size.height - 140;
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            commonHeader('Exam Review', context),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: responsiveWidth,
              height: responsiveHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    getExamReview(),
                    const SizedBox(
                      height: 25,
                    ),
                    leftAlignTitle('Question Review'),
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

  Widget getExamReview() {
    if (controller.selectedExamData!.exam!.result == null) {
      return const SizedBox();
    }
    String startTime =
        controller.selectedExamData!.exam!.result!.startTime.toString();

    String endTime =
        controller.selectedExamData!.exam!.result!.endTime.toString();

    String totalMark = double.parse(AppConstants.getValueOrZero(
            controller.selectedExamData!.exam!.result!.totalMark.toString()))
        .toStringAsFixed(0);

    String obtainedMark = AppConstants.getValueOrZero(
        controller.selectedExamData!.exam!.result!.obtainedMark.toString());
    String mark = '$obtainedMark/$totalMark';
    return Column(
      children: [
        leftAlignTitle('Exam Review'),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            getExamReviewItem('time', getTimeDifference(startTime, endTime)),
            getExamReviewItem('your_score', mark),
            // getExamReviewItem('top_score', '09/10'),
            /*       getExamReviewItem('result', 'Fail'),*/
          ],
        ),
      ],
    );
  }

  Widget getExamReviewItem(title, value) {
    String imageUrl = '';
    String titleString = '';
    switch (title) {
      case 'time':
        {
          titleString = "Time Taken";
          imageUrl = 'assets/images/time_taken.png';
          break;
        }
      case 'your_score':
        {
          titleString = "Your Score";
          imageUrl = 'assets/images/score.png';
          break;
        }
      case 'top_score':
        {
          titleString = "Top Score";
          imageUrl = 'assets/images/top_score.png';
          break;
        }
      case 'result':
        {
          titleString = "Your Result";
          imageUrl = 'assets/images/result.png';
          break;
        }
    }
    return Container(
      height: 98,
      width: 73,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MCQButtonColors.initial),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            titleString,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 10),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: Center(
              child: Image.asset(
                imageUrl,
                scale: 1,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 14),
          )
        ],
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
                      fontFamily: 'Poppins',
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
                String indexString = (index + 1).toString();
                String questionPreText = '$indexString. ';
                double questionWidth = MediaQuery.of(context).size.width - 65;
                String itemA = controller.mcqExamPageDetail
                    .elementAt(0)
                    .mcqs!
                    .elementAt(index)
                    .a
                    .toString();
                String itemB = controller.mcqExamPageDetail
                    .elementAt(0)
                    .mcqs!
                    .elementAt(index)
                    .b
                    .toString();
                String itemC = controller.mcqExamPageDetail
                    .elementAt(0)
                    .mcqs!
                    .elementAt(index)
                    .c
                    .toString();
                String itemD = controller.mcqExamPageDetail
                    .elementAt(0)
                    .mcqs!
                    .elementAt(index)
                    .d
                    .toString();
                String itemE = controller.mcqExamPageDetail
                    .elementAt(0)
                    .mcqs!
                    .elementAt(index)
                    .e
                    .toString();
                String userAnswer = controller.mcqExamPageDetail
                    .elementAt(0)
                    .mcqs!
                    .elementAt(index)
                    .userAnswer
                    .toString();
                String answer = controller.mcqExamPageDetail
                    .elementAt(0)
                    .mcqs!
                    .elementAt(index)
                    .answer
                    .toString();

                String questionDescription = controller.mcqExamPageDetail
                    .elementAt(0)
                    .mcqs!
                    .elementAt(index)
                    .questionDescription
                    .toString();
                String questionPhoto = controller.mcqExamPageDetail
                    .elementAt(0)
                    .mcqs!
                    .elementAt(index)
                    .questionPhoto
                    .toString();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Question title
                    Row(
                      children: [
                        Text(
                          questionPreText,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        SizedBox(
                          width: questionWidth,
                          child: HtmlWidget(
                            controller.mcqExamPageDetail
                                .elementAt(0)
                                .mcqs!
                                .elementAt(index)
                                .question
                                .toString(),
                          
                          ),
                        )
                      ],
                    ),

                    questionDescription != "null"
                        ? Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: HtmlWidget(
                              questionDescription,
                             
                            ),
                          )
                        : const SizedBox(),
                    questionPhoto != 'null'
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 10),
                            child: Image.network(
                              questionPhoto,
                              height: 100,
                            ),
                          )
                        : const SizedBox(),

                    //Question answers
                    Column(
                      children: [
                        renderAnswerItem('a', itemA, userAnswer, answer),
                        const SizedBox(height: 10),
                        renderAnswerItem('b', itemB, userAnswer, answer),
                        const SizedBox(height: 10),
                        renderAnswerItem('c', itemC, userAnswer, answer),
                        const SizedBox(height: 10),
                        renderAnswerItem('d', itemD, userAnswer, answer),
                        itemE != 'null'
                            ? Column(
                                children: [
                                  const SizedBox(height: 10),
                                  renderAnswerItem(
                                      'e', itemE, userAnswer, answer)
                                ],
                              )
                            : const SizedBox()
                      ],
                    ),
                    controller.mcqExamPageDetail
                                .elementAt(0)
                                .mcqs!
                                .elementAt(index)
                                .answerDescription
                                .toString() !=
                            "null"
                        ? Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: HtmlWidget(
                          controller.mcqExamPageDetail
                                  .elementAt(0)
                                  .mcqs!
                                  .elementAt(index)
                                  .answerDescription
                                  .toString(),
                            
                            ),
                          )
                        : const SizedBox(),
                    controller.mcqExamPageDetail
                                .elementAt(0)
                                .mcqs!
                                .elementAt(index)
                                .answerPhoto !=
                            null
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 10),
                            child: Image.network(
                              controller.mcqExamPageDetail
                                  .elementAt(0)
                                  .mcqs!
                                  .elementAt(index)
                                  .answerPhoto
                                  .toString(),
                              height: 100,
                            ),
                          )
                        : const SizedBox()
                  ],
                );
              },
              itemCount: controller.mcqExamPageDetail.elementAt(0).mcqs!.length,
              primary: false,
              shrinkWrap: true,
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const CommonButton(
                title: 'Finish Review',
              ),
            )
          ],
        ),
      );
    });
  }

  Widget renderAnswerItem(index, choiceItem, userAnswer, questionAnswer) {
    if (userAnswer == 'null') {
      if (choiceItem == questionAnswer) {
        return renderNotAnswered(index, choiceItem, true, notAnswered: true);
      } else {
        return renderInitialBox(index, choiceItem);
      }
    } else if (choiceItem == userAnswer) {
      if (choiceItem == questionAnswer) {
        return renderRightAndWrongAnswerBox(index, choiceItem, true);
      } else {
        return renderRightAndWrongAnswerBox(index, choiceItem, false);
      }
    } else if (choiceItem == questionAnswer) {
      return renderNotAnswered(index, choiceItem, true);
    }
    return renderInitialBox(index, choiceItem);
  }

  Widget renderRightAndWrongAnswerBox(index, value, isRight) {
    String indexText = '$index.';
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveDescription = MediaQuery.of(context).size.width - 115;
    return Container(
      constraints: const BoxConstraints(
        minHeight: 33,
        maxHeight: double.infinity,
      ),
      width: responsiveWidth,
      decoration: BoxDecoration(
        color: isRight ? MCQButtonColors.rightBG : MCQButtonColors.wrongBG,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: isRight ? MCQButtonColors.right : MCQButtonColors.wrong),
      ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Center(
        child: Stack(
          children: [
            Row(
              children: [
                Text(
                  indexText,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                  width: responsiveDescription,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Center(
                    child: Image.asset(
                      isRight
                          ? 'assets/images/correctCircle.png'
                          : 'assets/images/crossCircle.png',
                      scale: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget renderNotAnswered(index, value, isRight, {bool notAnswered = false}) {
    String indexText = '$index.';
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveDescription = MediaQuery.of(context).size.width - 115;
    return Container(
      constraints: const BoxConstraints(
        minHeight: 33,
        maxHeight: double.infinity,
      ),
      width: responsiveWidth,
      decoration: BoxDecoration(
        color: notAnswered
            ? MCQButtonColors.notAnsweredBG
            : isRight
                ? MCQButtonColors.rightBG
                : MCQButtonColors.wrongBG,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: notAnswered
                ? MCQButtonColors.notAnsweredBorder
                : isRight
                    ? MCQButtonColors.right
                    : MCQButtonColors.wrong),
      ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Center(
        child: Stack(
          children: [
            Row(
              children: [
                Text(
                  indexText,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                  width: responsiveDescription,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget renderInitialBox(index, value) {
    String indexText = '$index.';
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double textWidth = MediaQuery.of(context).size.width - 90;
    return Container(
      constraints: const BoxConstraints(
        minHeight: 33,
        maxHeight: double.infinity,
      ),
      width: responsiveWidth,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: MCQButtonColors.initial),
      ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Center(
        child: Row(
          children: [
            Text(
              indexText,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            SizedBox(
              width: textWidth,
              child: Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isAnswerTrue(userAnswer, questionAnswer) {
    return userAnswer.toString() == questionAnswer.toString();
  }

  Widget questionIcon(String userAnswer, String answer) {
    if (userAnswer == answer) {
      return const Icon(Icons.check, color: Colors.green);
    } else if (userAnswer == 'null') {
      return const Icon(Icons.error_outline, color: Colors.red);
    }
    return const Icon(
      Icons.close,
      color: Colors.red,
    );
  }

  Widget GetIcon(String userAnswer, String radioValue) {
    if (userAnswer == radioValue) {
      return const Icon(
        Icons.radio_button_checked,
        color: Colors.green,
      );
    }
    return const Icon(Icons.radio_button_off);
  }

  String getTimeDifference(String start, String end) {
    if (start != 'null' && end != 'null') {
      DateTime time1 = DateTime.parse(start);
      DateTime time2 = DateTime.parse(end);
      int difference = time2.difference(time1).inSeconds;
      return intToTimeLeft(difference);
    }
    return '00:00';
  }

  String intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String result = "$h:$m:$s";

    return result;
  }
}
