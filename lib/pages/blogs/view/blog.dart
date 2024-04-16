import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/blogs/controller/blog_controller.dart';
import 'package:ieducation/pages/blogs/model/blog_category_model.dart';
import 'package:ieducation/routes.dart';
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
      appBar: AppBar(
        title: const Text('Blogs'),
        centerTitle: true,
        backgroundColor: CustomColors.pageBackground,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
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
                                top: 5,
                                right: 10,
                                bottom: 5,
                                left: 10,
                              ),
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
                      const SizedBox(width: 4),
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
              const SizedBox(height: 20.0),
              leftAlignTitle('All Blogs'),
              const SizedBox(height: 10.0),
              getBlogList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBlogList() {
    return Obx(() {
      if (controller.blogIsRefreshing.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (!controller.blogIsRefreshing.value && controller.blogList.isEmpty) {
        return Center(
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.blogList.length,
        addAutomaticKeepAlives: true,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          double responsiveWidth = MediaQuery.of(context).size.width - 20;

          return GestureDetector(
            onTap: () {
              Get.toNamed(RoutesPath.blogDetailPage, arguments: [
                controller.blogList.elementAt(index).slug.toString(),
                controller.blogList.elementAt(index).id.toString()
              ]);
              // controller.getSingleBlog(
              //   controller.blogList.elementAt(index).slug.toString(),
              // );
              // setState(() {
              //   controller.selectedCommentableType = 'post';
              //   controller.selectedCommentableId =
              //       controller.blogList.elementAt(index).id.toString();
              // });
              // controller.getCommentList(context,
              //     controller.blogList.elementAt(index).id.toString(), 'post');
            },
            child: Card(
              child: SizedBox(
                height: 80,
                width: responsiveWidth,
                child: Row(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 80,
                      child: AppCachedNetworkImage(
                        imageUrl: controller.blogList
                            .elementAt(index)
                            .photo
                            .toString(),
                        fit: BoxFit.fill,
                        cachedHeight: 147,
                        cachedWidth: 262,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        controller.blogList.elementAt(index).title.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
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
