import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';

class VideoPlaySectionBlog extends StatefulWidget {
  final String link;
  const VideoPlaySectionBlog({super.key, required this.link});

  @override
  State<VideoPlaySectionBlog> createState() => _VideoPlaySectionBlogState();
}

class _VideoPlaySectionBlogState extends State<VideoPlaySectionBlog> {
  final controller = Get.put(CourseController());
  String videoId = '';
  String title = '';
  bool _isPlayerReady = false;
  late String token;
  String videoThumb = '';
  late YoutubePlayerController tubeController;
  late YoutubeMetaData _videoMetaData;

  @override
  void initState() {
    videoId = YoutubePlayer.convertUrlToId(widget.link).toString();

    if (videoId.isNotEmpty) {
      videoThumb = YoutubePlayer.getThumbnail(
          videoId: videoId, quality: ThumbnailQuality.max);
    }
    tubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
          useHybridComposition: false),
    )..addListener(listener);

    _videoMetaData = const YoutubeMetaData();

    super.initState();
  }

  void listener() {
    if (_isPlayerReady && mounted && !tubeController.value.isFullScreen) {
      setState(() {
        _videoMetaData = tubeController.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    tubeController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    tubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        tubeController.play();
      },
      player: YoutubePlayer(
        controller: tubeController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        onEnded: (metadata) {},
        onReady: () {
          _isPlayerReady = true;
        },
      ),
      onEnterFullScreen: () {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeLeft]);
        tubeController.play();
      },
      builder: (context, player) => Scaffold(
        body: Column(
          children: [
            getVideoSection(videoId, player),
          ],
        ),
      ),
    );
  }

  Widget getVideoSection(videoId, player) {
    return Hero(
      tag: videoId,
      child: player,
    );
  }
}
