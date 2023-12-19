import 'package:flutter/material.dart';

Widget commonHeader(String pageTitle, context) {
  double responsiveWidth = MediaQuery.of(context).size.width - 80;
  String pageName = '${ModalRoute.of(context)?.settings.name}';
  bool isBottomNavigation =
      (pageName == '/BottomNavigation') || (pageName == '/');

  return Column(
    children: [
      const SizedBox(
        height: 50,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          !isBottomNavigation
              ? GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                      child: Image.asset(
                        'assets/images/arrow_left.png',
                        scale: 1,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          SizedBox(
            width: responsiveWidth,
            child: Text(
              pageTitle,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox()
        ],
      ),
    ],
  );
}
