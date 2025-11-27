import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:salesforce_app/modules/home/controllers/home_controller.dart';

class ProfileController extends GetxController {
  final username = "banditzubair".obs;
  final nama = "Bandit Zubair".obs;
  final nip = "123456789".obs;
  final noKtp = "3501234567890001".obs;
  final noHp = "081234567890".obs;
  final jabatan = "Sales Manager".obs;

  var appVersion = "Loading...".obs;
  var deviceName = "Loading...".obs;
  var deviceOs = "Loading...".obs;
  var productType = "Loading...".obs;

  @override
  void onInit() {
    super.onInit();
    getSystemInfo();
  }

  Future<void> getSystemInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value =
        "v${packageInfo.version} (build ${packageInfo.buildNumber})";

    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceName.value = "${androidInfo.brand} ${androidInfo.model}";
        deviceOs.value = "Android ${androidInfo.version.release}";
        productType.value = androidInfo.product;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceName.value = iosInfo.name;
        deviceOs.value = "${iosInfo.systemName} ${iosInfo.systemVersion}";
        productType.value = iosInfo.model;
      }
    } catch (e) {
      deviceName.value = "Unknown Device";
    }
  }

  void logout() {
    Get.defaultDialog(
      title: "Konfirmasi Keluar",
      middleText: "Apakah Anda yakin ingin keluar dari aplikasi?",
      textConfirm: "Ya, Keluar",
      textCancel: "Batal",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.find<HomeController>().logout();
      },
    );
  }
}
