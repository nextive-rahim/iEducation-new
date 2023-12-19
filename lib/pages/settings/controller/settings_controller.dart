// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:ieducation/api-controller/api.dart';
import 'package:ieducation/pages/settings/models/setting_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum SettingsKeyType { app_version, app_name, app_update }

class SettingsController extends GetxController {
  var isRefreshing = false.obs;

  /// Models
  PackageInfo? packageInfo;

  List<SettingModel> settings = [];

  bool? hasNewUpdate = false;
  bool? isForceUpdate = false;
  bool? showUpdateDialog = false;

  bool? _allSettingsFetched = false;

  String? _appVersion;
  String? _appUpdate;

  @override
  void onInit() async {
    super.onInit();
    packageInfo = await PackageInfo.fromPlatform();
    _allSettingsFetched = false;
  }

  Future<void> getAllSettings() async {
    if (_allSettingsFetched == true) {
      return;
    }

    isRefreshing.value = true;
    final result = await api.getSettingsApi();
    isRefreshing.value = false;
    if (result['statusCode'] == 200) {
      settings = (result['data']);
      await _getInformation();
      _allSettingsFetched = true;
    }
  }

  Future<void> _getInformation() async {
    _appVersion = settings
        .firstWhere(
            (setting) => setting.key == SettingsKeyType.app_version.name)
        .value;

    _appUpdate = settings
        .firstWhere((setting) => setting.key == SettingsKeyType.app_update.name)
        .value;

    if (_appVersion == '${packageInfo?.version}+${packageInfo?.buildNumber}') {
      hasNewUpdate = false;
    } else {
      hasNewUpdate = true;
      showUpdateDialog = true;
      isForceUpdate = _appUpdate == 'mandatory' ? true : false;
    }
  }
}
