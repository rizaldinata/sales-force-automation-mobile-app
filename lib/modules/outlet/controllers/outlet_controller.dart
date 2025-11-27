import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesforce_app/app/data/models/outlet_model.dart';
import 'package:salesforce_app/modules/outlet/views/widgets/outlet_filter_sheet.dart';

class OutletController extends GetxController {
  final searchC = TextEditingController();

  var filterDateMode = 'period'.obs;

  var selectedMonth = DateTime.now().obs;

  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();

  final statusList = ["Semua", "Terverifikasi", "Belum Verif"];
  var selectedStatus = "Semua".obs;

  final outlets = <OutletModel>[
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
    OutletModel(
      id: "OUT-001",
      name: "Toko Makmur Jaya",
      type: "Offline",
      address: "Jl. Ahmad Yani No. 45, Surabaya",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-002",
      name: "Berkah Abadi Store",
      type: "Online",
      address: "Ruko Grand City Blok B-12",
      isVerified: true,
    ),
    OutletModel(
      id: "OUT-003",
      name: "Warung Bu Siti",
      type: "Offline",
      address: "Jl. Kebon Jeruk Gg. 2, Jakarta Barat",
      isVerified: false,
    ),
  ].obs;

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }

  void openFilter() {
    Get.bottomSheet(
      const OutletFilterSheet(),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    );
  }

  void applyFilter() {
    Get.back();
    Get.snackbar(
      "Filter Diterapkan",
      "Mode: ${filterDateMode.value}, Status: ${selectedStatus.value}",
    );
  }

  void resetFilter() {
    filterDateMode.value = 'period';
    selectedMonth.value = DateTime.now();
    startDate.value = null;
    endDate.value = null;
    selectedStatus.value = "Semua";
  }

  Future<void> pickDate(BuildContext context, {required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      if (isStart) {
        startDate.value = picked;
      } else {
        endDate.value = picked;
      }
    }
  }
}
