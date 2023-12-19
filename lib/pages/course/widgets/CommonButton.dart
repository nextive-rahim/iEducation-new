import 'package:flutter/material.dart';
import 'package:ieducation/colors.dart';

class CommonButton extends StatefulWidget {
  final String title;
  final Color? backgroundColor;
  const CommonButton({
    super.key,
    required this.title,
    this.backgroundColor,
  });

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.backgroundColor ?? CustomColors.btnBackground,
      ),
      child: Center(
        child: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
