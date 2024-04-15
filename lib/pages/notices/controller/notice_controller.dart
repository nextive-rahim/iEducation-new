import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/api-controller/api.dart';
import 'package:ieducation/pages/blogs/model/blog_model.dart';
import 'package:ieducation/pages/notices/model/notice_model.dart';
import 'package:ieducation/utils/handleErrorMessage.dart';
import 'package:intl/intl.dart';

class NoticeController extends GetxController {
  var noticeIsRefreshing = false.obs;
  var commentRefreshing = false.obs;
  RxList<NoticeModelData> noticeList = <NoticeModelData>[].obs;

  int selectedNoticeIndex = 0;

  TextEditingController bodyController = TextEditingController();

  BlogDataList? selectedBlog;

  void getNoticeList(context) async {
    var result;
    noticeIsRefreshing.value = true;
    result = await api.getNoticeListApi();
    noticeIsRefreshing.value = false;
    if (result['statusCode'] == 200) {
      noticeList.clear();
      noticeList.addAll(result['data'].data.toList());
      noticeList.refresh();
    } else {
      handleErrorMessage(context, result);
    }
  }

  String dates(String s) {
    if (s == 'null') {
      return 'N/A';
    }
    DateTime end = DateTime.parse(s.substring(0, s.length - 1))
        .add(const Duration(hours: 6));
    String Final = '${end.day} ${month(end.month.toString())} ${end.year}';
    return Final;
  }

  String getTime(String s) {
    if (s == 'null') {
      return 'N/A';
    }
    DateTime end = DateTime.parse(s.substring(0, s.length - 1))
        .add(const Duration(hours: 6));
    DateTime tempDate = DateFormat("hh:mm").parse("${end.hour}:${end.minute}");
    var dateFormat = DateFormat("h:mm a"); // you can change the format here
    String Final = dateFormat.format(tempDate).toString();
    return Final;
  }

  String month(String m) {
    if (m == '1') {
      return 'Jan';
    } else if (m == '2')
      return 'Feb';
    else if (m == '3')
      return 'Mar';
    else if (m == '4')
      return 'Apr';
    else if (m == '5')
      return 'May';
    else if (m == '6')
      return 'Jun';
    else if (m == '7')
      return 'Jul';
    else if (m == '8')
      return 'Aug';
    else if (m == '9')
      return 'Sept';
    else if (m == '10')
      return 'Oct';
    else if (m == '11')
      return 'Nov';
    else
      return 'Dec';
  }
}
