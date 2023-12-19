import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/pages/notices/controller/notice_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common-widget/common_comment_widget.dart';

class NoticeDetailPage extends StatefulWidget {
  const NoticeDetailPage({super.key});

  @override
  State<NoticeDetailPage> createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {
  final controller = Get.put(NoticeController());

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
              commonHeader('Notice', context),
              const SizedBox(
                height: 25,
              ),
              Obx(() {
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
                            'No detail is found',
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
                String url = controller.noticeList
                    .elementAt(controller.selectedNoticeIndex)
                    .photo
                    .toString();
                String description = controller.noticeList
                    .elementAt(controller.selectedNoticeIndex)
                    .body
                    .toString();
                String createdAt = controller.noticeList
                    .elementAt(controller.selectedNoticeIndex)
                    .createdAt
                    .toString();
                String title = controller.noticeList
                    .elementAt(controller.selectedNoticeIndex)
                    .title
                    .toString();
                return SizedBox(
                  height: responsiveHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: url,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return const Icon(Icons.error);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              createdAt != 'null'
                                  ? Text(
                                      controller.getTime(createdAt),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        color: Colors.blueAccent,
                                      ),
                                    )
                                  : const SizedBox(),
                              createdAt != 'null'
                                  ? Text(
                                      controller.dates(createdAt),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
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
                                  fontFamily: 'Poppins',
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
                        const commonCommentWidget()
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

  Future<void> _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
