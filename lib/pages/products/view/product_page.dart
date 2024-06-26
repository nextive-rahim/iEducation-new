import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/app.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/drawer/drawer.dart';
import 'package:ieducation/pages/products/controller/product_controller.dart';
import 'package:ieducation/routes.dart';
import 'package:ieducation/utils/cached_network_image.dart';

class ProductPage extends GetView<ProductController> {
  ProductPage({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey3 = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey3,
      backgroundColor: CustomColors.pageBackground,
      drawer: const GetDrawer(),
      appBar: getAppHeader(),
      //  AppBar(
      //   title: const Text('Books'),
      //   centerTitle: true,
      //   backgroundColor: CustomColors.pageBackground,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          child: getProductList(),
        ),
      ),
    );
  }

  Widget getProductList() {
    return Column(
      children: [
        leftAlignTitle('All Books'),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: const BoxDecoration(
            color: CustomColors.pageBackground,
          ),
          child: Obx(() {
            if (controller.productIsRefreshing.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (controller.productList.isEmpty) {
              return Center(
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
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
                        'No product is found',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            }

            return GridView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controller.productList.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  controller.getProductDetail(
                    context,
                    controller.productList.elementAt(index).slug.toString(),
                  );
                  Get.toNamed(RoutesPath.productDetail);
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 181,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(11),
                          topLeft: Radius.circular(11),
                        ),
                        child: AppCachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl:
                              controller.productList[index].photo.toString(),
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          const SizedBox(height: 6),
                          SizedBox(
                            child: Text(
                              controller.productList[index].title.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              getPrice(index),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 255,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget getPrice(index) {
    double price = double.parse(AppConstants.getValueOrZero(
        controller.productList[index].price.toString()));
    double discountedPrice = double.parse(AppConstants.getValueOrZero(
        controller.productList[index].discountedPrice.toString()));

    if (price <= 0) {
      return const Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: Text(
          'Free',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: Colors.blue,
              fontSize: 14),
        ),
      );
    }

    if (discountedPrice == price) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              Text(
                '৳ $discountedPrice',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      );
    }

    return Row(
      children: [
        Text(
          '৳ $price',
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: CustomColors.discountColor,
              decoration: TextDecoration.lineThrough),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '৳ $discountedPrice',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.blue,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  AppBar getAppHeader() {
    return AppBar(
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 65,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () => scaffoldKey3.currentState!.openDrawer(),
              child: SizedBox(
                height: 45,
                width: 45,
                child: Center(
                  child: Image.asset(
                    'assets/images/head_menu.png',
                    scale: 1,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: SizedBox(
              height: 50,
              width: 97,
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  scale: 1,
                  cacheHeight: 131,
                  cacheWidth: 310,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                Get.toNamed(RoutesPath.noticePage);
              },
              child: SizedBox(
                height: 45,
                width: 45,
                child: Center(
                  child: Image.asset(
                    'assets/images/head_notification.png',
                    scale: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
