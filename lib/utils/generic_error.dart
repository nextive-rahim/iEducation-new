
import 'package:flutter/material.dart';

class GenericErrorFeedback extends StatelessWidget {
  const GenericErrorFeedback({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Icon(Icons.error),
          const Text(
            "Opps!",
            style: TextStyle(
              color: Color(0xFF3A3A3A),
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
          const SizedBox(height:10),
          const Text(
            "Looks like something went wrong. Please try again later",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF3A3A3A),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: onTap != null,
            child: TextButton(
              onPressed: onTap,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh),
                  SizedBox(width: 10),
                  Text(
                    "Try Again",
                    textScaleFactor: 1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
