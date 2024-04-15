import 'package:get/get.dart';
import 'package:ieducation/api-controller/api.dart';
import 'package:ieducation/pages/exam/model/free_exam_model.dart';
import 'package:ieducation/pages/exam/model/individual_exam_model.dart';
import 'package:ieducation/pages/exam/model/mcq_model.dart';
import 'package:ieducation/pages/leaderboard/model/ranking_model.dart';
import 'package:ieducation/routes.dart';
import 'package:ieducation/utils/handleErrorMessage.dart';
import 'package:intl/intl.dart';

class McqAnswers {
  McqAnswers({this.userAnswers, this.mcqId});
  String? userAnswers;
  int? mcqId;
}

class ExamController extends GetxController {
  var examRefreshing = false.obs;
  var mcqListRefreshing = false.obs;
  var isRefreshing = false.obs;
  var selectedExamIndex = 0;

  RxList<MCQModelData> mcqExamPageDetail = <MCQModelData>[].obs;

  RxList<FreeExamData> freeExamList = <FreeExamData>[].obs;

  RxList<McqAnswers> mcqAnswers = <McqAnswers>[].obs;

  RxList<Map<String, dynamic>> answers = <Map<String, dynamic>>[].obs;

  Map<String, dynamic> params = <String, dynamic>{};

  List<RankingListData> rankingListMain = [];

  var rankingRefreshing = false.obs;

  IndividualExamData? selectedExamData;

  String examPageComeFrom = '';

  void getFreeExam(context) async {
    examRefreshing.value = true;
    var result = await api.getFreeExamApi();
    examRefreshing.value = false;
    if (result['statusCode'] == 200) {
      freeExamList.clear();
      freeExamList.addAll(result['data'].data.toList());
      freeExamList.refresh();
    } else {
      handleErrorMessage(context, result);
    }
  }

  void getIndividualExam(context, id) async {
    examRefreshing.value = true;
    var result = await api.getIndividualExamApi(id);
    examRefreshing.value = false;
    if (result['statusCode'] == 200) {
      selectedExamData = result['data'].data;
      Get.toNamed(RoutesPath.examDetailPage);
    } else {
      handleErrorMessage(context, result);
    }
  }

  void getMCQExamDetail(context, id) async {
    mcqListRefreshing.value = true;
    var result = await api.getMCQExamDetailApi(id);
    mcqListRefreshing.value = false;
    if (result['statusCode'] == 200) {
      mcqExamPageDetail.clear();
      mcqExamPageDetail.clear();
      mcqExamPageDetail.refresh();
      mcqExamPageDetail.add(result['data']);
      mcqExamPageDetail.refresh();
    } else {
      handleErrorMessage(context, result);
    }
  }

  /* Exam Start */

  void startExam(context, String id) async {
    var result;
    var res;
    mcqListRefreshing.value = true;
    result = await api.getMCQExamDetailApi(id);
    mcqListRefreshing.value = false;
    Get.back();
    mcqAnswers.clear();
    answers.clear();
    params.clear();
    if (result['statusCode'] == 200) {
      params['exam_id'] = id;
      params['submitted'] = 0;
      res = await api.submitAnswer(params);
      if (res['statusCode'] == 200) {
        mcqExamPageDetail.clear();
        mcqExamPageDetail.clear();
        mcqExamPageDetail.add(result['data']);
        mcqExamPageDetail.refresh();
        Get.toNamed(RoutesPath.examGivenPage);
      }
    } else {
      handleErrorMessage(context, result);
    }
  }

  void submitExam(context, String id) async {
    for (int i = 0; i < mcqAnswers.length; i++) {
      answers.add({
        "user_answer": mcqAnswers.elementAt(i).userAnswers,
        "mcq_id": mcqAnswers.elementAt(i).mcqId
      });
    }
    var result;
    isRefreshing.value = true;
    result = await api.submitAnswerFinal(id, 1, answers);
    isRefreshing.value = false;
    Get.back();
    if (result['statusCode'] == 200) {
      mcqAnswers.clear();
      answers.clear();
      mcqExamPageDetail.clear();
      if (examPageComeFrom == "free_exam") {
        getFreeExam(context);
      }
      Get.back();
      Get.back();
      Get.snackbar('Success', 'Answers submitted successfully!',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      handleErrorMessage(context, result);
    }
  }

  void getRankingList(context, id) async {
    var result;
    rankingRefreshing.value = true;
    result = await api.getRankingListApi(id);
    rankingRefreshing.value = false;
    if (result['statusCode'] == 200) {
      rankingListMain = result['data'].data;
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
    } else if (m == '2') {
      return 'Feb';
    } else if (m == '3') {
      return 'Mar';
    } else if (m == '4') {
      return 'Apr';
    } else if (m == '5') {
      return 'May';
    } else if (m == '6') {
      return 'Jun';
    } else if (m == '7') {
      return 'Jul';
    } else if (m == '8') {
      return 'Aug';
    } else if (m == '9') {
      return 'Sept';
    } else if (m == '10') {
      return 'Oct';
    } else if (m == '11') {
      return 'Nov';
    } else {
      return 'Dec';
    }
  }
}
