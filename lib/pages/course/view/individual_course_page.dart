import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/routes.dart';

class IndividualCoursePage extends StatefulWidget {
  const IndividualCoursePage({super.key});

  @override
  State<IndividualCoursePage> createState() => _IndividualCoursePageState();
}

class _IndividualCoursePageState extends State<IndividualCoursePage> {
  final controller = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.selectedFreeCourse!.title.toString()),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshInfoList,
        child: Obx(() {
          if (controller.courseRefreshing.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!controller.courseRefreshing.value &&
              controller.selectedCourseSections.isEmpty) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  // Get.toNamed(RoutesPath.createInvoicePage);
                },
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
                          'Video List is Empty!!'.tr,
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Column(
            children: [getAttachmentSection(), getSectionItem()],
          );
        }),
      ),
    );
  }

  Future<Null> _refreshInfoList() async {
    controller.getIndividualCourse(
        context, controller.selectedFreeCourse!.slug.toString());
  }

  Widget getVideoSection(videoId, player) {
    return Hero(
      tag: videoId,
      child: player,
    );
  }

  Widget getAttachmentSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    child: const Text(
                      '0 PDFS',
                    ),
                    onPressed: () {},
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    child: const Text(
                      '0 NOTES',
                    ),
                    onPressed: () {},
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    child: const Text(
                      '0 EXAMS',
                    ),
                    onPressed: () {},
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    child: const Text(
                      '0 VIDEOS',
                    ),
                    onPressed: () {},
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget getTitleSection() {
    return Text(
      controller.selectedFreeCourse!.title.toString(),
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }

  Widget getSectionItem() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (!controller.selectedCourseSections.elementAt(index).isNull) {
              Get.toNamed(
                RoutesPath.videoSectionContent,
                arguments: [controller.selectedCourseSections.elementAt(index)],
              );
            } else {
              Get.snackbar('Error', 'No section found');
            }
          },
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.selectedCourseSections
                            .elementAt(index)
                            .title
                            .toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              const Icon(
                                Icons.play_circle,
                                color: Colors.red,
                                size: 20,
                              ),
                              Text(
                                controller.selectedCourseSections
                                    .elementAt(index)
                                    .contents!
                                    .length
                                    .toString(),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: controller.selectedCourseSections.length,
      primary: false,
      shrinkWrap: true,
    );
  }
}
