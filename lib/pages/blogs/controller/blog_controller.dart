import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/api-controller/api.dart';
import 'package:ieducation/pages/blogs/model/blog_category_model.dart';
import 'package:ieducation/pages/blogs/model/blog_detail_model.dart';
import 'package:ieducation/pages/blogs/model/blog_model.dart';
import 'package:ieducation/pages/blogs/model/comment_model.dart';
import 'package:ieducation/utils/handleErrorMessage.dart';

class BlogController extends GetxController {
  var blogIsRefreshing = false.obs;
  var blogDetailsIsRefreshing = false.obs;
  var commentRefreshing = false.obs;
  List<BlogDataList> blogList = [];
  RxList<CommentListData> commentList = <CommentListData>[].obs;
  BlogDetailData? singleBlog;
  Map<String, dynamic> params = <String, dynamic>{};
  TextEditingController bodyController = TextEditingController();

  String? selectedCommentableId;
  String? selectedCommentableType = '';
  String? editCommentId;
  @override
  void onInit() {
    getBlogList('');
    // TODO: implement onInit
    super.onInit();
  }

  void createComment(context) async {
    var result;
    result = await api.createCommentApi(params);
    Get.back();
    if (result['statusCode'] == 200) {
      bodyController.clear();
      getCommentList(
          selectedCommentableId.toString(), selectedCommentableType.toString());
    } else {
      handleErrorMessage(context, result);
    }
  }

  void deleteComment(context, id) async {
    var result;
    result = await api.deleteCommentApi(id);

    if (result['statusCode'] == 200) {
      getCommentList(
          selectedCommentableId.toString(), selectedCommentableType.toString());
      Get.snackbar('Success', 'Comment delete successfully');
    } else {
      handleErrorMessage(context, result);
    }
  }

  void updateComment(context, id) async {
    var result;
    result = await api.updateCommentApi(id, params);
    Get.back();
    if (result['statusCode'] == 200) {
      editCommentId = null;
      bodyController.clear();
      Get.snackbar('Success', 'Comment successfully updated!');
      getCommentList(
          selectedCommentableId.toString(), selectedCommentableType.toString());
    } else {
      handleErrorMessage(context, result);
    }
  }

  void getBlogList(url) async {
    var result;
    blogIsRefreshing.value = true;
    result = await api.getBlogListApi(url);
    blogIsRefreshing.value = false;
    if (result['statusCode'] == 200) {
      blogList = result['data'].data;
    } else {
      Get.snackbar(
        'Failed',
        "Fetching blogs error",
      );
    }
  }

  void getCommentList(id, type) async {
    var result;
    commentRefreshing.value = true;
    print(id.toString());
    result = await api.getCommentList(id, type);
    commentRefreshing.value = false;
    if (result['statusCode'] == 200) {
      commentList.clear();
      commentList.addAll(result['data'].data.toList());
      commentList.refresh();
    }
  }

  Future<void> getSingleBlog(slug) async {
    var result;
    blogDetailsIsRefreshing.value = true;
    result = await api.getSingleBlog(slug);
    blogDetailsIsRefreshing.value = false;
    if (result['statusCode'] == 200) {
      singleBlog = result['data'].data;
    } else {}
  }

  void getBlogByCategoryList(context, slug) async {
    var result;
    blogIsRefreshing.value = true;
    result = await api.getBlogByCategoryApi(slug);
    blogIsRefreshing.value = false;
    if (result['statusCode'] == 200) {
      blogList.clear();
      print(result['data']);
      blogList = result['data'];
    } else {
      handleErrorMessage(context, result);
    }
  }

  Future<void> onRefresh() async {
    getCommentList(
        selectedCommentableId.toString(), selectedCommentableType.toString());
  }

  Future<List<BlogCategoryListData>?> getBlogCategoryList() async {
    var result;
    result = await api.getBlogCategoryListApi();
    if (result['statusCode'] == 200) {
      return result['data'];
    }
    return null;
  }
}
