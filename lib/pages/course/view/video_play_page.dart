import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common_comment_widget.dart';
import 'package:ieducation/common-widget/show_video.dart';
import 'package:ieducation/pages/blogs/controller/blog_controller.dart';

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
  // late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = YoutubePlayerController(
    //   initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLink ?? '')!,
    //   flags: const YoutubePlayerFlags(
    //     autoPlay: true,
    //     mute: false,
    //     hideThumbnail: true,
    //     enableCaption: false,
    //     forceHD: false,
    //     loop: false,
    //   ),
    // );

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
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      appBar: _buildAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          ShowVideo(
            videoUrl: widget.videoLink ?? '',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: commonCommentWidget(),
          ),
        ],
      ),
    );
  }

  AppBar? _buildAppBar() {
    return AppBar(
      backgroundColor: CustomColors.pageBackground,
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
