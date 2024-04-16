import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/pages/blogs/controller/blog_controller.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/course/view/course-content/widgets/course_content_with_detail.dart';
import 'package:ieducation/pages/course/view/video_play_page.dart';
import 'package:ieducation/pages/exam/controller/exam_controller.dart';
import 'package:ieducation/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseContentDetailPage extends StatefulWidget {
  const CourseContentDetailPage({super.key});

  @override
  State<CourseContentDetailPage> createState() =>
      _CourseContentDetailPageState();
}

class _CourseContentDetailPageState extends State<CourseContentDetailPage> {
  final controller = Get.put(CourseController());
  final examController = Get.put(ExamController());
  final blogController = Get.find<BlogController>();
  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height - 160;
    String sectionName = controller.selectedCourseSection!.title.toString();
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            commonHeader(sectionName, context),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: responsiveHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [getSectionItem()],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getSectionItem() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            controller.selectedCourseContent =
                controller.selectedCourseSection!.contents!.elementAt(index);
            blogController.selectedCommentableId = controller
                .selectedCourseSection!.contents!
                .elementAt(index)
                .id
                .toString();
            blogController.selectedCommentableType = 'content';
            blogController.getCommentList(
            
                blogController.selectedCommentableId.toString(),
                blogController.selectedCommentableType.toString());
            controller.selectedCourseContentIndex = index;

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
          },
          child: CourseContentWithDetail(
            content:
                controller.selectedCourseSection!.contents!.elementAt(index),
          ),
        );
      },
      itemCount: controller.selectedCourseSection!.contents!.length,
      primary: false,
      shrinkWrap: true,
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
