import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetX;
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ieducation/app.dart';
import 'package:ieducation/authentication/authentication_controller.dart';
import 'package:ieducation/authentication/authentication_state.dart';
import 'package:ieducation/model/coupon_model.dart';
import 'package:ieducation/model/page_model.dart';
import 'package:ieducation/pages/about-us/model/about_us_model.dart';
import 'package:ieducation/pages/address/model/address_model.dart';
import 'package:ieducation/pages/auth/model/user_model.dart';
import 'package:ieducation/pages/blogs/model/blog_category_model.dart';
import 'package:ieducation/pages/blogs/model/blog_detail_model.dart';
import 'package:ieducation/pages/blogs/model/blog_model.dart';
import 'package:ieducation/pages/blogs/model/comment_model.dart';
import 'package:ieducation/pages/course/model/category_children_model.dart';
import 'package:ieducation/pages/course/model/course_category_model.dart';
import 'package:ieducation/pages/course/model/course_children_model.dart';
import 'package:ieducation/pages/course/model/course_model.dart';
import 'package:ieducation/pages/course/model/individual_course_model.dart';
import 'package:ieducation/pages/exam/model/free_exam_model.dart';
import 'package:ieducation/pages/exam/model/individual_exam_model.dart';
import 'package:ieducation/pages/exam/model/mcq_model.dart';
import 'package:ieducation/pages/leaderboard/model/ranking_model.dart';
import 'package:ieducation/pages/notices/model/notice_model.dart';
import 'package:ieducation/pages/orders/model/order_list_model.dart';
import 'package:ieducation/pages/orders/model/orders_model.dart';
import 'package:ieducation/pages/package/model/package_model.dart';
import 'package:ieducation/pages/package/model/single_package_model.dart';
import 'package:ieducation/pages/products/model/product_detail_model.dart';
import 'package:ieducation/pages/products/model/products_model.dart';
import 'package:ieducation/pages/settings/models/setting_model.dart';
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';

import '../pages/products/model/delivery_option_model.dart';

Api api = Api();
BaseOptions options = BaseOptions(
  baseUrl: AppConstants.API_BASE_URL,
  connectTimeout:const Duration(seconds: 30) ,
  receiveTimeout: const Duration(seconds: 30) ,
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
);

class Api {
  AuthenticationController authenticationController = GetX.Get.find();
  var logger = Logger();
  Api() {
    if (authenticationController.state is Authenticated) {
      String token =
          'Bearer ${(authenticationController.state as Authenticated).user.token!}';
      options.headers[HttpHeaders.authorizationHeader] = token;
      debugPrint('Token: $token');
    } else {
      debugPrint('Api(): UnAuthenticated- No token found');
    }
  }
  Dio getDio({bool isFormData = false}) {
    if (authenticationController.state is Authenticated) {
      print((authenticationController.state as Authenticated));
      String token =
          'Bearer ${(authenticationController.state as Authenticated).user.token!}';
      debugPrint('Token: $token');
      options.headers[HttpHeaders.authorizationHeader] = token;
      options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      if (isFormData) {
        options.headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';
      }
    } else {
      debugPrint('Api(): - No token found');
    }

    return Dio(options);
  }

  dynamic resultData = {
    "statusCode": -1,
    "message": "Unknown Error",
    "singleMessage": "",
    "data": null
  };

  /*
 ********************************************************************
 *              Authentication API                                  *
 ********************************************************************
*/

