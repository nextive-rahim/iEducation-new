import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/app.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/pages/orders/controller/order_controller.dart';
import 'package:ieducation/pages/orders/widgets/ssl_commerz_config.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final controller = Get.put(OrderController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height - 210;

    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              commonHeader('Checkout', context),
              const SizedBox(
                height: 20,
              ),
              leftAlignTitle('Products to Buy'),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: responsiveHeight,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        if (controller.orderIsRefreshing.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!controller.orderIsRefreshing.value &&
                            controller.selectedOrderDetail.isEmpty) {
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
                        String imageUrl = controller.selectedOrderDetail
                            .elementAt(0)
                            .sells!
                            .elementAt(0)
                            .photo
                            .toString();

                        String title = controller.selectedOrderDetail
                            .elementAt(0)
                            .sells!
                            .elementAt(0)
                            .itemName
                            .toString();

                        double responsiveWidth =
                            MediaQuery.of(context).size.width - 40;
                        double imageWidth = responsiveWidth / 2;

                        if (controller.selectedOrderDetail
                                .elementAt(0)
                                .sells!
                                .elementAt(0)
                                .type ==
                            "course") {
                          imageWidth = responsiveWidth;
                        }

                        return SizedBox(
                          width: imageWidth,
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
                                    imageUrl: imageUrl,
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
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            title,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 31,
                      ),
                      paymentDetailSection(),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  sslCommerzGeneralCall(
                      orderDataModel: controller.orderModelData);
                },
                child: const CommonButton(title: 'Payment'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentDetailSection() {
    String grandTotal = AppConstants.getValueOrZero(
        controller.selectedOrderDetail.elementAt(0).grandTotal.toString());

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftAlignTitle('Need to pay'),
            getGreenText('৳ $grandTotal')
          ],
        ),
      ],
    );
  }

  Widget getGreenText(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.green),
    );
  }

  Widget getProductAmount() {
    String discountedPrice = AppConstants.getValueOrZero(
      controller.selectedOrderDetail.elementAt(0).grandTotal.toString(),
    );

    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Selected Products:',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
              Text(
                '1',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Price:',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
              getGreenText('৳ $discountedPrice')
            ],
          ),
        ],
      ),
    );
  }

  void showMobileError(message) {
    Get.snackbar('Error', message);
  }

  Widget rowItem(vendor) {
    switch (vendor.toLowerCase()) {
      case 'bkash':
        return getRow(vendor, 'assets/images/bkash.png');
      case 'nagad':
        return getRow(vendor, 'assets/images/nagad.png');
      case 'rocket':
        return getRow(vendor, 'assets/images/rocket.png');
    }
    return getRow(vendor, 'assets/images/bank.png');
  }

  Widget getRow(text, image) {
    return Row(
      children: [
        Image.asset(
          image,
          height: 35,
          width: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
