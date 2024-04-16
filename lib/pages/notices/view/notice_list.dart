import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/notices/controller/notice_controller.dart';
import 'package:ieducation/routes.dart';

import '../../blogs/controller/blog_controller.dart';

class NoticeListPage extends StatefulWidget {
  const NoticeListPage({super.key});

  @override
  State<NoticeListPage> createState() => _NoticeListPageState();
}

class _NoticeListPageState extends State<NoticeListPage> {
  final controller = Get.put(NoticeController());
  final blogController = Get.find<BlogController>();
  @override
  void initState() {
    // TODO: implement initState

    controller.getNoticeList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      appBar: AppBar(
        title: const Text('Notice'),
        centerTitle: true,
        backgroundColor: CustomColors.pageBackground,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 15,
          ),
          child: getBlogList(),
        ),
      ),
    );
  }

  Widget getBlogList() {
    double textResponsiveWidth = MediaQuery.of(context).size.width - 160;
    return Obx(() {
      if (controller.noticeIsRefreshing.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (!controller.noticeIsRefreshing.value &&
          controller.noticeList.isEmpty) {
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
                Icon(Icons.search, size: 50),
                Text(
                  'No notice is found',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          String createdAt =
              controller.noticeList.elementAt(index).createdAt.toString();

          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.selectedNoticeIndex = index;
                  Get.toNamed(RoutesPath.noticeDetailPage);

                  blogController.selectedCommentableType = 'notice';
                  blogController.selectedCommentableId =
                      controller.noticeList.elementAt(index).id.toString();

                  blogController.getCommentList(
                     
                      controller.noticeList.elementAt(index).id.toString(),
                      'notice');
                },
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: textResponsiveWidth,
                                child: Text(
                                  controller.noticeList
                                      .elementAt(index)
                                      .title
                                      .toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                controller.dates(createdAt),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                controller.getTime(createdAt),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  color: Colors.blue,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: controller.noticeList.length,
        primary: false,
        shrinkWrap: true,
      );
    });
  }
}
