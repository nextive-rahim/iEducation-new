import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppCachedNetworkImage extends StatefulWidget {
  const AppCachedNetworkImage({
    super.key,
    this.imageUrl,
    this.cachedWidth,
    this.cachedHeight,
    this.fit,
    this.width,
  });
  final String? imageUrl;
  final int? cachedWidth;
  final int? cachedHeight;
  final double? width;
  final BoxFit? fit;
  @override
  State<AppCachedNetworkImage> createState() => _AppCachedNetworkImage();
}

class _AppCachedNetworkImage extends State<AppCachedNetworkImage> {
  final ValueNotifier<String> _loadingProgress = ValueNotifier<String>('');
  final ValueNotifier<bool> _exists = ValueNotifier<bool>(false);
  final ValueNotifier<String?> _cachedImagePath = ValueNotifier<String?>(null);
  final ValueNotifier<bool> _loaded = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();

    _downloadImage(widget.imageUrl).then(
      (value) {
        _cachedImagePath.value = value.path;
        _loaded.value = true;
        _exists.value = true;
      },
    );
  }

  Future<File> _downloadImage(String? url) async {
    final String imageLink = (url == 'null' || url == null)
        ? 'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg'
        : url;
    print('...........................$imageLink');
    final dio = Dio();

    try {
      // Define cache directory
      Directory dir = await getApplicationDocumentsDirectory();
      String fileName = imageLink.split('/').last;
      String filePath = '${dir.path}/$fileName';
      File file = File(filePath);

      if (await file.exists()) {
        return file;
      }

      // Download image
      await dio.download(
        imageLink,
        filePath,
        onReceiveProgress: (count, total) {
          _loadingProgress.value =
              '${(count / total * 100).toStringAsFixed(0)}%';
        },
      );

      return file;
    } catch (e) {
      throw Exception('Error opening url file${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _loaded,
      builder: (BuildContext context, bool value, child) {
        if (_loaded.value) {
          return Image.file(
            File(_cachedImagePath.value!),
            fit: widget.fit ?? BoxFit.fill,
            cacheHeight: widget.cachedHeight,
            cacheWidth: widget.cachedWidth,
            width: widget.width,
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg',
                fit: widget.fit ?? BoxFit.fill,
                width: double.infinity,
              );
            },
          );
        } else {
          return ValueListenableBuilder<bool>(
            valueListenable: _exists,
            builder: (BuildContext context, bool value, child) {
              if (!value) {
                //Replace with your loading UI
                return ValueListenableBuilder<String>(
                  valueListenable: _loadingProgress,
                  builder: (BuildContext context, String value, child) {
                    return Center(
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                );
              } else {
                //Replace Error UI
                return Image.network(
                  'https://static.vecteezy.com/system/resources/previews/005/337/799/non_2x/icon-image-not-found-free-vector.jpg',
                  fit: BoxFit.fill,
                  width: double.infinity,
                );
              }
            },
          );
        }
      },
    );
  }
}
