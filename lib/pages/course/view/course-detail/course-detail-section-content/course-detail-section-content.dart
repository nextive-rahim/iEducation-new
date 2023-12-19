import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/course/model/individual_course_model.dart';
import 'package:ieducation/pages/course/view/video_play_page.dart';
import 'package:ieducation/pages/exam/controller/exam_controller.dart';
import 'package:ieducation/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailSectionContent extends StatefulWidget {
  final Content content;
  const CourseDetailSectionContent({super.key, required this.content});

  @override
  State<CourseDetailSectionContent> createState() =>
      _CourseDetailSectionContentState();
}

class _CourseDetailSectionContentState
    extends State<CourseDetailSectionContent> {
  final controller = Get.put(CourseController());
  final examController = Get.put(ExamController());
  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 135;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.selectedCourseContent = widget.content;

            if (widget.content.paid == false) {
              String type = controller.selectedCourseContent!.type.toString();

              if (type == "exam") {
                examController.examPageComeFrom = 'course_content';
                examController.getIndividualExam(
                    context, controller.selectedCourseContent!.id.toString());
              } else if (type == "video") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return VideoPlayPage(
                        videoLink: controller.selectedCourseContent!.video!.link
                            .toString(),
                        contentId: controller.selectedCourseContent!.id,
                      );
                    },
                  ),
                );
              } else if (type == 'testmoj') {
                _launchURL(controller.selectedCourseContent!.testmoj!.examLink
                    .toString());
              } else if (type == 'link') {
                _launchURL(
                    controller.selectedCourseContent!.link!.src.toString());
              } else if (type == 'live') {
                _launchURL(
                    controller.selectedCourseContent!.live!.link.toString());
              } else if (type == 'pdf') {
                Get.toNamed(RoutesPath.pdfViewPage, arguments: [
                  controller.selectedCourseContent!.pdf!.link.toString(),
                  controller.selectedCourseContent!.title.toString(),
                ]);
              } else if (type == 'note') {
                Get.toNamed(RoutesPath.noteViewPage, arguments: [
                  controller.selectedCourseContent!.title.toString(),
                  controller.selectedCourseContent!.note!.body.toString()
                ]);
              } else {
                Get.toNamed(RoutesPath.selectedContentPage);
              }
            } else {
              Get.snackbar('Sorry', 'Content is not free!');
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: CustomColors.btnBackground, width: 0.5),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 6,
                    ),
                    Image.asset(
                      getImageUrl(widget.content.type.toString()),
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    SizedBox(
                      width: responsiveWidth,
                      child: Text(
                        widget.content.title.toString(),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
                widget.content.paid == true
                    ? Image.asset(
                        'assets/images/lock.png',
                        height: 20,
                        width: 20,
                      )
                    : Image.asset(
                        'assets/images/unlock.png',
                        height: 20,
                        width: 20,
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
  }

  String getImageUrl(String type) {
    String imageUrlExam = 'assets/images/examcontent.png';
    String imageUrlVideo = 'assets/images/videocontent.png';
    String imageUrlLive = 'assets/images/live.png';
    String imageUrlPdf = 'assets/images/pdfcontent.png';
    switch (type) {
      case 'live':
        return imageUrlLive;
      case 'video':
        return imageUrlVideo;
      case 'note':
      case 'pdf':
        return imageUrlPdf;
      case 'exam':
        return imageUrlExam;
    }
    return imageUrlPdf;
  }

  Future<void> _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
