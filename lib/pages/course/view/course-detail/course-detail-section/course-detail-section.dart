import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/course/view/course-detail/course-detail-section/section-item.dart';

class CourseDetailSection extends StatefulWidget {
  const CourseDetailSection({super.key});

  @override
  State<CourseDetailSection> createState() => _CourseDetailSectionState();
}

class _CourseDetailSectionState extends State<CourseDetailSection> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseController());
    return Obx(() {
      if (controller.courseRefreshing.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return CourseSectionItem(
            section: controller.selectedCourseSections.elementAt(index),
          );
        },
        itemCount: controller.selectedCourseSections.length,
        primary: false,
        shrinkWrap: true,
      );
    });
  }
}
