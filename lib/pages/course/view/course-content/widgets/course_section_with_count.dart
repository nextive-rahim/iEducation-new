import 'package:flutter/material.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/course/model/individual_course_model.dart';

class CourseSectionCount extends StatefulWidget {
  final Section section;
  const CourseSectionCount({super.key, required this.section});

  @override
  State<CourseSectionCount> createState() => _CourseSectionCountState();
}

class _CourseSectionCountState extends State<CourseSectionCount> {
  @override
  Widget build(BuildContext context) {
    String imageUrlExam = 'assets/images/class_test_icon.png';
    String imageUrl = 'assets/images/final_progress.png';
    String imageUrlVideo = 'assets/images/course-content/video.png';
    String imageUrlPdf = 'assets/images/course-content/pdf.png';

    double responsiveWidth = MediaQuery.of(context).size.width - 172;
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 48),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: CustomColors.itemBorderColor, width: 0.5),
            color: Colors.white,
          ),
          child: Row(
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
                  )
                ],
              ),
              Row(
                children: [
                  contentCount('video', imageUrlVideo),
                  const SizedBox(
                    width: 4,
                  ),
                  contentCount('pdf', imageUrlPdf),
                  const SizedBox(
                    width: 4,
                  ),
                  contentCount('exam', imageUrlExam),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }

  String getItemCount(String type) {
    int videoCount = 0;
    int pdfCount = 0;
    int examCount = 0;

    for (int i = 0; i < widget.section.contents!.length; i++) {
      switch (widget.section.contents!.elementAt(i).type.toString()) {
        case 'live':
        case 'video':
          videoCount++;
          break;
        case 'note':
        case 'pdf':
          pdfCount++;
          break;
        case 'exam':
          examCount++;
          break;
      }
    }

    switch (type) {
      case 'video':
        return videoCount.toString();
      case 'pdf':
        return pdfCount.toString();
      case 'exam':
        return examCount.toString();
    }
    return '0';
  }

  Widget contentCount(String type, String imageUrl) {
    return Container(
      height: 34,
      width: 23,
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.btnBackground),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 4,
          ),
          type == 'exam'
              ? const Icon(
                  Icons.note_alt_outlined,
                  size: 13,
                  color: CustomColors.btnBackground,
                )
              : Image.asset(
                  imageUrl,
                  height: 12,
                  width: 12,
                ),
          Text(
            getItemCount(type),
            style: const TextStyle(
                fontSize: 8,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
