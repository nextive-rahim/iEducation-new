import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CommonPDFViewer extends StatefulWidget {
  const CommonPDFViewer({
    super.key,
    required this.pdfLink,
    this.showPageNavigation = true,
  });

  final String pdfLink;
  final bool showPageNavigation;

  @override
  State<CommonPDFViewer> createState() => _CommonPDFViewerState();
}

class _CommonPDFViewerState extends State<CommonPDFViewer> {
  final ValueNotifier<String> _loadingProgress = ValueNotifier<String>('');
  final ValueNotifier<bool> _exists = ValueNotifier<bool>(true);
  final ValueNotifier<String> _urlPDFPath = ValueNotifier<String>('');
  final ValueNotifier<bool> _loaded = ValueNotifier<bool>(false);
  final ValueNotifier<int> _totalPages = ValueNotifier<int>(0);
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);
  final ValueNotifier<bool> _pdfReady = ValueNotifier<bool>(false);

  String title = '';
  PDFViewController? _pdfViewController;
  final textEditingController = TextEditingController();
  Future<File> getFileFromUrl(String url) async {
    String fileName = url.split('/').last;
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      String filePath = '${dir.path}/$fileName';
      File file = File(filePath);

      if (await file.exists()) {
        return file;
      }

      await Dio().download(
        url,
        filePath,
        onReceiveProgress: (count, total) {
          _loadingProgress.value =
              '${(count / total * 100).toStringAsFixed(0)}%';
        },
      );
      return file;
    } catch (e) {
      throw Exception('Error opening url file');
    }
  }

  void requestPermission() async {
    await Permission.storage.request();
  }

  @override
  void initState() {
    requestPermission();

    getFileFromUrl(widget.pdfLink).then(
      (value) => {
        _urlPDFPath.value = value.path,
        _loaded.value = true,
        _exists.value = true,
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _loadingProgress.dispose();
    _exists.dispose();
    _urlPDFPath.dispose();
    _loaded.dispose();
    _totalPages.dispose();
    _currentPage.dispose();
    _pdfReady.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _loaded,
      builder: (BuildContext context, bool value, child) {
        if (_loaded.value) {
          return Stack(
            children: [
              ValueListenableBuilder<bool>(
                  valueListenable: _loaded,
                  builder: (BuildContext context, bool value, child) {
                    return PDFView(
                      filePath: _urlPDFPath.value,
                      enableSwipe: true,
                      swipeHorizontal: false,
                      autoSpacing: false,
                      pageFling: true,
                      pageSnap: true,
                      fitPolicy: FitPolicy.BOTH,
                      onError: (e) {
                        //Show some error message or UI
                      },
                      onRender: (pages) {
                        _totalPages.value = pages!.toInt();
                        _pdfReady.value = true;
                      },
                      onViewCreated: (PDFViewController vc) {
                        _pdfViewController = vc;
                      },
                      onPageChanged: (int? page, int? total) {
                        _currentPage.value = page!.toInt();
                      },
                      onPageError: (page, e) {},
                    );
                  }),
              if (widget.showPageNavigation)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildPageNavigation(),
                ),
            ],
          );
        } else {
          return ValueListenableBuilder<bool>(
            valueListenable: _exists,
            builder: (BuildContext context, bool value, child) {
              if (value) {
                //Replace with your loading UI
                return ValueListenableBuilder<String>(
                    valueListenable: _loadingProgress,
                    builder: (BuildContext context, String value, child) {
                      return Center(
                        child: Text(
                          'Loading... $value',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    });
              } else {
                //Replace Error UI
                return const Text(
                  'PDF Not Available',
                  style: TextStyle(fontSize: 20),
                );
              }
            },
          );
        }
      },
    );
  }

  Widget _buildPageNavigation() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 41,
            width: 150,
            child: TextFormField(
              controller: textEditingController,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
              onChanged: (page) {
                if (textEditingController.text.isEmpty) {
                  return;
                }
                if (int.parse(page) > 0) {
                  _pdfViewController!.setPage(int.parse(page) - 1);
                }
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  top: 10,
                  right: 20,
                  bottom: 10,
                  left: 20,
                ),
                isDense: true,
                hintText: 'Page Number',
                hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.black38),
                fillColor: Colors.transparent,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Color(0xFFD6D6D6),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Color(0xFFD6D6D6),
                    width: 0.5,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                iconSize: 50,
                color: Colors.black,
                onPressed: () {
                  if (_currentPage.value > 0) {
                    _currentPage.value--;
                    _pdfViewController!.setPage(_currentPage.value);
                  }
                },
              ),
              ValueListenableBuilder<int>(
                valueListenable: _currentPage,
                builder: (BuildContext context, int currentPage, child) {
                  return ValueListenableBuilder<int>(
                    valueListenable: _totalPages,
                    builder: (BuildContext context, int totalPages, child) {
                      return Text(
                        '${currentPage + 1}/$totalPages',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                iconSize: 50,
                color: Colors.black,
                onPressed: () {
                  if (_currentPage.value < _totalPages.value - 1) {
                    _currentPage.value++;
                    _pdfViewController!.setPage(_currentPage.value);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
