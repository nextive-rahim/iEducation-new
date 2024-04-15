import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/blogs/controller/blog_controller.dart';
import 'package:ieducation/pages/blogs/model/blog_category_model.dart';
import 'package:ieducation/utils/cached_network_image.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final controller = Get.find<BlogController>();
  BlogCategoryListData? selectedCategory;
  List<BlogCategoryListData>? categoryList = [];
  @override
  void initState() {
    // TODO: implement initState
    controller.getBlogCategoryList().then(
          (value) => setState(
            () {
              categoryList = value;
            },
          ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            commonHeader('Blogs', context),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leftAlignTitle('Category'),
                Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: responsiveWidth,
                      child: SizedBox(
                        child: DropdownButtonFormField<BlogCategoryListData>(
                          dropdownColor: Colors.white,
                          menuMaxHeight: 300,
                          value: selectedCategory,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Colors.black38),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 5, right: 10, bottom: 5, left: 10),
                            isDense: true,
                            hintText: 'Paid to',
                            hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Colors.black38),
                            fillColor: Colors.transparent,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: CustomColors.inputBorderColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: CustomColors.inputBorderColor,
                                width: 0.5,
                              ),
                            ),
                          ),
                          hint: const Text(
                            "Select category",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Colors.black38),
                          ),
                          onChanged: onCategoryChange,
                          validator: (BlogCategoryListData? value) {
                            if (value == null) {
                              return 'Please select a  Fee Type'.tr;
                            }
                            return null;
                          },
                          items: categoryList!
                              .map<DropdownMenuItem<BlogCategoryListData>>(
                                  (BlogCategoryListData value) {
                            return DropdownMenuItem<BlogCategoryListData>(
                              value: value,
                              child: Text(
                                value.name.toString(),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = null;
                          });
                          controller.getBlogList('');
                        },
                        child: const Icon(Icons.clear))
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            leftAlignTitle('All Blogs'),
            getBlogList(),
          ],
        ),
      ),
    );
  }

  Widget getBlogList() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveHeight = MediaQuery.of(context).size.height - 265;
    return SizedBox(
      height: responsiveHeight,
      width: responsiveWidth,
      child: Obx(() {
        if (controller.blogIsRefreshing.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!controller.blogIsRefreshing.value && controller.blogList.isEmpty) {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.only(top: 20),
                width: 250,
                height: 120,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 50,
                    ),
                    Text(
                      'No blog is found',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            double responsiveWidth = MediaQuery.of(context).size.width - 40;
            double imageWidth = 100;
            double descriptionWidth = responsiveWidth - 120;
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.getSingleBlog(
                      context,
                      controller.blogList.elementAt(index).slug.toString(),
                    );
                    setState(() {
                      controller.selectedCommentableType = 'post';
                      controller.selectedCommentableId =
                          controller.blogList.elementAt(index).id.toString();
                    });
                    controller.getCommentList(
                        context,
                        controller.blogList.elementAt(index).id.toString(),
                        'post');
                  },
                  child: Card(
                    child: SizedBox(
                      height: 100,
                      width: responsiveWidth,
                      child: Row(
                        children: [
                          SizedBox(
                            width: imageWidth,
                            child: AppCachedNetworkImage(
                              imageUrl: controller.blogList
                                  .elementAt(index)
                                  .photo
                                  .toString(),
                              fit: BoxFit.cover,
                              cachedHeight: 147,
                              cachedWidth: 262,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 9),
                              SizedBox(
                                width: descriptionWidth,
                                child: Text(
                                  controller.blogList
                                      .elementAt(index)
                                      .title
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            );
          },
          itemCount: controller.blogList.length,
          primary: false,
          shrinkWrap: true,
        );
      }),
    );
  }

  void onCategoryChange(category) {
    setState(() {
      selectedCategory = category;
    });
    controller.getBlogByCategoryList(
      context,
      selectedCategory!.slug.toString(),
    );
  }
}
