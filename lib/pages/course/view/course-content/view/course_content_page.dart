import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/blogs/controller/blog_controller.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/course/view/course-content/widgets/course_section_with_count.dart';
import 'package:ieducation/routes.dart';

class CourseContentPage extends StatefulWidget {
  const CourseContentPage({super.key});

  @override
  State<CourseContentPage> createState() => _CourseContentPageState();
}

class _CourseContentPageState extends State<CourseContentPage> {
  final controller = Get.put(CourseController());
  final blogController = Get.find<BlogController>();
  @override
  Widget build(BuildContext context) {
    String courseName = controller.selectedFreeCourse!.title.toString();
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      appBar: AppBar(
        title: Text(courseName),
        centerTitle: true,
        backgroundColor: CustomColors.pageBackground,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Column(
                children: [getSectionItem()],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getSectionItem() {
    return Obx(() {
      if (controller.courseRefreshing.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (!controller.courseRefreshing.value &&
          controller.selectedCourseSections.isEmpty) {
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
                    'No content found!'.tr,
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

      return ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              controller.selectedCourseSection =
                  controller.selectedCourseSections.elementAt(index);
              blogController.selectedCommentableId = controller
                  .selectedCourseSections
                  .elementAt(index)
                  .id
                  .toString();
              blogController.selectedCommentableType = 'content';
              blogController.getCommentList(
                  controller.selectedCourseSections
                      .elementAt(index)
                      .id
                      .toString(),
                  'content');
              Get.toNamed(RoutesPath.courseContentDetailPage);
            },
            child: CourseSectionCount(
              section: controller.selectedCourseSections.elementAt(index),
            ),
          );
        },
        itemCount: controller.selectedCourseSections.length,
        primary: false,
        shrinkWrap: true,
      );
    });
  }
}
