import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/utils/common_pdf_view.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key});

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  String fileName = '';
  String title = '';
  @override
  void initState() {
    // TODO: implement initState
    if (Get.arguments != null) {
      fileName = Get.arguments[0];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: CommonPDFViewer(pdfLink: fileName),
      ),
    );
  }
}
