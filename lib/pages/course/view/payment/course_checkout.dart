import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/app.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/pages/course/widgets/course_title_section.dart';
import 'package:ieducation/routes.dart';

class CourseCheckoutPage extends StatefulWidget {
  const CourseCheckoutPage({super.key});

  @override
  State<CourseCheckoutPage> createState() => _CourseCheckoutPageState();
}

class _CourseCheckoutPageState extends State<CourseCheckoutPage> {
  final controller = Get.put(CourseController());
  List<String> genderType = ['Bkash', 'Nagad', 'Rocket'];
  String? selectedPaymentMethod;
  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height - 170;
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              commonHeader('Checkout', context),
              const SizedBox(
                height: 25,
              ),
              leftAlignTitle('Products'),
              const SizedBox(
                height: 22,
              ),
              SizedBox(
                height: responsiveHeight,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      getImageSection(),
                      const SizedBox(
                        height: 31,
                      ),
                      paymentDetailSection(),
                      const SizedBox(
                        height: 30,
                      ),
                      createPayment(),
                      const SizedBox(
                        height: 20,
                      ),
                      getProductAmount(),
                      const SizedBox(
                        height: 14,
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(RoutesPath.contratulations);
                          },
                          child: const CommonButton(title: 'Next'))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageSection() {
    String imageUrl = controller.selectedFreeCourse!.photo.toString();

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white),
      child: Column(
        children: [
          SizedBox(
            height: 188,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
          getDetailSection()
        ],
      ),
    );
  }

  Widget getDetailSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          CourseTitleSection(
            title: controller.selectedFreeCourse!.title.toString(),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Row(
                children: [
                  Text(
                    '৳ 1600',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: CustomColors.blackSixtyColor,
                        decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '৳ 1200',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget paymentDetailSection() {
    String regularPrice = AppConstants.getValueOrZero(
        controller.selectedFreeCourse!.price.toString());
    String discountedPrice = AppConstants.getValueOrZero(
        controller.selectedFreeCourse!.discountedPrice.toString());
    String discount = AppConstants.getValueOrZero(
        controller.selectedFreeCourse!.discount.toString());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftAlignTitle('Regular Price'),
            getGreenText('৳ $regularPrice')
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [leftAlignTitle('Discount'), getGreenText('৳ $discount')],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftAlignTitle('Payable '),
            getGreenText('৳ $discountedPrice')
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

  Widget createPayment() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    return Column(
      children: [
        leftAlignTitle('Create Payment'),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 41,
          width: responsiveWidth,
          child: TextFormField(
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.center,
            controller: controller.paidToInput,
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  top: 10, right: 20, bottom: 10, left: 20),
              isDense: true,
              hintText: 'Paid to',
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
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 41,
          width: responsiveWidth,
          child: TextFormField(
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.center,
            controller: controller.paidFromInput,
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  top: 10, right: 20, bottom: 10, left: 20),
              isDense: true,
              hintText: 'Paid from',
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
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 41,
          width: responsiveWidth,
          child: TextFormField(
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.center,
            controller: controller.transactionIdInput,
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  top: 10, right: 20, bottom: 10, left: 20),
              isDense: true,
              hintText: 'Transaction ID',
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
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 41,
          width: responsiveWidth,
          child: SizedBox(
            child: DropdownButtonFormField<String>(
              dropdownColor: Colors.white,
              menuMaxHeight: 300,
              value: selectedPaymentMethod,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.black38),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    top: 10, right: 20, bottom: 10, left: 20),
                isDense: true,
                hintText: 'Paid to',
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
              hint: const Text(
                "Select payment",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.black38),
              ),
              onChanged: onPaymentChange,
              validator: (String? value) {
                if (value == null) {
                  return 'Please select a  Fee Type'.tr;
                }
                return null;
              },
              items: genderType.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
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
      ],
    );
  }

  void onPaymentChange(method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  Widget getProductAmount() {
    String discountedPrice = AppConstants.getValueOrZero(
        controller.selectedFreeCourse!.discountedPrice.toString());
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
}
