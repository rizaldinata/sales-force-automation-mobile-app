import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  var isCheckedIn = false.obs;

  void checkIn() {
    if (selectedOutlet.value == null || selectedOutletType.value == null) {
      Get.snackbar(
        "Error",
        "Harap pilih Outlet dan Jenis Outlet terlebih dahulu",
      );
      return;
    }

    var now = DateTime.now();
    waktuDatang.value = DateFormat('HH:mm').format(now);
    isCheckedIn.value = true;

    Get.snackbar("Sukses", "Berhasil Check-In di ${selectedOutlet.value}");
  }
}
