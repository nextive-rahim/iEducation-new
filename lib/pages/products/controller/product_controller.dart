import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/api-controller/api.dart';
import 'package:ieducation/model/coupon_model.dart';
import 'package:ieducation/pages/address/model/address_model.dart';
import 'package:ieducation/pages/blogs/model/blog_model.dart';
import 'package:ieducation/pages/products/model/product_detail_model.dart';
import 'package:ieducation/pages/products/model/products_model.dart';
import 'package:ieducation/utils/handleErrorMessage.dart';
import '../model/delivery_option_model.dart';

class ProductController extends GetxController {
  var productIsRefreshing = false.obs;
  var featureRefreshing = false.obs;
  var addressRefreshing = false.obs;
  Map<String, dynamic> params = <String, dynamic>{};
  List<ProductModelData> productList = [];
  RxList<AddressModelData> addressList = <AddressModelData>[].obs;
  AddressModelData? selectedAddress;
  String? discountedPriceMain;
  CouponModel? appliedCoupon;
  RxList<ProductModelData> featuredProductList = <ProductModelData>[].obs;
  RxList<ProductDetailData> productDetailData = <ProductDetailData>[].obs;
  RxList<ProductDetailData> productDetailDataMain = <ProductDetailData>[].obs;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  TextEditingController paidToInput = TextEditingController();
  TextEditingController paidFromInput = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController transactionIdInput = TextEditingController();
  TextEditingController paymentMethodInput = TextEditingController();
  DeliveryOptionData? selectedDeliveryOption;

  BlogDataList? selectedBlog;
@override
  void onInit() {
    getProductList();
    // TODO: implement onInit
    super.onInit();
  }
  void getProductList() async {
    var result;
    productIsRefreshing.value = true;
    result = await api.getProductList('');

    if (result['statusCode'] == 200) {
      productList = result['data'].data;
      productIsRefreshing.value = false;
    } else {
      Get.snackbar(
        'Failed',
        'Fetching error book',
      );
    }
  }

  void getAddressList(context) async {
    var result;
    addressRefreshing.value = true;
    result = await api.getAddressList();
    addressRefreshing.value = false;
    if (result['statusCode'] == 200) {
      addressList.clear();
      addressList.addAll(result['data'].data.toList());
      addressList.refresh();
    } else {
      handleErrorMessage(context, result);
    }
  }

  void deleteAddress(context, id) async {
    var result;
    result = await api.deleteAddressApi(id);
    Get.back();
    if (result['statusCode'] == 200) {
      Get.snackbar('Success', 'Address deleted successfully',
          snackPosition: SnackPosition.BOTTOM);
      getAddressList(context);
    } else {
      handleErrorMessage(context, result);
    }
  }

  Future<List<DeliveryOptionData>?> getDeliveryOptionList() async {
    var result;
    result = await api.getDeliveryOptionListApi();
    if (result['statusCode'] == 200) {
      return result['data'];
    }
    return null;
  }

  void validateCoupon(context) async {
    var result;
    result = await api.validateCouponApi(params);
    if (result['statusCode'] == 200) {
      String discountString = result['data'].discount.toString();
      if (discountString != 'null') {
        appliedCoupon = result['data'];
        double currentPrice = double.parse(discountedPriceMain.toString()) -
            double.parse(discountString);
        productDetailData[0].discountedPrice = currentPrice.toString();
        productDetailData.refresh();
        Get.snackbar('Success', 'Coupon applied successfully');
      } else {
        Get.snackbar('Error', result['data'].message);
      }
    } else {
      handleErrorMessage(context, result);
    }
  }

  void createAddress(context) async {
    var result = await api.createAddressApi(params);
    Get.back();
    if (result['statusCode'] == 200) {
      Get.back();
      name.clear();
      phone.clear();
      address.clear();
      getAddressList(context);
      Get.snackbar('Success', 'Address created successfully',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      handleErrorMessage(context, result);
    }
  }

  void getFeaturedProductList(context) async {
    var result;
    featureRefreshing.value = true;
    result = await api.getProductList('?filter=featured');
    featureRefreshing.value = false;
    if (result['statusCode'] == 200) {
      featuredProductList.clear();
      featuredProductList.addAll(result['data'].data.toList());
      featuredProductList.refresh();
    } else {
      handleErrorMessage(context, result);
    }
  }

  void getProductDetail(context, slug) async {
    var result;
    productIsRefreshing.value = true;
    result = await api.getProductDetail(slug);
    productIsRefreshing.value = false;
    if (result['statusCode'] == 200) {
      productDetailData.clear();
      productDetailData.add(result['data'].data);
      productDetailData.refresh();
      if (productDetailData.isNotEmpty) {
        discountedPriceMain = productDetailData.elementAt(0).discountedPrice;
      }
    } else {
      handleErrorMessage(context, result);
    }
  }
}
