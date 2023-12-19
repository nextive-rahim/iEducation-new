import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common_comment_widget.dart';
import 'package:ieducation/pages/blogs/controller/blog_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLink ?? '')!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        hideThumbnail: true,
        enableCaption: false,
        forceHD: false,
        loop: false,
      ),
    );

    final blogController = Get.find<BlogController>();
    blogController.selectedCommentableId = widget.contentId.toString();
    blogController.selectedCommentableType = 'content';
    blogController.getCommentList(
      context,
      blogController.selectedCommentableId,
      blogController.selectedCommentableType,
    );
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onEnded: (data) {
          _controller.seekTo(Duration.zero);
          _controller.pause();
        },
        topActions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const PlaybackSpeedButton(),
                FullScreenButton(),
              ],
            ),
          ),
        ],
        bottomActions: [
          BackwardButton(controller: _controller),
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
          ),
          RemainingDuration(),
          ForwardButton(controller: _controller),
        ],
      ),
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp],
        );
      },
      onEnterFullScreen: () {
        SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft],
        );
      },
      builder: (context, player) {
        return Scaffold(
          backgroundColor: CustomColors.pageBackground,
          appBar: _buildAppBar(),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              player,
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: commonCommentWidget(),
              ),
            ],
          ),
        );
      },
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

class ForwardButton extends StatelessWidget {
  const ForwardButton({
    super.key,
    required YoutubePlayerController controller,
  })  : _controller = controller;

  final YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.forward_10),
      color: Colors.white,
      onPressed: () {
        _controller.seekTo(
          Duration(
            seconds: _controller.value.position.inSeconds + 10,
          ),
        );
      },
    );
  }
}

class BackwardButton extends StatelessWidget {
  const BackwardButton({
    super.key,
    required YoutubePlayerController controller,
  })  : _controller = controller;

  final YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.replay_10),
      color: Colors.white,
      onPressed: () {
        _controller.seekTo(
          Duration(
            seconds: _controller.value.position.inSeconds - 10,
          ),
        );
      },
    );
  }
}
