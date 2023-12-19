import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/exam/controller/exam_controller.dart';
import 'package:ieducation/pages/exam/model/mcq_model.dart';

class MCGItem extends StatefulWidget {
  final Mcq McqItem;
  final int index;
  const MCGItem({super.key, required this.McqItem, required this.index});

  @override
  _MCGItemState createState() => _MCGItemState();
}

class _MCGItemState extends State<MCGItem> {
  String? value;
  String? checked;
  ExamController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    String indexString = (widget.index + 1).toString();
    String questionPreText = '$indexString. ';
    double questionWidth = MediaQuery.of(context).size.width - 65;
    String question = widget.McqItem.question.toString();
    String itemA = widget.McqItem.a.toString();
    String itemB = widget.McqItem.b.toString();
    String itemC = widget.McqItem.c.toString();
    String itemD = widget.McqItem.d.toString();
    String itemE = widget.McqItem.e.toString();
    String questionDescription = widget.McqItem.questionDescription.toString();
    String questionPhoto = widget.McqItem.questionPhoto.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Question title
        Row(
          children: [
            Text(
              questionPreText,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            SizedBox(
              width: questionWidth,
              child: HtmlWidget(
               question,
               
              ),
            )
          ],
        ),

        questionDescription != "null"
            ? Padding(
                padding: const EdgeInsets.only(left: 20),
                child: HtmlWidget(
                  questionDescription,
                
                ),
              )
            : const SizedBox(),
        questionPhoto != 'null'
            ? Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: Image.network(
                  questionPhoto,
                  height: 100,
                ),
              )
            : const SizedBox(),

        //Question answers
        Column(
          children: [
            renderChoices('a', itemA, checked == "a"),
            const SizedBox(height: 10),
            renderChoices('b', itemB, checked == "b"),
            const SizedBox(height: 10),
            renderChoices('c', itemC, checked == "c"),
            const SizedBox(height: 10),
            renderChoices('d', itemD, checked == "d"),
            itemE != 'null'
                ? Column(
                    children: [
                      const SizedBox(height: 10),
                      renderChoices('e', itemE, checked == "e"),
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ],
    );
  }

  void SeTAnswer() {
    bool flag = false;
    McqAnswers newObj = McqAnswers();
    newObj.mcqId = widget.McqItem.id;
    newObj.userAnswers = value;
    for (int i = 0; i < controller.mcqAnswers.length; i++) {
      if (controller.mcqAnswers.elementAt(i).mcqId.toString() ==
          widget.McqItem.id.toString()) {
        setState(() {
          flag = true;
          controller.mcqAnswers[i] = newObj;
        });
      }
    }
    if (!flag) {
      setState(() {
        controller.mcqAnswers.add(newObj);
      });
    }
  }

  Widget renderChoices(index, indexValue, isSelected) {
    double responsiveDescription = MediaQuery.of(context).size.width - 115;

    String indexText = '$index.';
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    return GestureDetector(
      onTap: () {
        if (value == null) {
          setState(() {
            checked = index;
            value = indexValue;
          });
          SeTAnswer();
        }
      },
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 33,
          maxHeight: double.infinity,
        ),
        width: responsiveWidth,
        decoration: BoxDecoration(
          color: isSelected ? MCQButtonColors.rightBG : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color:
                isSelected ? MCQButtonColors.selected : MCQButtonColors.initial,
          ),
        ),
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Center(
          child: Row(
            children: [
              Text(
                indexText,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                width: responsiveDescription,
                child: Text(
                  indexValue,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
