import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/blogs/controller/blog_controller.dart';
import 'package:ieducation/pages/home/controller/home_controller.dart';
import 'package:ieducation/utils/cached_network_image.dart';
import 'package:ieducation/utils/progress_dialog.dart';

class commonCommentWidget extends StatefulWidget {
  const commonCommentWidget({super.key});

  @override
  State<commonCommentWidget> createState() => _commonCommentWidgetState();
}

class _commonCommentWidgetState extends State<commonCommentWidget> {
  final controller = Get.find<BlogController>();
  final homeController = Get.find<HomeController>();

  String? userId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        leftAlignTitle('Comments'),
        const SizedBox(
          height: 10,
        ),
        Obx(() {
          if (controller.commentRefreshing.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!controller.commentRefreshing.value &&
              controller.commentList.isEmpty) {
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
                      'No comments found',
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
              String body =
                  controller.commentList.elementAt(index).body.toString();
              String name =
                  controller.commentList.elementAt(index).user?.name ??
                      'Unknown User';
              String imageUrl = controller.commentList
                      .elementAt(index)
                      .user
                      ?.photo ??
                  'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg';

              String commentUserId =
                  controller.commentList.elementAt(index).user?.id.toString() ??
                      '';
              String id = controller.commentList.elementAt(index).id.toString();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.black12)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: AppCachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.fill,
                                  cachedHeight: 99,
                                  cachedWidth: 99,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3E4E8),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(body),
                                  ],
                                ),
                              ),
                            ),
                            commentUserId ==
                                    homeController.myInfo
                                        .elementAt(0)
                                        .id
                                        .toString()
                                ? Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.deleteComment(
                                                context, id);
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              controller.bodyController.text =
                                                  controller.commentList
                                                      .elementAt(index)
                                                      .body
                                                      .toString();
                                              controller.params.clear();

                                              controller.editCommentId = id;
                                            });
                                          },
                                          child: const Text(
                                            'Edit',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
            itemCount: controller.commentList.length,
            primary: false,
            shrinkWrap: true,
          );
        }),
        Row(
          children: [
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width - 40,
              child: TextFormField(
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                controller: controller.bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    bottom: 10,
                    left: 20,
                  ),
                  isDense: true,
                  hintText: 'Write a comment...',
                  hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.black38),
                  fillColor: CustomColors.bodyBackground,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: CustomColors.inputBorderColor,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.params.clear();
                      String body = controller.bodyController.text;
                      controller.params['body'] = body;
                      if (controller.editCommentId != null) {
                        controller.params['_method'] = 'PUT';
                        progressDialog(context);
                        controller.updateComment(
                            context, controller.editCommentId);
                      } else {
                        controller.params['commentable_type'] =
                            controller.selectedCommentableType.toString();
                        controller.params['commentable_id'] =
                            controller.selectedCommentableId.toString();
                        progressDialog(context);
                        controller.createComment(context);
                      }
                    },
                    child: const Icon(
                      Icons.send,
                      color: CustomColors.btnBackground,
                      size: 25,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: CustomColors.inputBorderColor,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
