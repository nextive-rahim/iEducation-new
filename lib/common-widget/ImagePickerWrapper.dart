import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWrapper extends StatelessWidget {
  final ImageSource source = Get.arguments;

  ImagePickerWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        final XFile? image = await ImagePicker().pickImage(
          source: source,
          imageQuality: 60,
        );
        Get.back(result: image);
      } catch (e) {
        e.printError();
        Get.back(result: null);
      }
    });
    return Container();
  }
}
