import 'package:flutter/material.dart';
import 'package:ieducation/pages/course/model/individual_course_model.dart';
import 'package:ieducation/pages/course/widgets/course_content.dart';

class CourseSection extends StatefulWidget {
  final Section section;
  const CourseSection({super.key, required this.section});

  @override
  State<CourseSection> createState() => _CourseSectionState();
}

class _CourseSectionState extends State<CourseSection> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return CourseContent(
            content: widget.section.contents!.elementAt(index), index: index);
      },
      itemCount: widget.section.contents!.length,
      primary: false,
      shrinkWrap: true,
    );
  }
}
