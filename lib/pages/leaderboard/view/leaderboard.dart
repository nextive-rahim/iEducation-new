import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/pages/exam/controller/exam_controller.dart';
import 'package:ieducation/pages/home/controller/home_controller.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  final controller = Get.put(ExamController());
  final homeController = Get.find<HomeController>();
  @override
  void initState() {
    // TODO: implement initState
    homeController.getUserInfo();
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
            commonHeader('Leaderboard', context),
            getRankList(),
          ],
        ),
      ),
    );
  }

  Widget getRankList() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double textResponsiveWidth = MediaQuery.of(context).size.width - 150;
    double responsiveHeight = MediaQuery.of(context).size.height - 90;
    return SizedBox(
      height: responsiveHeight,
      width: responsiveWidth,
      child: Obx(() {
        if (controller.rankingRefreshing.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!controller.rankingRefreshing.value &&
            controller.rankingListMain.isEmpty) {
          return const SizedBox();
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  String name = 'N/A';
                  if (controller.rankingListMain[index].user != null &&
                      controller.rankingListMain[index].user!.name != null) {
                    name =
                        controller.rankingListMain[index].user!.name.toString();
                  }
                  String currentInstitution = 'N/A';

                  if (controller.rankingListMain[index].user != null &&
                      controller.rankingListMain[index].user!
                              .currentInstitution !=
                          null) {
                    currentInstitution = controller
                        .rankingListMain[index].user!.currentInstitution
                        .toString();
                  }
                  String timeDifference = getTimeDifference(
                      controller.rankingListMain[index].startTime.toString(),
                      controller.rankingListMain[index].endTime.toString());
                  String score = controller.rankingListMain[index].obtainedMark
                              .toString() ==
                          'null'
                      ? '0'
                      : controller.rankingListMain[index].obtainedMark
                          .toString();
                  bool isMyScore = false;

                  if (controller.rankingListMain[index].user != null &&
                      controller.rankingListMain[index].user!.id != null) {
                    isMyScore = homeController.myInfo.isNotEmpty &&
                        controller.rankingListMain[index].user!.id.toString() ==
                            homeController.myInfo.elementAt(0).id.toString();
                  }
                  return Column(
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          minHeight: 51,
                        ),
                        width: responsiveWidth,
                        decoration: BoxDecoration(
                          color:
                              isMyScore ? CustomColors.myScoreBG : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: isMyScore
                                  ? CustomColors.btnBackground
                                  : CustomColors.userScoreBorder,
                              width: isMyScore ? 2 : 1),
                        ),
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: CustomColors.indexBGColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: MCQButtonColors.timeColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: textResponsiveWidth,
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: textResponsiveWidth,
                                  child: Text(
                                    currentInstitution,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/time_taken.png',
                                          scale: 1,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      timeDifference,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.black87,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/score.png',
                                          scale: 1,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      score,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.black87,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  );
                },
                itemCount: controller.rankingListMain.length,
                primary: false,
                shrinkWrap: true,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const CommonButton(
                  title: 'Done',
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  String getTimeDifference(String start, String end) {
    if (start != 'null' && end != 'null') {
      DateTime time1 = DateTime.parse(start);
      DateTime time2 = DateTime.parse(end);
      int difference = time2.difference(time1).inSeconds;
      return intToTimeLeft(difference);
    }
    return 'N/A';
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
