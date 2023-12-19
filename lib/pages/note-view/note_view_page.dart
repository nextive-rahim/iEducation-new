import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:url_launcher/url_launcher.dart';

class NoteViewPage extends StatefulWidget {
  const NoteViewPage({super.key});

  @override
  State<NoteViewPage> createState() => _NoteViewPageState();
}

class _NoteViewPageState extends State<NoteViewPage> {
  String title = '';
  String body = '';

  @override
  void initState() {
    // TODO: implement initState
    title = Get.arguments[0];
    body = Get.arguments[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            commonHeader(title, context),
            const SizedBox(
              height: 25,
            ),
            getDescription(),
          ],
        ),
      ),
    );
  }

  Widget getDescription() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveHeight = MediaQuery.of(context).size.height - 160;
    return SizedBox(
      height: responsiveHeight,
      width: responsiveWidth,
      child: SingleChildScrollView(
        child: Column(
          children: [
            HtmlWidget(
         body,
             
            ),
          ],
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
