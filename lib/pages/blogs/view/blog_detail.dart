import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/blogs/controller/blog_controller.dart';
import 'package:ieducation/pages/exam/controller/exam_controller.dart';
import 'package:ieducation/utils/cached_network_image.dart';
import 'package:pod_player/pod_player.dart';

class BlogDetailPage extends StatefulWidget {
  const BlogDetailPage({super.key});

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  final controller = Get.find<BlogController>();
  final examController = Get.put(ExamController());
  late final PodPlayerController podController;
  @override
  void initState() {
    getBlogDetails();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    podController.dispose();
    super.dispose();
  }

  Future<void> getBlogDetails() async {
    await controller.getSingleBlog(Get.arguments[0]).then((value) {
      podController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(
          controller.singleBlog?.video ?? '',
        ),
      )..initialise();
    });
    //   setState(() {
    //     controller.selectedCommentableType = 'post';
    //     controller.selectedCommentableId = Get.arguments[1];
    //   });
    //   controller.getCommentList(Get.arguments[1], 'post');
  }

  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveText = MediaQuery.of(context).size.width - 60;
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      appBar: AppBar(
        title: const Text('Blogs Details'),
        centerTitle: true,
        backgroundColor: CustomColors.pageBackground,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Obx(() {
            if (controller.blogDetailsIsRefreshing.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!controller.blogDetailsIsRefreshing.value &&
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
            String url = controller.singleBlog?.video ?? 'null';
            String photoUrl = controller.singleBlog?.photo ?? '';
            String description = controller.singleBlog?.body ?? '';
            String createdAt =
                controller.singleBlog?.createdAt.toString() ?? '';
            String title = controller.singleBlog?.title ?? '';
            return Column(
              children: [
                url != 'null'
                    ? PodVideoPlayer(controller: podController)
                    : SizedBox(
                        height: 200,
                        width: responsiveWidth,
                        child: photoUrl != 'null'
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: AppCachedNetworkImage(
                                  imageUrl: photoUrl,
                                  fit: BoxFit.cover,
                                  cachedWidth: 640,
                                  cachedHeight: 400,
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
                  padding: const EdgeInsets.only(
                    right: 20,
                    top: 20,
                  ),
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
            );
          }),
        ),
      ),
    );
  }
}
