import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/authentication/authentication_controller.dart';
import 'package:ieducation/authentication/authentication_service.dart';
import 'package:ieducation/authentication/authentication_state.dart';
import 'package:ieducation/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthenticationController controller = Get.put(AuthenticationController(
      Get.put(UserAuthenticationService(), permanent: true)));
  @override
  void initState() {
    super.initState();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        if (controller.state is UnAuthenticated) {
          Get.offNamed(RoutesPath.login);
        }
        if (controller.state is Authenticated) {
          Get.offNamed(RoutesPath
              .bottomNavPage); //user: (controller.state as Authenticated).user,
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 15),
                  height: 60,
                  width: 161,
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      scale: 1,
                      cacheHeight: 157,
                      cacheWidth: 372,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
