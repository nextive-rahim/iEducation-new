import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key});

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  PdfViewerController? _pdfViewerController;
  String fileName = '';
  String title = '';
  @override
  void initState() {
    // TODO: implement initState
    if (Get.arguments != null) {
      fileName = Get.arguments[0];
    }
    _pdfViewerController = PdfViewerController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: SfPdfViewer.network(
          fileName,
          controller: _pdfViewerController,
        ),
      ),
    );
  }
}
