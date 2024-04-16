import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/course/model/individual_course_model.dart';
import 'package:ieducation/pages/course/view/video_play_page.dart';
import 'package:ieducation/pages/exam/controller/exam_controller.dart';
import 'package:ieducation/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseContent extends StatefulWidget {
  final Content content;
  final int index;
  const CourseContent({
    super.key,
    required this.content,
    required this.index,
  });

  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  final controller = Get.put(CourseController());
  final examController = Get.put(ExamController());
  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 120;
    return GestureDetector(
      onTap: () {
        controller.selectedCourseContent = widget.content;
        controller.selectedCourseContentIndex = widget.index;
        if (widget.content.paid == false) {
          if (controller.selectedCourseContent!.type.toString() == "exam") {
            examController.examPageComeFrom = 'course_content';
            examController.getIndividualExam(
                context, controller.selectedCourseContent!.id.toString());
          } else if (controller.selectedCourseContent!.type.toString() ==
              "video") {
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
          } else if (controller.selectedCourseContent!.type.toString() ==
              'testmoj') {
            _launchURL(
                controller.selectedCourseContent!.testmoj!.examLink.toString());
          } else if (controller.selectedCourseContent!.type.toString() ==
              'link') {
            _launchURL(controller.selectedCourseContent!.link!.src.toString());
          } else if (controller.selectedCourseContent!.type.toString() ==
              'live') {
            _launchURL(controller.selectedCourseContent!.live!.link.toString());
          } else if (controller.selectedCourseContent!.type.toString() ==
              'pdf') {
            Get.toNamed(RoutesPath.pdfViewPage, arguments: [
              controller.selectedCourseContent!.pdf!.link.toString(),
              controller.selectedCourseContent!.title.toString(),
            ]);
          } else {
            Get.toNamed(RoutesPath.selectedContentPage);
          }
        } else {
          Get.snackbar('Sorry', 'Content is not free!');
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                getContentIcon(
                  widget.content.type.toString(),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: responsiveWidth,
                  child: Text(
                    widget.content.title.toString(),
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
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
    );
  }

  Widget getContentIcon(String type) {
    String imageUrl = '';
    switch (type) {
      case 'video':
        imageUrl = 'assets/images/video.png';
        break;
      case 'pdf':
        imageUrl = 'assets/images/pdf.png';
        break;
      case 'exam':
        imageUrl = 'assets/images/class_test_icon.png';
        break;
    }
    if (imageUrl == '') return const Icon(Icons.error);
    return Image.asset(
      imageUrl,
      height: 20,
      width: 20,
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
