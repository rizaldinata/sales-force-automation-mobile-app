import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:salesforce_app/app/core/utils/app_dialog.dart';

class VisitController extends GetxController {
  final outletList = [
    "Toko Makmur Jaya",
    "Berkah Abadi",
    "Sumber Rejeki",
    "Outlet Merdeka",
  ];
  final outletTypeList = ["General Trade (GT)", "Modern Trade (MT)", "Pareto"];
  var selectedOutlet = Rxn<String>();
  var selectedOutletType = Rxn<String>();
  var waktuDatang = "Belum".obs;
  var waktuPulang = "Belum".obs;
  var visitStatus = 0.obs;
  var isCheckedIn = false.obs;
  var isLoadingMap = true.obs;
  var currentLat = 0.0.obs;
  var currentLng = 0.0.obs;

  final MapController mapController = MapController();

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    isLoadingMap.value = true;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Error", "GPS HP Anda mati. Mohon nyalakan.");
        isLoadingMap.value = false;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Izin Ditolak", "Aplikasi butuh izin lokasi.");
          isLoadingMap.value = false;
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentLat.value = position.latitude;
      currentLng.value = position.longitude;
      isLoadingMap.value = false;
    } catch (e) {
      isLoadingMap.value = false;
      Get.snackbar("Error", "Gagal mengambil lokasi: $e");
    }
  }

  void handleButtonAction() {
    if (visitStatus.value == 0) {
      _checkIn();
    } else if (visitStatus.value == 1) {
      _checkOut();
    }
  }

  void _checkIn() {
    if (selectedOutlet.value == null || selectedOutletType.value == null) {
      AppDialog.showError(
        title: "Data Belum Lengkap",
        message: "Harap pilih Outlet dan Jenis Outlet terlebih dahulu.",
      );
      return;
    }

    var now = DateTime.now();
    waktuDatang.value = DateFormat('HH:mm').format(now);
    visitStatus.value = 1;

    AppDialog.showSuccess(
      title: "Check In Berhasil",
      message:
          "Selamat bekerja! Kunjungan dimulai pada jam ${waktuDatang.value}",
      onPressed: () => Get.back(),
    );
  }

  void _checkOut() {
    Get.defaultDialog(
      title: "Konfirmasi Pulang",
      middleText: "Apakah Anda yakin ingin menyelesaikan kunjungan ini?",
      textConfirm: "Ya, Selesai",
      textCancel: "Batal",
      confirmTextColor: Get.theme.colorScheme.surface,
      onConfirm: () {
        Get.back();

        var now = DateTime.now();
        waktuPulang.value = DateFormat('HH:mm').format(now);
        visitStatus.value = 2;

        AppDialog.showSuccess(
          title: "Kunjungan Selesai",
          message:
              "Terima kasih! Kunjungan selesai pada jam ${waktuPulang.value}",
          onPressed: () => Get.back(),
        );
      },
    );
  }
}
