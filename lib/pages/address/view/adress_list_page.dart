import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/pages/orders/controller/order_controller.dart';
import 'package:ieducation/pages/products/controller/product_controller.dart';
import 'package:ieducation/routes.dart';
import 'package:ieducation/utils/progress_dialog.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final controller = Get.find<ProductController>();
  final orderController = Get.put(OrderController());
  @override
  void initState() {
    // TODO: implement initState
    controller.getAddressList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width / 2;
    double containerWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            commonHeader('Select or Create Address', context),
            const SizedBox(
              height: 25,
            ),
            getAddressList(),
            const SizedBox(
              height: 25,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesPath.createAddress);
                  },
                  child: const CommonButton(title: 'Create New'),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getAddressList() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveHeight = MediaQuery.of(context).size.height - 220;
    return SizedBox(
      height: responsiveHeight,
      width: responsiveWidth,
      child: SingleChildScrollView(
        child: Obx(() {
          if (controller.addressRefreshing.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!controller.addressRefreshing.value &&
              controller.addressList.isEmpty) {
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
                      'No address is found',
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

          return ListView.builder(
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              String name =
                  controller.addressList.elementAt(index).name.toString();
              String phone =
                  controller.addressList.elementAt(index).phone.toString();
              String address =
                  controller.addressList.elementAt(index).address.toString();
              String id = controller.addressList.elementAt(index).id.toString();
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      orderController.params.clear();
                      orderController.params['type'] = "product";
                      orderController.params['address_id'] = id;
                      orderController.params['delivery_option_id'] =
                          controller.selectedDeliveryOption!.id.toString();
                      orderController.params['discount'] = null;
                      orderController.params['coupon'] = '';
                      if (controller.appliedCoupon != null) {
                        orderController.params['discount'] =
                            controller.appliedCoupon!.discount.toString();
                        orderController.params['coupon'] =
                            controller.appliedCoupon!.code.toString();
                      }
                      Map<String, dynamic> item = <String, dynamic>{};
                      item['item_id'] = controller.productDetailData
                          .elementAt(0)
                          .id
                          .toString();
                      item['type'] = "product";
                      item['quantity'] = 1;
                      item['coupon'] = '';
                      if (controller.appliedCoupon != null) {
                        item['coupon'] =
                            controller.appliedCoupon!.code.toString();
                      }
                      orderController.params['items'] = [
                        item,
                      ];
                      progressDialog(context);
                      orderController.createOrder(context);
                    },
                    child: Container(
                      width: responsiveWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: CustomColors.btnBackground),
                      ),
                      padding:
                          const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              getBookItem('Name : ', name, responsiveWidth),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  ('Delete Address')),
                                              content:
                                                  const Text(('Are you sure?')),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text(
                                                    ('No'),
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                                TextButton(
                                                    child: const Text(
                                                      ('Yes'),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      controller.deleteAddress(
                                                        context,
                                                        controller.addressList
                                                            .elementAt(index)
                                                            .id
                                                            .toString(),
                                                      );
                                                    })
                                              ],
                                            );
                                          });
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              getBookItem('Phone : ', phone, responsiveWidth),
                            ],
                          ),
                          Row(
                            children: [
                              getBookItem(
                                  'Address : ', address, responsiveWidth),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              );
            },
            itemCount: controller.addressList.length,
            primary: false,
            shrinkWrap: true,
          );
        }),
      ),
    );
  }

  Widget getBookItem(title, value, responsiveWidth) {
    return SizedBox(
      width: responsiveWidth - 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toString(),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value.toString(),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
