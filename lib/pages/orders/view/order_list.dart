import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/app.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/pages/orders/controller/order_controller.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final controller = Get.put(OrderController());

  @override
  void initState() {
    // TODO: implement initState

    controller.getOrderList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            commonHeader('Orders', context),
            const SizedBox(
              height: 25,
            ),
            getOrderList(),
          ],
        ),
      ),
    );
  }

  Widget getOrderList() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveHeight = MediaQuery.of(context).size.height - 150;
    return SizedBox(
      height: responsiveHeight,
      width: responsiveWidth,
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: const ScrollPhysics(),
        child: Obx(() {
          if (controller.orderIsRefreshing.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!controller.orderIsRefreshing.value &&
              controller.orderList.isEmpty) {
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
                      'No order is found',
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
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              String createdAt =
                  controller.orderList.elementAt(index).createdAt.toString();

              String id = controller.orderList.elementAt(index).id.toString();

              String discount =
                  '${AppConstants.getValueOrZero(controller.orderList.elementAt(index).discount.toString())}৳';

              String due =
                  '${AppConstants.getValueOrZero(controller.orderList.elementAt(index).due.toString())}৳';

              String grandTotal =
                  '${AppConstants.getValueOrZero(controller.orderList.elementAt(index).grandTotal.toString())}৳';

              String total =
                  '${AppConstants.getValueOrZero(controller.orderList.elementAt(index).total.toString())}৳';

              String status = controller.orderList
                  .elementAt(index)
                  .status
                  .toString()
                  .toUpperCase();

              String paid =
                  '${controller.orderList.elementAt(index).paid.toString().toUpperCase()}৳';

              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.getSingleOrder(id);
                    },
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 71,
                        ),
                        width: responsiveWidth,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      '#Id : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      id,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Status : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      status,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Total : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  total,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Discount : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  discount,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Grand Total : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  grandTotal,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Paid : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  paid,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Due : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  due,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Date : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  controller.dates(createdAt),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  controller.getTime(createdAt),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.blue,
                                  ),
                                )
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
            itemCount: controller.orderList.length,
            primary: false,
            shrinkWrap: true,
          );
        }),
      ),
    );
  }
}
