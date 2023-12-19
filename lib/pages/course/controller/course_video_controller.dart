import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';

import '../../../utils/handler.dart';
import '../../../utils/page_state.dart';

class CourseVideoViewController extends GetxController {
  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);
  get pageState => _pageStateController.value;

  late String youTubeVideoLink;

  void getCourseVideo(url, {bool isLive = true}) {
    if (url.toString() != 'null') {
      youTubeVideoLink = url;
      _getYouTubeVideo();
    }
  }

  _getYouTubeVideo() {
    _pageStateController(PageState.loading);
    try {
      _initializeVideoPlayerController();
      _pageStateController(PageState.success);
    } catch (e, stackTrace) {
      _pageStateController(PageState.error);
      errorHandler(e, stackTrace);
    }
  }

  /// Video player
  late final PodPlayerController podPlayerController;

  void _initializeVideoPlayerController() {
    podPlayerController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        youTubeVideoLink,
      ),
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: false,
        isLooping: false,
        videoQualityPriority: [1080, 720, 360],
        // wakelockEnabled: true,
      ),
    )..initialise();
  }
}
