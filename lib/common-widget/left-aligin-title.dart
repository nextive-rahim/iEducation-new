import 'package:flutter/material.dart';

Widget leftAlignTitle(String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        height: 8,
        width: 4,
        child: Center(
          child: Image.asset(
            'assets/images/vertical_cylinder.png',
            scale: 1,
          ),
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      SizedBox(
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}
