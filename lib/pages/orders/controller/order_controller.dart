import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/api-controller/api.dart';
import 'package:ieducation/model/page_model.dart';
import 'package:ieducation/pages/bottom-navigation/view/bottom_navigation.dart';
import 'package:ieducation/pages/orders/model/order_list_model.dart';
import 'package:ieducation/pages/orders/model/orders_model.dart';
import 'package:ieducation/pages/orders/widgets/ssl_commerz_config.dart';
import 'package:ieducation/routes.dart';
import 'package:ieducation/utils/handleErrorMessage.dart';
import 'package:intl/intl.dart';

class OrderController extends GetxController {
  var orderIsRefreshing = false.obs;
  var paymentIsRefreshing = false.obs;

  Map<String, dynamic> params = <String, dynamic>{};
  RxList<OrderListData> orderList = <OrderListData>[].obs;
  RxList<OrderModelData> selectedOrderDetail = <OrderModelData>[].obs;
  late OrderModelData orderModelData;
  RxList<PageModelData> pageData = <PageModelData>[].obs;

  TextEditingController paidToInput = TextEditingController();
  TextEditingController paidFromInput = TextEditingController();
  TextEditingController transactionIdInput = TextEditingController();
  TextEditingController paymentMethodInput = TextEditingController();
  var paymentInfo = ''.obs;

  void getOrderList(context) async {
    var result;
    orderIsRefreshing.value = true;
    result = await api.getOrderListApi('');
    orderIsRefreshing.value = false;
    if (result['statusCode'] == 200) {
      orderList.clear();
      orderList.addAll(result['data'].data.toList());
      orderList.refresh();
    } else {
      handleErrorMessage(context, result);
    }
  }

  void getSingleOrder(id) async {
    var result;
    orderIsRefreshing.value = true;
    result = await api.getSingleOrderApi(id);
    orderIsRefreshing.value = false;
    if (result['statusCode'] == 200) {
      selectedOrderDetail.clear();
      selectedOrderDetail.add(result['data'].data);
      selectedOrderDetail.refresh();
      Get.toNamed(RoutesPath.checkOutPage);
    }
  }

  void getPageData() async {
    var result;
    result = await api.getPageDataApi();
    if (result['statusCode'] == 200) {
      pageData.clear();
      pageData.addAll(result['data'].data.toList());
      pageData.refresh();
    }
  }

  void createOrder(context) async {
    var result;
    orderIsRefreshing.value = true;
    result = await api.createOrder(params);
    orderIsRefreshing.value = false;
    Get.back();
    if (result['statusCode'] == 200) {
      orderModelData = result['data'].data;
      selectedOrderDetail.clear();
      selectedOrderDetail.add(result['data'].data);
      orderModelData = result['data'].data;
      selectedOrderDetail.refresh();
      getSingleOrder(selectedOrderDetail.elementAt(0).id.toString());
      Get.snackbar('Success', 'order created successfully');
    } else {
      handleErrorMessage(context, result);
    }
  }

  Future<void> sslCommerzCheckout() async {
    paymentIsRefreshing.value = true;
    try {
      final result =
          await sslCommerzGeneralCall(orderDataModel: orderModelData);
      if (result != null && result['status'] == 'success') {
        Get.offAll(
          () => const BottomNavigation(),
        );
        Get.snackbar(
          'Success!',
          'Thank you for purchasing the course!',
        );
      }

      paymentIsRefreshing.value = false;
    } catch (e, stackTrace) {
      print(e.toString());
      print(stackTrace.toString());
      paymentIsRefreshing.value = false;

      Get.snackbar(
        'Failed',
        'Purchase failed!',
      );
      return;
    }
  }

  void createFreeOrder(context) async {
    var result;
    orderIsRefreshing.value = true;
    result = await api.createFreeOrder(params);
    orderIsRefreshing.value = false;
    Get.back();
    if (result['statusCode'] == 200) {
      Get.offAll(() => const BottomNavigation());
      Get.snackbar('Success', 'order created successfully');
    } else {
      print(result.toString());
      /*  handleErrorMessage(context, result);*/
    }
  }

  String dates(String s) {
    if (s == 'null') {
      return 'N/A';
    }
    DateTime end = DateTime.parse(s.substring(0, s.length - 1))
        .add(const Duration(hours: 6));
    final date2 = DateTime.now();
    final difference = end.difference(date2).inSeconds;
    DateTime tempDate = DateFormat("hh:mm").parse("${end.hour}:${end.minute}");
    var dateFormat = DateFormat("h:mm a"); // you can change the format here
    String Final = '${end.day} ${month(end.month.toString())} ${end.year}';
    return Final;
  }

  String getTime(String s) {
    if (s == 'null') {
      return 'N/A';
    }
    DateTime end = DateTime.parse(s.substring(0, s.length - 1))
        .add(const Duration(hours: 6));
    final date2 = DateTime.now();
    final difference = end.difference(date2).inSeconds;
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
