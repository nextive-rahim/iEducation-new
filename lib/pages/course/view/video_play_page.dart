import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common_comment_widget.dart';
import 'package:ieducation/pages/blogs/controller/blog_controller.dart';
import 'package:pod_player/pod_player.dart';

class VideoPlayPage extends StatefulWidget {
  const VideoPlayPage({
    super.key,
    this.videoLink,
    this.contentId,
  });
  final String? videoLink;
  final int? contentId;

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  late final PodPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        widget.videoLink ?? '',
      ),
    )..initialise();

    final blogController = Get.find<BlogController>();
    blogController.selectedCommentableId = widget.contentId.toString();
    blogController.selectedCommentableType = 'content';
    blogController.getCommentList(
      blogController.selectedCommentableId,
      blogController.selectedCommentableType,
    );
  }

  @override
  void deactivate() {
    // _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PodVideoPlayer(controller: controller),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: commonCommentWidget(),
            ),
          ],
        ),
      ),
    );
  }

  AppBar? _buildAppBar() {
    return AppBar(
      backgroundColor: CustomColors.appBarColor,
      iconTheme: const IconThemeData(
        color: Colors.black,
        size: 20,
      ),
      elevation: 0,
      title: const Text(
        'Video Lecture',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
