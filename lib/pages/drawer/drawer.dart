import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/pages/auth/controller/auth_controller.dart';
import 'package:ieducation/pages/home/controller/home_controller.dart';
import 'package:ieducation/routes.dart';
import 'package:ieducation/utils/cached_network_image.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class GetDrawer extends StatefulWidget {
  const GetDrawer({super.key});

  @override
  State<GetDrawer> createState() => _GetDrawerState();
}

class _GetDrawerState extends State<GetDrawer> {
  final controller = Get.find<HomeController>();
  final authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    controller.getUserInfo();
    super.initState();
    _initPackageInfo();
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return getDrawer();
  }

  Widget getDrawer() {
    return Drawer(
      width: 310,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          getProfile(),
          getListTile('my_profile'),
          // getListTile('my_cart'),
          getListTile('my_courses'),
          getListTile('my_orders'),
          getListTile('contact_us'),
          getListTile('about_us'),
          GestureDetector(
              onTap: () {
                controller.signOut();
              },
              child: getListTile('logout')),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              _launchURL('https://nextivesolution.com/');
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Text(
                    'Developer by ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Nextive Solution',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _packageInfo.version,
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                '+${_packageInfo.buildNumber}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ListTile getListTile(String action) {
    return ListTile(
      title: Container(
        height: 50,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CustomColors.borderBottom,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            getIcon(action),
            const SizedBox(
              width: 20,
            ),
            Text(
              getActionName(action),
              style: const TextStyle(fontSize: 17, fontFamily: 'Poppins'),
            )
          ],
        ),
      ),
      onTap: () {
        switch (action) {
          case 'my_profile':
            {
              setProfileData();
              Get.toNamed(RoutesPath.profilePage);
            }
            break;
          case 'my_cart':
            break;
          case 'my_courses':
            Get.toNamed(RoutesPath.myCoursePage);
            break;
          case 'my_orders':
            Get.toNamed(RoutesPath.orderListPage);
            break;
          case 'contact_us':
            _launchURL('http://m.me/iEducationBangladesh');
            break;
          case 'about_us':
            Get.toNamed(RoutesPath.aboutUsPage);
            break;
          case 'logout':
            controller.signOut();
        }
      },
    );
  }

  Icon getIcon(String action) {
    switch (action) {
      case 'my_profile':
        return const Icon(
          Icons.person_outline_outlined,
          size: 26,
          color: Colors.black,
        );
      case 'my_cart':
        return const Icon(
          Icons.shopping_cart,
          size: 26,
          color: Colors.black,
        );
      case 'my_orders':
        return const Icon(
          Icons.shopping_bag_outlined,
          size: 26,
          color: Colors.black,
        );
      case 'my_courses':
        return const Icon(
          Icons.school_outlined,
          size: 26,
          color: Colors.black,
        );
      case 'contact_us':
        return const Icon(
          Icons.contact_mail_outlined,
          size: 26,
          color: Colors.black,
        );
      case 'about_us':
        return const Icon(
          Icons.info_outline,
          size: 26,
          color: Colors.black,
        );
      case 'logout':
        return const Icon(
          Icons.logout,
          size: 26,
          color: Colors.black,
        );
    }
    return const Icon(
      Icons.person_outline_outlined,
      size: 26,
      color: Colors.black,
    );
  }

  String getActionName(String action) {
    switch (action) {
      case 'my_profile':
        return 'My Profile';
      case 'my_cart':
        return 'My Cart';
      case 'my_courses':
        return 'My Courses';
      case 'my_orders':
        return 'My Orders';
      case 'contact_us':
        return 'Contact Us';
      case 'about_us':
        return 'About Us';
      case 'logout':
        return 'Logout';
    }
    return '';
  }

  Widget getProfile() {
    return SizedBox(
      width: 500,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () {
              if (controller.myInfo.isNotEmpty) {
                return Column(
                  children: [
                    controller.myInfo.elementAt(0).photo != null
                        ? SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: AppCachedNetworkImage(
                                imageUrl: controller.myInfo
                                    .elementAt(0)
                                    .photo
                                    .toString(),
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            size: 100,
                          ),
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: Text(
                        controller.myInfo.elementAt(0).name != null
                            ? controller.myInfo.elementAt(0).name.toString()
                            : "No name found",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Poppins'),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: Text(
                        controller.myInfo.elementAt(0).currentInstitution !=
                                null
                            ? controller.myInfo
                                .elementAt(0)
                                .currentInstitution
                                .toString()
                            : "No name found",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Poppins'),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }

  void setProfileData() {
    authController.nameController.text =
        isNull(controller.myInfo.elementAt(0).name);
    authController.institutionController.text =
        isNull(controller.myInfo.elementAt(0).currentInstitution);
    authController.emailController.text =
        isNull(controller.myInfo.elementAt(0).email);
    authController.phoneController.text =
        isNull(controller.myInfo.elementAt(0).phone);
  }

  String isNull(value) {
    if (value == null) return '';
    return value;
  }

  Future<void> _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
