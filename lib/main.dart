import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ieducation/authentication/authentication_controller.dart';
import 'package:ieducation/authentication/authentication_service.dart';
import 'package:ieducation/pages/package/controller/package_controller.dart';
import 'package:ieducation/routes_path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await GetStorage.init("Auth");
  initialize();
  runApp(const Main());
}

void initialize() {
  Get.lazyPut(
    () => AuthenticationController(
        Get.put(UserAuthenticationService(), permanent: true)),
  );

  Get.lazyPut(() => PackageController());
}

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  _MainState createState() => _MainState();
}

final AuthenticationController controller = Get.put(AuthenticationController(
    Get.put(UserAuthenticationService(), permanent: true)));

class _MainState extends State<Main> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      //to run async code in initState
      // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
      //enables secure mode for app, disables screenshot, screen recording
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;
    return GetMaterialApp(
      navigatorObservers: [routeObserver],
      title: 'I Education',
      debugShowCheckedModeBanner: false,
      // home: Obx(() {
      //   if (controller.state is UnAuthenticated) {
      //     Get.offAllNamed(RoutesPath.login);
      //   }
      //   if (controller.state is Authenticated) {
      //     Get.offAllNamed(RoutesPath
      //         .bottomNavPage); //user: (controller.state as Authenticated).user,
      //   }
      //   return const SplashPage();
      // }),
      getPages: Routes.routes,
    );
  }
}
