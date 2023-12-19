import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
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
    double responsiveWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            commonHeader('Notice', context),
            const SizedBox(
              height: 25,
            ),
            getBlogList(),
          ],
        ),
      ),
    );
  }

  Widget getBlogList() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double textResponsiveWidth = MediaQuery.of(context).size.width - 160;
    double responsiveHeight = MediaQuery.of(context).size.height - 105;
    return SizedBox(
      height: responsiveHeight,
      width: responsiveWidth,
      child: SingleChildScrollView(
        child: Obx(() {
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
                    Icon(
                      Icons.search,
                      size: 50,
                    ),
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
              String description =
                  controller.noticeList.elementAt(index).body.toString();
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
                          context,
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
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 71,
                        ),
                        width: responsiveWidth,
                        padding: const EdgeInsets.only(left: 10, right: 10),
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
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            },
            itemCount: controller.noticeList.length,
            primary: false,
            shrinkWrap: true,
          );
        }),
      ),
    );
  }
}
