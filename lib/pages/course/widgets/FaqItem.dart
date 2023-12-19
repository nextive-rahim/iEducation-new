import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:ieducation/pages/course/model/individual_course_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../colors.dart';

class FaqItem extends StatefulWidget {
  final Faq faq;
  const FaqItem({super.key, required this.faq});

  @override
  State<FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  bool showContent = false;
  String arrrow = 'assets/images/arrow_up.png';
  @override
  Widget build(BuildContext context) {
    double deductWidth = 40;
    double deductDescriptionWidth = 160;
    double responsiveWidth = MediaQuery.of(context).size.width - deductWidth;
    double descriptionWidth =
        MediaQuery.of(context).size.width - deductDescriptionWidth;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showContent = !showContent;
              });
            },
            child: Container(
              constraints: const BoxConstraints(minHeight: 48),
              width: responsiveWidth,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                Border.all(color: CustomColors.itemBorderColor, width: 0.5),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: descriptionWidth,
                        child: Text(
                          widget.faq.question.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Transform.scale(
                    scaleY: showContent ? 1 : -1,
                    child: Image.asset(
                      arrrow,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          showContent == true
              ? Container(
            width: responsiveWidth,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: CustomColors.itemBorderColor, width: 0.5),
              color: Colors.white,
            ),
            child: HtmlWidget(
          widget.faq.answer.toString(),
             
            ),
          )
              : const SizedBox()
        ],
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
