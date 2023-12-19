import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import '../../../utils/page_state.dart';
import '../pages/course/controller/video_controller.dart';

class ShowVideo extends StatelessWidget {
  final controller = Get.put(VideoController());
  final String videoUrl;
  ShowVideo({super.key, required this.videoUrl}) {
    print(videoUrl);
    controller.getCourseVideo(videoUrl, isLive: false);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Obx(
            () {
          if (controller.pageState == PageState.loading) {
            return const CircularProgressIndicator();
          }
          if (orientation == Orientation.landscape) {
            return _buildVideoPlayer(context);
          } else {
            return _buildVideoPlayer(context);
          }
        },
      );
    });
  }

  Widget _buildVideoPlayer(BuildContext context) {
    return PodVideoPlayer(
      controller: controller.podPlayerController,
    );
  }
}