  Future<dynamic> loginApi(Map<String, dynamic> map) async {
    Response result;
    try {
      debugPrint(json.encode(map).toString());
      Dio dio = getDio();
      result = await dio.post('/api/login', data: map);
      var loginModel = UserModel.fromJson(result.data);
      if (loginModel.token != null) {
        GetStorage box = GetStorage("Auth");
        box.write('user', loginModel.toJson());
        authenticationController.state = Authenticated(user: loginModel);
        resultData['statusCode'] = 200;
        resultData['data'] = loginModel;
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> userApiInfo() async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/user');
      logger.i('/api/user');

      if (result.statusCode == 200) {
        var loginModel = UserModel.fromJson({
          "token": (authenticationController.state as Authenticated).user.token,
          "user": result.data
        });
        GetStorage box = GetStorage("Auth");
        box.write('user', loginModel.toJson());
        authenticationController.state = Authenticated(user: loginModel);
        resultData['statusCode'] = 200;
        resultData['data'] = loginModel;
        logger.i(loginModel.toJson());
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> signUpApi(Map<String, dynamic> map) async {
    Response result;
    try {
      debugPrint(json.encode(map).toString());
      Dio dio = getDio();
      result = await dio.post('/api/register', data: map);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = result.data;
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> updateUserApi(
      Map<String, dynamic> map, String? imgPath, String id) async {
    FormData formData = FormData.fromMap(map);
    if (imgPath != null) {
      String fileName = imgPath.split('/').last;
      String fullMime = lookupMimeType(fileName)!;
      String mime = fullMime.split('/')[0];
      String type = fullMime.split('/')[1];
      debugPrint('fileName: $fileName');
      debugPrint('mime: $mime');
      debugPrint('type: $type');
      FormData formFile = FormData.fromMap({
        "photo": await MultipartFile.fromFile(
          imgPath,
          filename: fileName,
          contentType: MediaType(mime, type),
        ),
      });
      formData.files.addAll(formFile.files);
    }
    Response result;
    try {
      Dio dio = getDio();
      debugPrint('URL : /api/users/$id');
      debugPrint(formData.toString());
      result = await dio.post('/api/users/$id', data: formData);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = result.data;
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> contactUsApi(Map<String, dynamic> map) async {
    Response result;
    try {
      debugPrint(json.encode(map).toString());
      Dio dio = getDio();
      result = await dio.post('/api/contact-us', data: map);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = result.data;
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> resetPasswordApi(Map<String, dynamic> map) async {
    Response result;
    try {
      debugPrint(json.encode(map).toString());
      Dio dio = getDio();
      result = await dio.post('/api/reset-password', data: map);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = result.data;
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getOTPApi(Map<String, dynamic> map) async {
    Response result;
    try {
      debugPrint(json.encode(map).toString());
      Dio dio = getDio();
      result = await dio.post('/api/get-otp', data: map);
      if (result.statusCode == 201) {
        resultData['statusCode'] = 200;
        resultData['data'] = result.data;
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  /*
 ********************************************************************
 *              Course  Category                                    *
 ********************************************************************
*/

  Future<CategoryChildrenModel?> getCourseCategoryApi(String url) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/course-category/$url');
      logger.d('/api/course-category/$url');

      if (result.statusCode == 200) {
        /* logger.i(result.data);*/
        return CategoryChildrenModel.fromJson(result.data);
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getCourseCategoryOnlyHomeApi() async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/course-category/');
      logger.d('/api/course-category/');
      var courseCategoryModel = CourseCategoryModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = courseCategoryModel;
        /* logger.i(courseCategoryModel.toJson());*/
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  /*
 ********************************************************************
 *              Course  By Category                                    *
 ********************************************************************
*/

  Future<CourseChildrenModel?> getCourseByCategoryApi(String url) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/course-by-category/$url');
      logger.i('api/course-by-category/$url');

      if (result.statusCode == 200) {
        /* logger.i(result.data);*/
        return CourseChildrenModel.fromJson(result.data);
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  /*
 ********************************************************************
 *                      Get Free Exam                               *
 ********************************************************************
*/

  Future<dynamic> getFreeExamApi() async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/model-tests/');
      logger.i('/api/model-tests/');
      var freeExamModel = FreeExamModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = freeExamModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  /*
 ********************************************************************
 *              Course                                              *
 ********************************************************************
*/
  Future<dynamic> getCourseApi(String filter) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/course?filter=$filter&per_page=1000&page=1');
      logger.i('/api/course?filter=$filter');
      var courseModel = CourseModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = courseModel;
       // logger.d(courseModel.toJson());
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getMyCoursesApi() async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio
          .get('/api/my-courses/?userFilter=all&per_page=20&page=undefined');
      logger.i('/api/my-courses/?userFilter=all&per_page=20&page=undefined');
      var courseModel = CourseModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = courseModel;
        logger.d(courseModel.toJson());
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getIndividualCourseApi(String slug) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/course/$slug');
      var individualCourseModel = IndividualCourseModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = individualCourseModel;
        logger.d(individualCourseModel.toJson());
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

/*
 ********************************************************************
 *            Individual Exam                                       *
 ********************************************************************
*/

  Future<dynamic> getIndividualExamApi(String id) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/contents/$id');
      var individualExamModel = IndividualExamModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = individualExamModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

/*
 ********************************************************************
 *                                  Mcq                             *
 ********************************************************************
*/

  Future<dynamic> getMCQExamDetailApi(String id) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/exams/$id');
      logger.i('/api/exam/$id');
      var mcqModel = McqModel.fromJson(result.data).data;
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = mcqModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> submitAnswer(Map<String, dynamic> map) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.post('/api/results', data: map);
      logger.i(map.toString());
      logger.i('/api/results');
      var mcqModel = McqModel.fromJson(result.data).data;
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = mcqModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> submitAnswerFinal(id, submitted, answers) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.post('/api/results', data: {
        "exam_id": id,
        "submitted": 1,
        "answers": answers,
      });
      logger.i('/api/results');
      var mcqModel = McqModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = mcqModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getRankingListApi(id) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/ranking/$id/?per_page=2000&page=1');
      logger.i('/api/ranking/$id/');
      var rankingModel = RankingModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = rankingModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getBlogListApi(url) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/posts/$url');
      logger.i('/api/posts/$url');
      var blogModel = BlogModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = blogModel;
        /*      logger.i(result.data);*/
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getNoticeListApi() async {
    Response result;
    try {
      Dio dio = getDio();
      result =
          await dio.get('/api/notices/?userFilter=all&per_page=1000&page=1');
      logger.i('/api/notices/?userFilter=all&per_page=1000&page=1');
      var noticeModel = NoticeModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = noticeModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> aboutUsDataApi() async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/page/about');
      logger.i('/api/page/about');
      var aboutUsModel = AboutUsModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = aboutUsModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getPackageListApi() async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/package?filter=featured');
      logger.i('/api/package?filter=featured');
      var packageModel = PackageModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = packageModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getSinglePackageApi(url) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/package/$url');
      var singlePackageModel = SinglePackageModel.fromJson(result.data);
      logger.i('/api/package/$url');
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = singlePackageModel;
        logger.i(singlePackageModel);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getProductList(url) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/product$url');
      logger.i('/api/product/');
      var productModel = ProductModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = productModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getAddressList() async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/address');
      logger.i('/api/address');
      var addressModel = AddressModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = addressModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> deleteAddressApi(id) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.delete('/api/address/$id');
      logger.i('/api/address');
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getProductDetail(slug) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/product/$slug');
      logger.i('/api/product/$slug');
      var productDetailModel = ProductDetailModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = productDetailModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getCommentList(id, type) async {
    Response result;
    try {
      Dio dio = getDio();
      logger.i('/api/comments/?commentable_type=$type&commentable_id=$id');
      result = await dio
          .get('/api/comments/?commentable_type=$type&commentable_id=$id');

      var commentModel = CommentModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = commentModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getDeliveryOptionListApi() async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/delivery-option/');
      logger.i('/api/delivery-option/');
      var deliveryOptionModel = DeliveryOptionModel.fromJson(result.data).data;
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = deliveryOptionModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getSingleBlog(slug) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/posts/$slug');
      var blogDetailModel = BlogDetailModel.fromJson(result.data);
      logger.i('/api/posts/$slug');
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = blogDetailModel;
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getBlogByCategoryApi(slug) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/post-by-category/$slug');
      logger.i('/api/post-by-category/$slug');
      var blogDataList = BlogModel.fromJson(result.data).data;
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = blogDataList;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getBlogCategoryListApi() async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/post-category');
      logger.i('/api/post-category');
      var blogCategoryModel = BlogCategoryModel.fromJson(result.data).data;
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = blogCategoryModel;
/*        logger.i(result.data);*/
        return resultData;
      }
    } on DioError {
      debugPrint('Error occur');
    }
    return resultData;
  }

  Future<dynamic> createAddressApi(Map<String, dynamic> map) async {
    Response result;
    try {
      debugPrint(json.encode(map).toString());
      Dio dio = getDio();
      result = await dio.post('/api/address', data: map);
      var addressModelData = AddressModelData.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = addressModelData;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> createCommentApi(Map<String, dynamic> map) async {
    Response result;
    try {
      debugPrint(json.encode(map).toString());
      Dio dio = getDio();
      result = await dio.post('/api/comments/', data: map);
      if (result.statusCode == 201) {
        resultData['statusCode'] = 200;
        resultData['data'] = result.data;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      print(e.response.toString());
/*      resultData = _decodeErrorResponse(e);*/
    }
    return resultData;
  }

  Future<dynamic> deleteCommentApi(id) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.delete('/api/comments/$id');
      if (result.statusCode == 204) {
        resultData['statusCode'] = 200;
        resultData['data'] = result.data;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> updateCommentApi(id, Map<String, dynamic> map) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.post('/api/comments/$id', data: map);
      if (result.statusCode == 204) {
        resultData['statusCode'] = 200;
        resultData['data'] = result.data;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

/*
 ********************************************************************
 *                         Coupon Model                             *
 ********************************************************************
*/

  Future<dynamic> getOrderListApi(url) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/orders/$url');
      logger.i('/api/orders/');
      var orderModel = OrderListModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = orderModel;
        /*       logger.i(result.data);*/
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getSingleOrderApi(url) async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/orders/$url');
      logger.i('/api/orders/');
      var orderModel = OrderModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = orderModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> getPageDataApi() async {
    Response result;
    try {
      Dio dio = getDio();
      result = await dio.get('/api/page');
      logger.i('/api/page');
      var pagesModel = PagesModel.fromJson(result.data);
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = pagesModel;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> createOrder(Map<String, dynamic> map) async {
    Response result;
    try {
      Dio dio = getDio();
      // debugPrint(json.encode(map).toString());
      logger.d(json.encode(map).toString());
      result = await dio.post('/api/orders/', data: map);
      logger.i('/api/orders/');
      logger.i(result.data.toString());
      var orderModel = OrderModel.fromJson(result.data);
      if (result.statusCode == 201) {
        resultData['statusCode'] = 200;
        resultData['data'] = orderModel;
        logger.i(result.data.toString());
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> createFreeOrder(Map<String, dynamic> map) async {
    Response result;
    try {
      Dio dio = getDio();
      debugPrint(json.encode(map).toString());
      result = await dio.post('/api/freeOrder', data: map);
      logger.i('/api/freeOrder');
      logger.i(result.data.toString());
      var orderModel = OrderModel.fromJson(result.data);
      if (result.statusCode == 201) {
        resultData['statusCode'] = 200;
        resultData['data'] = orderModel;
        logger.i(result.data.toString());
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  Future<dynamic> confirmPayment(Map<String, dynamic> map) async {
    Response result;
    try {
      Dio dio = getDio();
      debugPrint(json.encode(map).toString());
      result = await dio.post(
        '/api/sslcommerz/success',
        data: map,
      );
      logger.i('/api/sslcommerz/success');

      if (result.statusCode == 201) {
        resultData['statusCode'] = 200;
        logger.i(result.data.toString());
        return resultData;
      }
    } on DioError catch (e) {
      logger.i(_decodeErrorResponse(e));
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }
/*
 ********************************************************************
 *                         Coupon Model                             *
 ********************************************************************
*/

  Future<dynamic> validateCouponApi(Map<String, dynamic> map) async {
    Response result;
    try {
      Dio dio = getDio();
      debugPrint(json.encode(map).toString());
      result = await dio.post('/api/coupons/validate', data: map);
      logger.i('/api/coupons/validate');
      var couponModel = CouponModel.fromJson(result.data);
      logger.i(result.data. toString());
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = couponModel;
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }

  /*
 ********************************************************************
 *                      Get Settings                              *
 ********************************************************************
*/

  Future<dynamic> getSettingsApi() async {
    Response result;
    List<SettingModel> settings = [];
    try {
      Dio dio = getDio();
      result = await dio.get('/api/settings/');
      logger.i('/api/settings/');
      SettingsResponseModel settingsResponseModel =
          SettingsResponseModel.fromJson(result.data);
      settings = settingsResponseModel.data ?? [];
      if (result.statusCode == 200) {
        resultData['statusCode'] = 200;
        resultData['data'] = settings;
        logger.i(result.data);
        return resultData;
      }
    } on DioError catch (e) {
      resultData = _decodeErrorResponse(e);
    }
    return resultData;
  }
}

dynamic _decodeErrorResponse(dynamic e) {
  dynamic data = {
    "statusCode": -1,
    "message": "Unknown Error",
    "singleMessage": ""
  };
  if (e is DioError) {
    if (e.type == DioErrorType.badResponse) {
      final response = e.response;
      try {
        if (response != null) {
          final Map responseData = json.decode(response as String) as Map;
          data["message"] = responseData['message'] as String;
          data["statusCode"] = response.statusCode;
        }
      } catch (err) {
        data["statusCode"] = e.response!.statusCode;
        data["message"] = e.response;
        return data;
      }
    } else if (e.type == DioErrorType.connectionTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.sendTimeout) {
      data["singleMessage"] = "Request timeout";
      data["statusCode"] = 408;
    } else if (e.error is SocketException) {
      data["singleMessage"] = "No Internet Connection!";
    }
  }
  return data;
}
