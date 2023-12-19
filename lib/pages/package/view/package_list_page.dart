import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/pages/package/controller/package_controller.dart';

class PackageListPage extends StatefulWidget {
  const PackageListPage({super.key});

  @override
  State<PackageListPage> createState() => _PackageListPageState();
}

class _PackageListPageState extends State<PackageListPage> {
  final controller = Get.put(PackageController());

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
            getPackageList(),
          ],
        ),
      ),
    );
  }

  Widget getPackageList() {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    double textResponsiveWidth = MediaQuery.of(context).size.width - 60;
    double responsiveHeight = MediaQuery.of(context).size.height - 265;
    return SizedBox(
      height: responsiveHeight,
      width: responsiveWidth,
      child: SingleChildScrollView(
        child: Obx(() {
          if (controller.packageIsRefreshing.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!controller.packageIsRefreshing.value &&
              controller.packageList.isEmpty) {
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
                      'No package is found',
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
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 276,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: controller.packageList
                                    .elementAt(index)
                                    .photo
                                    .toString(),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 10.0),
                              child: SizedBox(
                                width: textResponsiveWidth,
                                child: Text(
                                  controller.packageList
                                      .elementAt(index)
                                      .title
                                      .toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  )
                ],
              );
            },
            itemCount: controller.packageList.length,
            primary: false,
            shrinkWrap: true,
          );
        }),
      ),
    );
  }
}
