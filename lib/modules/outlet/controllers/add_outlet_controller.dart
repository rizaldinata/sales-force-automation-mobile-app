import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_app/app/core/utils/app_dialog.dart';

class AddOutletController extends GetxController {
  // --- STATE STEPPER ---
  var currentStep = 0.obs;
  final int totalSteps = 3;

  // --- FORM KEYS ---
  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();

  // ============================
  // STEP 1: IDENTITAS & LEGALITAS
  // ============================
  final dateC = TextEditingController();
  final typeC = Rxn<String>();

  final distributionTypeC = Rxn<String>();
  final categoryC = Rxn<String>();
  final purchaseTypeC = Rxn<String>();
  final employeeCountC = Rxn<String>();
  final studentCountC = Rxn<String>();
  final coopMemberCountC = Rxn<String>();

  final nameC = TextEditingController(); // Nama Outlet
  final managerC = TextEditingController(); // Pengelola
  final managerPhoneC = TextEditingController(); // HP Pengelola

  final ownerC = TextEditingController(); // Pemilik
  final ownerPhoneC = TextEditingController(); // HP Pemilik

  final ktpC = TextEditingController(); // KTP
  final landlineC = TextEditingController(); // Telp Rumah/Kantor
  final npwpC = TextEditingController(); // NPWP
  final plafonC = TextEditingController(); // Plafon Kredit

  // ============================
  // STEP 2: LOKASI & FISIK
  // ============================
  final areaC = TextEditingController(); // Area
  final isDetailAreaVisible = false.obs; // Checkbox Detail Area
  final addressC = TextEditingController(); // Alamat
  final postalCodeC = TextEditingController(); // Kode POS

  // Group Bangunan (Dropdowns)
  final locationTypeC = Rxn<String>(); // Lokasi (Mall, Pasar, dll)
  final shopStatusC = Rxn<String>(); // Status Toko (Aktif/Tutup)
  final buildingSizeC = Rxn<String>(); // Luas Bangunan
  final buildingTypeC = Rxn<String>(); // Jenis Bangunan (Permanen/Semi)

  // ============================
  // STEP 3: DETAIL BISNIS
  // ============================
  final hasMotorisTeam = false.obs; // Punya Tim Motoris
  final uplineC = Rxn<String>(); // Upline
  final brandC = Rxn<String>(); // Brands
  final promoMaterialC = Rxn<String>(); // Material Promo
  final onlineShopC = Rxn<String>(); // Online Shop (Tokped/Shopee)
  final visitDayC = Rxn<String>(); // Jadwal Kunjungan (Tambahan Logis)

  final typeList = [
    "Tradisional",
    "Institusi - B2B",
    "Institusi - B2G",
    "Institusi - Ponpes",
    "Institusi - Party",
    "Institusi - Koperasi",
    "Supermarket",
    "Minimarket",
    "Reseller",
    "Kemitraan",
  ];

  // Tradisional, Ponpes, Koperasi
  final distributionTypeList = ["Agen", "Grosir", "Grosir + Retail", "Retail"];

  // Tradisional, B2G, Ponpes, Party, Koperasi
  final categoryList = [
    "A - Top",
    "B - Middle Up",
    "C - Midlle",
    "D - Middle Low",
    "E - Low",
    "R - Reseller",
  ];

  // B2B, B2G, Ponpes, Party, Koperasi
  final purchaseTypeList = ["CSR", "Gift", "Komunitas", "Promosi", "Seragam"];

  // B2B
  final employeeCountList = [
    "1000 - 5000 Orang",
    "< 1000 Orang",
    "> 5000 Orang",
  ];

  // Ponpes
  final studentCountList = [
    "1000 - 5000 Santri",
    "< 1000 Santri",
    "> 5000 Santri",
  ];

  // Koperasi
  final coopMemberCountList = ["1000 - 5000 Orang", "< 1000 Orang"];

  final locationTypeList = [
    "Pinggir Jalan",
    "Dalam Pasar",
    "Perumahan",
    "Mall",
  ];

  final shopStatusList = ["Milik Sendiri", "Sewa", "Kerabat"];
  final buildingSizeList = ["< 20m2", "20-50m2", "50-100m2", "> 100m2"];
  final buildingTypeList = ["Permanen", "Semi Permanen", "Kios"];

  final uplineList = ["Distributor Pusat", "Sub-Distributor", "Agen"];
  final brandList = ["Brand A", "Brand B", "Multi Brand"];
  final promoList = ["Banner", "Rak Display", "Poster", "Tidak Ada"];
  final onlineShopList = ["Shopee", "Tokopedia", "Tiktok Shop", "Tidak Ada"];
  final dayList = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat"];

  @override
  void onInit() {
    super.onInit();
    dateC.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Future<void> chooseDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF096835),
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            dialogTheme: DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dateC.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  void onClose() {
    dateC.dispose();
    nameC.dispose();
    managerC.dispose();
    managerPhoneC.dispose();
    ownerC.dispose();
    ownerPhoneC.dispose();
    ktpC.dispose();
    landlineC.dispose();
    npwpC.dispose();
    plafonC.dispose();
    areaC.dispose();
    addressC.dispose();
    postalCodeC.dispose();
    super.onClose();
  }

  void nextStep() {
    bool isValid = false;
    if (currentStep.value == 0) {
      isValid = formKeyStep1.currentState!.validate();
    } else if (currentStep.value == 1) {
      isValid = formKeyStep2.currentState!.validate();
    } else {
      isValid = true;
    }

    if (isValid && currentStep.value < totalSteps - 1) {
      currentStep.value++;
    } else if (isValid && currentStep.value == totalSteps - 1) {
      submitForm();
    }
  }

  void prevStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    } else {
      Get.back();
    }
  }

  void submitForm() async {
    if (formKeyStep3.currentState!.validate()) {
      AppDialog.showSuccess(
        title: "Berhasil",
        message: "Data outlet lengkap berhasil disimpan!",
        onPressed: () {
          Get.back();
          Get.back();
        },
      );
    }
  }
}
