import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/pages/course/model/individual_course_model.dart';
import 'package:ieducation/pages/course/view/video_play_page.dart';

class VideoSectionContent extends StatefulWidget {
  const VideoSectionContent({super.key});

  @override
  State<VideoSectionContent> createState() => _VideoSectionContentState();
}

class _VideoSectionContentState extends State<VideoSectionContent> {
  Section? section;
  @override
  void initState() {
    if (Get.arguments != null) {
      section = Get.arguments[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          section!.title.toString(),
        ),
      ),
      body: Column(
        children: [
          !section.isNull
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (!section!.contents!
                            .elementAt(index)
                            .video!
                            .link
                            .isNull) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return VideoPlayPage(
                                  videoLink: section!.contents!
                                      .elementAt(index)
                                      .video!
                                      .link
                                      .toString(),
                                  contentId:
                                      section!.contents!.elementAt(index).id,
                                );
                              },
                            ),
                          );
                        } else {
                          Get.snackbar('Sorry', 'No URL Found for this video');
                        }
                      },
                      child: Card(
                        child: SizedBox(
                          height: 55,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.video_collection,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                SizedBox(
                                  width: 280,
                                  child: Text(section!.contents!
                                      .elementAt(index)
                                      .title
                                      .toString()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: section!.contents!.length,
                  primary: false,
                  shrinkWrap: true,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
