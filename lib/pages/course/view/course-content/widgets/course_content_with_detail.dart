import 'package:flutter/material.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/course/model/individual_course_model.dart';

class CourseContentWithDetail extends StatefulWidget {
  final Content content;
  const CourseContentWithDetail({super.key, required this.content});

  @override
  State<CourseContentWithDetail> createState() =>
      _CourseContentWithDetailState();
}

class _CourseContentWithDetailState extends State<CourseContentWithDetail> {
  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 106;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.itemBorderColor, width: 0.5),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
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
}
