import 'package:flutter/material.dart';

class CourseTitleSection extends StatefulWidget {
  final String title;
  const CourseTitleSection({super.key, required this.title});

  @override
  State<CourseTitleSection> createState() => _CourseTitleSectionState();
}

class _CourseTitleSectionState extends State<CourseTitleSection> {
  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    return SizedBox(
      width: responsiveWidth,
      child: Text(
        widget.title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
    );
  }
}
