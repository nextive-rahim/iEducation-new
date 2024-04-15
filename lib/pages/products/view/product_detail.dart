import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ieducation/app.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/products/controller/product_controller.dart';
import 'package:ieducation/routes.dart';

import '../model/delivery_option_model.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final controller = Get.find<ProductController>();
  List<DeliveryOptionData>? deliveryOptionList = [];
  @override
  void initState() {
    // TODO: implement initState
    controller.getDeliveryOptionList().then(
          (value) => setState(
            () {
              deliveryOptionList = value;
            },
          ),
        );
    controller.getFeaturedProductList(context);
    controller.code.clear();
    controller.appliedCoupon = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveText = MediaQuery.of(context).size.width - 60;
    double responsiveHeight = MediaQuery.of(context).size.height - 310;

    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              commonHeader('Book Details', context),
              const SizedBox(
                height: 25,
              ),
              Obx(() {
                if (controller.productIsRefreshing.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!controller.productIsRefreshing.value &&
                    controller.productDetailData.isEmpty) {
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
                            'No detail is found',
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
                String imageUrl =
                    controller.productDetailData.elementAt(0).photo.toString();
                String description = controller.productDetailData
                    .elementAt(0)
                    .description
                    .toString();

                String title =
                    controller.productDetailData.elementAt(0).title.toString();
                String price =
                    controller.productDetailData.elementAt(0).price.toString();
                String discountedPrice = controller.productDetailData
                    .elementAt(0)
                    .discountedPrice
                    .toString();
                return SizedBox(
                  height: responsiveHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(11),
                              topLeft: Radius.circular(11),
                            ),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: imageUrl,
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: responsiveText,
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 14,
                                  width: 14,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/correctCircle.png',
                                      scale: 1,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    'In Stock',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                            Row(
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        leftAlignTitle('Introduction'),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustomColors.pageBackground,
                          ),
                          width: responsiveWidth,
                          child: HtmlWidget(
                            description,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        getInstructorSection(),
                        const SizedBox(
                          height: 20,
                        ),
                        getProductList(),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              buyProductSection(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getInstructorSection() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveTextWidth = MediaQuery.of(context).size.width - 130;
    return Obx(() {
      if (controller.productIsRefreshing.value) {
        return const SizedBox();
      }
      if (controller.productDetailData.isEmpty ||
          controller.productDetailData.elementAt(0).authors == null) {
        return const SizedBox();
      }
      return Column(
        children: [
          const Row(
            children: [
              Text(
                'লেখক',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              String imageUrl = controller.productDetailData
                  .elementAt(0)
                  .authors!
                  .elementAt(index)
                  .photo
                  .toString();

              String name = AppConstants.nullString(controller.productDetailData
                  .elementAt(0)
                  .authors!
                  .elementAt(index)
                  .name
                  .toString());
              String description = AppConstants.nullString(controller
                  .productDetailData
                  .elementAt(0)
                  .authors!
                  .elementAt(index)
                  .description
                  .toString());

              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: responsiveWidth,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 58,
                          width: 58,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 17,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: responsiveTextWidth,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: responsiveTextWidth,
                              child: HtmlWidget(
                                description,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              );
            },
            itemCount:
                controller.productDetailData.elementAt(0).authors!.length,
            primary: false,
            shrinkWrap: true,
          ),
        ],
      );
    });
  }

  Widget buyProductSection() {
    double multipleItem = (MediaQuery.of(context).size.width - 130) / 2;
    double singleItem = (MediaQuery.of(context).size.width - 40);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftAlignTitle('Coupon'),
            SizedBox(
              height: 41,
              width: multipleItem,
              child: TextFormField(
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                controller: controller.code,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      top: 10, right: 20, bottom: 10, left: 20),
                  isDense: true,
                  hintText: 'Coupon',
                  hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.black38),
                  fillColor: Colors.transparent,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: CustomColors.inputBorderColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: CustomColors.inputBorderColor,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  String code = controller.code.text.toString();
                  controller.params.clear();
                  controller.params['code'] = code;
                  controller.params['couponable_type'] = 'product';
                  controller.params['couponable_id'] =
                      controller.productDetailData.elementAt(0).id.toString();
                  if (code.isNotEmpty) {
                    controller.validateCoupon(context);
                  }
                },
                child: getButton('Apply', multipleItem)),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            SizedBox(
              height: 30,
              width: singleItem,
              child: SizedBox(
                child: DropdownButtonFormField<DeliveryOptionData>(
                  dropdownColor: Colors.white,
                  menuMaxHeight: 300,
                  value: controller.selectedDeliveryOption,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.black38),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        top: 5, right: 10, bottom: 5, left: 10),
                    isDense: true,
                    hintText: 'Select delivery option',
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
                    "Select delivery option",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.black38),
                  ),
                  onChanged: onDeliveryListChange,
                  validator: (DeliveryOptionData? value) {
                    if (value == null) {
                      return 'Please select a  Fee Type'.tr;
                    }
                    return null;
                  },
                  items: deliveryOptionList!
                      .map<DropdownMenuItem<DeliveryOptionData>>(
                          (DeliveryOptionData value) {
                    return DropdownMenuItem<DeliveryOptionData>(
                      value: value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            value.name.toString(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            '${value.fee.toString()} Tk.',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // getButton('Add To Cart'),
            GestureDetector(
                onTap: () {
                  if (controller.selectedDeliveryOption == null) {
                    Get.snackbar('Warning', 'Select a delivery option');
                  } else {
                    Get.toNamed(RoutesPath.addressPage);
                  }
                },
                child: getButton('Get this Book', singleItem)),
          ],
        ),
      ],
    );
  }

  Widget getButton(title, btnWidth) {
    return Container(
      width: btnWidth,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CustomColors.btnBackground),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: MCQButtonColors.timeColor,
          ),
        ),
      ),
    );
  }

  Widget getProductList() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double imageWidth = (responsiveWidth - 20) / 2;
    return Column(
      children: [
        leftAlignTitle('More like this'),
        Container(
          width: responsiveWidth,
          decoration: const BoxDecoration(
            color: CustomColors.pageBackground,
          ),
          child: Obx(() {
            return GridView.builder(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controller.featuredProductList.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  controller.getProductDetail(
                    context,
                    controller.featuredProductList
                        .elementAt(index)
                        .slug
                        .toString(),
                  );
                  Get.toNamed(RoutesPath.productDetail);
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 181,
                      width: imageWidth,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(11),
                          topLeft: Radius.circular(11),
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: controller.featuredProductList
                              .elementAt(index)
                              .photo
                              .toString(),
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            width: imageWidth,
                            child: Text(
                              controller.featuredProductList
                                  .elementAt(index)
                                  .title
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black87),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [const SizedBox(), getPrice(index)],
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
        controller.featuredProductList.elementAt(index).price.toString()));
    double discountedPrice = double.parse(AppConstants.getValueOrZero(controller
        .featuredProductList
        .elementAt(index)
        .discountedPrice
        .toString()));

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

  void onDeliveryListChange(category) {
    setState(() {
      controller.selectedDeliveryOption = category;
    });
  }
}
