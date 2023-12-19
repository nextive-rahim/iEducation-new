import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sslcommerz/model/SSLCAdditionalInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ieducation/api-controller/api.dart';
import 'package:ieducation/pages/bottom-navigation/view/bottom_navigation.dart';
import 'package:ieducation/pages/orders/model/orders_model.dart';
import 'package:uuid/uuid.dart';

class SSLConfig {
  static const _ipnUrl = "https://api.ieducationbd.com/api/sslcommerz/ipn";
  static const _multiCardName = "";
  static const _productCategory = "Any";

  static const _storeIdSendBox = "nexti5ee88748d9d97";
  static const _storePwdSendBox = "nexti5ee88748d9d97@ssl";

  static const _storeIdLive = "ieducationbdlive";
  static const _storePwdLive = "648840E2D46CC11988";

  String getTransactionId() {
    var uuid = const Uuid();
    return uuid.v1();
  }

  String getIpnUrl() {
    return _ipnUrl;
  }

  String getMultiCardName() {
    return _multiCardName;
  }

  String getProductCategory() {
    return _productCategory;
  }

  String getStoreId(bool isSandbox) {
    return isSandbox ? _storeIdSendBox : _storeIdLive;
  }

  String getStorePassword(bool isSandbox) {
    return isSandbox ? _storePwdSendBox : _storePwdLive;
  }

  String getSDKType(bool isSandbox) {
    return isSandbox ? SSLCSdkType.TESTBOX : SSLCSdkType.LIVE;
  }

  String getCurrencyType() {
    return SSLCurrencyType.BDT;
  }
}

// TODO: basic testing done -- refine later
Future<dynamic> sslCommerzGeneralCall({
  bool? isSandbox = false,
  required OrderModelData orderDataModel,
}) async {
  SSLConfig sslConfig = SSLConfig();
  Api sslRepository = Api();
  Sslcommerz sslcommerz = Sslcommerz(
    initializer: SSLCommerzInitialization(
      ipn_url: sslConfig.getIpnUrl(),
      currency: sslConfig.getCurrencyType(),
      product_category: sslConfig.getProductCategory(),
      sdkType: sslConfig.getSDKType(isSandbox!),
      store_id: sslConfig.getStoreId(isSandbox),
      store_passwd: sslConfig.getStorePassword(isSandbox),
      total_amount: double.tryParse(orderDataModel.due ?? '0') ?? 0,
      tran_id: sslConfig.getTransactionId(),
    ),
  );
  sslcommerz.addAdditionalInitializer(
    sslcAdditionalInitializer: SSLCAdditionalInitializer(
      valueA: orderDataModel.id.toString(),
    ),
  );
  sslcommerz.addCustomerInfoInitializer(
      customerInfoInitializer: SSLCCustomerInfoInitializer(
    customerName: orderDataModel.name ?? 'Unknown',
    customerEmail: '',
    customerPhone: orderDataModel.phone ?? '',
    customerAddress1: '',
    customerAddress2: '',
    customerCity: '',
    customerPostCode: '',
    customerState: '',
    customerCountry: 'Bangladesh',
  ));
  debugPrint(sslcommerz.initializer.toJson().toString());

  var result = await sslcommerz.payNow();
  if (result is PlatformException || result.status != 'VALID') {
    debugPrint(
        "${"err>> response: ${result.status!}"}, code: ${result.amount}");
    Get.snackbar(
      'Failed!',
      'Something went wrong!',
    );
  } else {
    Get.offAll(() => const BottomNavigation());
    SSLCTransactionInfoModel model = result;
    debugPrint("RESULT >> $model");
    debugPrint(model.toJson().toString());
    Get.snackbar(
      'Success!',
      'Payment is successful!',
    );

    Map<String, dynamic> data = {
      "source": 'app',
      "val_id": model.valId,
    };

    final confirmationResponse = await sslRepository.confirmPayment(data);

    return confirmationResponse;
  }
}
