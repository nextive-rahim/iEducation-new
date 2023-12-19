import 'package:flutter/material.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/course/model/individual_course_model.dart';
import 'package:ieducation/pages/course/view/course-detail/course-detail-section-content/course-detail-section-content.dart';

class CourseSectionItem extends StatefulWidget {
  final Section section;
  const CourseSectionItem({super.key, required this.section});

  @override
  State<CourseSectionItem> createState() => _CourseSectionItemState();
}

class _CourseSectionItemState extends State<CourseSectionItem> {
  bool showContent = false;

  String imageUrl = 'assets/images/final_progress.png';
  String arrrow = 'assets/images/arrow_up.png';
  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 160;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              showContent = !showContent;
            });
          },
          child: Container(
            constraints: const BoxConstraints(minHeight: 48),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: CustomColors.itemBorderColor, width: 0.5),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      imageUrl,
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    SizedBox(
                      width: responsiveWidth,
                      child: Text(
                        widget.section.title.toString(),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Transform.scale(
                  scaleY: showContent ? 1 : -1,
                  child: Image.asset(
                    arrrow,
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        showContent == true ? getSectionItem() : const SizedBox()
      ],
    );
  }

  Widget getSectionItem() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return CourseDetailSectionContent(
          content: widget.section.contents!.elementAt(index),
        );
      },
      itemCount: widget.section.contents!.length,
      primary: false,
      shrinkWrap: true,
    );
  }
}
