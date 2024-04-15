import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/colors.dart';
import 'package:ieducation/common-widget/common-header.dart';
import 'package:ieducation/pages/auth/controller/auth_controller.dart';
import 'package:ieducation/pages/course/widgets/CommonButton.dart';
import 'package:ieducation/pages/home/controller/home_controller.dart';
import 'package:ieducation/routes.dart';
import 'package:ieducation/utils/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = Get.put(AuthController());

  final homeController = Get.find<HomeController>();

  List<String> genderType = ['male', 'female', 'others'];

  String? selectedGender;
  String? selectedImage;

  dynamic pickImageError;

  final ImagePicker picker = ImagePicker();

  XFile? _image;

  File? selected;

  @override
  void initState() {
    // TODO: implement initState
    selectedGender = homeController.myInfo.elementAt(0).gender;
    selectedImage = homeController.myInfo.elementAt(0).photo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double responsiveWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      backgroundColor: CustomColors.pageBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              commonHeader('Profile', context),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 41,
                width: responsiveWidth,
                child: TextFormField(
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  controller: controller.nameController,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        top: 10, right: 20, bottom: 10, left: 20),
                    isDense: true,
                    hintText: 'Full Name',
                    hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.black38),
                    fillColor: Colors.transparent,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: CustomColors.inputBorderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: CustomColors.inputBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 41,
                width: responsiveWidth,
                child: TextFormField(
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  controller: controller.institutionController,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        top: 10, right: 20, bottom: 10, left: 20),
                    isDense: true,
                    hintText: 'Current Institution',
                    hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.black38),
                    fillColor: Colors.transparent,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: CustomColors.inputBorderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: CustomColors.inputBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 41,
                width: responsiveWidth,
                child: TextFormField(
                  readOnly: true,
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const SizedBox(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          '+88',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(
                        top: 10, right: 20, bottom: 10, left: 20),
                    isDense: true,
                    hintText: '01xxxxxxxxx',
                    hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.black38),
                    fillColor: Colors.transparent,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: CustomColors.inputBorderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: CustomColors.inputBorderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 41,
                width: responsiveWidth,
                child: SizedBox(
                  child: DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    menuMaxHeight: 300,
                    value: selectedGender,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.black38),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 10, right: 20, bottom: 10, left: 20),
                      isDense: true,
                      hintText: 'Select Gender',
                      hintStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.black38),
                      fillColor: Colors.transparent,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: CustomColors.inputBorderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: CustomColors.inputBorderColor,
                          width: 0.5,
                        ),
                      ),
                    ),
                    hint: const Text(
                      "Select Gender",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.black38),
                    ),
                    onChanged: onGenderChange,
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select a  Fee Type'.tr;
                      }
                      return null;
                    },
                    items: genderType
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
/*              const SizedBox(
                height: 15,
              ),
              SizedBox(
                child: DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'd MMM, yyyy ',
                    initialValue: DateTime.now().toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: const Icon(Icons.event),
                    dateLabelText: 'Date of Birth',
                    timeLabelText: "Hour",
                    selectableDayPredicate: (date) {
                      return true;
                    },
                    onChanged: (val) {
                      controller.params['dob'] = val;
                    },
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) {
                      controller.params['dob'] = val;
                    }),
              ),*/
              const SizedBox(
                height: 15,
              ),
              _image == null
                  ? selectedImage != null
                      ? SizedBox(
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl: selectedImage.toString(),
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        )
                      : Image.asset(
                          'assets/images/student.png',
                          height: 120,
                        )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.file(
                        selected!,
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.fill,
                      ),
                    ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  _showPicker(context);
                },
                child: Container(
                  height: 30,
                  width: 200,
                  decoration: BoxDecoration(
                      color: CustomColors.btnBackground,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                      Text(('Upload Photo'),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 58,
              ),
              GestureDetector(
                onTap: () {
                  String name = controller.nameController.text;
                  String phone = controller.phoneController.text;
                  String currentInstitution =
                      controller.institutionController.text;

                  bool isValidInput = (phone.length != 11 && !name.isNotEmpty ||
                          !currentInstitution.isNotEmpty)
                      ? false
                      : true;
                  if (phone.length != 11) {
                    showMobileError();
                  }

                  if (isValidInput) {
                    controller.params.clear();
                    controller.params['name'] = name;
                    controller.params['phone'] = phone;
                    controller.params['current_institution'] =
                        currentInstitution;
                    if (selectedGender != null) {
                      controller.params['gender'] = selectedGender;
                    }

                    progressDialog(context);
                    controller.updateUser(context,
                        homeController.myInfo.elementAt(0).id.toString());
                  }
                },
                child: const CommonButton(title: 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: SizedBox(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () async {
                        await _picImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () async {
                      await _picImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _picImage(ImageSource imageSource) async {
    try {
      XFile? image;
      if (GetPlatform.isIOS) {
        await Get.toNamed(RoutesPath.myImagePicker, arguments: imageSource)!
            .then((result) {
          image = result;
        });
      } else {
        image = await ImagePicker()
            .pickImage(source: imageSource, imageQuality: 30);
      }

      _image = image;

      if (_image != null) {
        debugPrint(_image!.path);
        selected = File(_image!.path);
        setState(() {
          controller.selectedProfileImgPath = _image!.path;
        });
      }
    } catch (e) {
      e.printError();
    }
  }

  void onGenderChange(gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  void showMobileError() {
    Get.snackbar('Error', 'Mobile Number must be of 11 digit');
  }

  void showPasswordError() {
    Get.snackbar('Error', 'Password must be at last 6 digits');
  }
}
