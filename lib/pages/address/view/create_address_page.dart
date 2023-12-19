import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/common-widget/left-aligin-title.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/pages/products/controller/product_controller.dart';
import 'package:ieducation/utils/progress_dialog.dart';

class CreateAddress extends StatefulWidget {
  const CreateAddress({super.key});

  @override
  State<CreateAddress> createState() => _CreateAddressState();
}

class _CreateAddressState extends State<CreateAddress> {
  final controller = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double responsiveHeight = MediaQuery.of(context).size.height - 400;
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              commonHeader('Create Address', context),
              const SizedBox(
                height: 25,
              ),
              leftAlignTitle('Recipient’s Info'),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      height: 41,
                      width: responsiveWidth,
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.center,
                        controller: controller.name,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 10, right: 20, bottom: 10, left: 20),
                          isDense: true,
                          hintText: 'Name',
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
                        controller: controller.phone,
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
                          hintText: 'Phone',
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
                      height: 150,
                      width: responsiveWidth,
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.center,
                        controller: controller.address,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 10, right: 20, bottom: 10, left: 20),
                          isDense: true,
                          hintText: 'Address',
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
                          String name = controller.name.text;
                          String phone = controller.phone.text;
                          String address = controller.address.text;
                          print(name);
                          print(phone);
                          print(address);
                          if (phone.length != 11) {
                            showMobileError();
                          }

                          if (phone.length == 11 &&
                              address.isNotEmpty &&
                              name.isNotEmpty) {
                            controller.params.clear();
                            controller.params['phone'] = phone;
                            controller.params['name'] = name;
                            controller.params['address'] = address;
                            progressDialog(context);
                            controller.createAddress(context);
                          } else {
                            Get.snackbar(
                              'Error',
                              'Fill up required filled',
                              duration: const Duration(seconds: 1),
                            );
                          }
                        },
                        child: const CommonButton(title: 'Confirm Address'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showMobileError() {
    Get.snackbar(
      'Error',
      'Mobile Number must be of 11 digit',
      duration: const Duration(seconds: 1),
    );
  }
}
