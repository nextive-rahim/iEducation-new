import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/pages/blogs/controller/blog_controller.dart';
import 'package:ieducation/pages/exam/controller/exam_controller.dart';

import '../../../common-widget/show_video.dart';

class BlogDetailPage extends StatefulWidget {
  const BlogDetailPage({super.key});

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  final controller = Get.find<BlogController>();
  final examController = Get.put(ExamController());
  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveText = MediaQuery.of(context).size.width - 60;
    double responsiveHeight = MediaQuery.of(context).size.height - 130;
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              commonHeader('Blog Details', context),
              const SizedBox(
                height: 25,
              ),
              Obx(() {
                if (controller.blogIsRefreshing.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!controller.blogIsRefreshing.value &&
                    controller.singleBlog == null) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.only(top: 20),
                      width: 250,
                      height: 120,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: 50,
                          ),
                          Text(
                            'No detail is found',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                String url = controller.singleBlog!.video.toString();
                String photoUrl = controller.singleBlog!.photo.toString();
                String description = controller.singleBlog!.body.toString();
                String createdAt = controller.singleBlog!.createdAt.toString();
                String title = controller.singleBlog!.title.toString();
                return SizedBox(
                  height: responsiveHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        url != 'null'
                            ? ShowVideo(
                                videoUrl: url,
                              )
                            : SizedBox(
                                height: 200,
                                width: responsiveWidth,
                                child: photoUrl != 'null'
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          photoUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.error,
                                        color: Colors.orangeAccent,
                                        size: 40,
                                      ),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              createdAt != 'null'
                                  ? Text(
                                      examController.getTime(createdAt),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        color: Colors.blueAccent,
                                      ),
                                    )
                                  : const SizedBox(),
                              createdAt != 'null'
                                  ? Text(
                                      examController.dates(createdAt),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        color: Colors.blueAccent,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                              width: 4,
                              child: Center(
                                child: Image.asset(
                                  'assets/images/vertical_cylinder.png',
                                  scale: 1,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: responsiveText,
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustomColors.pageBackground,
                          ),
                          width: responsiveWidth,
                          child: HtmlWidget(
                      description,
                           
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
