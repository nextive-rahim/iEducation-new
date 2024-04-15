import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/pages/course/widgets/VideoPlaySection.dart';
import 'package:ieducation/routes.dart';

class SelectedContentPage extends StatefulWidget {
  const SelectedContentPage({super.key});

  @override
  State<SelectedContentPage> createState() => _SelectedContentPageState();
}

class _SelectedContentPageState extends State<SelectedContentPage> {
  final controller = Get.put(CourseController());

  String fileName = '';
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Column(
              children: [
                getContentItem(),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getContentItem() {
    if (controller.selectedCourseContent!.type == 'video') {
      return Column(
        children: [
          getVideoSection(),
          const SizedBox(
            height: 20,
          ),
          getDescription(),
          const SizedBox(
            height: 250,
          ),
          getBottom()
        ],
      );
    } else if (controller.selectedCourseContent!.type == 'pdf') {
      fileName = controller.selectedCourseContent!.pdf!.link.toString();

      return const SizedBox();
    }
    return const Text('');
  }

  Widget getVideoSection() {
    String url = controller.selectedCourseContent!.video!.link.toString();

    return SizedBox(
      height: 200,
      child: url != 'null'
          ? VideoPlaySection(
        link: url,
      )
          : const Icon(
        Icons.error,
        color: Colors.orangeAccent,
        size: 40,
      ),
    );
  }

  Widget getDescription() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    String description =
    controller.selectedCourseContent!.description.toString();
    if (description == 'null') {
      return const SizedBox(
        height: 133,
      );
    }
    return Column(
      children: [
        leftAlignTitle('About this Class'),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 128,
          width: responsiveWidth,
          padding: const EdgeInsets.all(10),
          child: HtmlWidget(
        description,
           
          ),
        )
      ],
    );
  }

  Widget getBottom() {
    int nextIndex = controller.selectedCourseContentIndex! + 1;
    bool lastIndex =
    controller.selectedCourseSection!.contents!.length == nextIndex
        ? true
        : false;
    if (lastIndex) return const SizedBox();
    return GestureDetector(
      onTap: () {
        if (controller.selectedCourseSection!.contents!.length > nextIndex) {
          setState(() {
            controller.selectedCourseContent = controller
                .selectedCourseSection!.contents!
                .elementAt(nextIndex);
            controller.selectedCourseContentIndex = nextIndex;
          });
          Get.back();
          Get.toNamed(RoutesPath.selectedContentPage);
        }
      },
      child: const CommonButton(title: 'Next Item'),
    );
  }
}
