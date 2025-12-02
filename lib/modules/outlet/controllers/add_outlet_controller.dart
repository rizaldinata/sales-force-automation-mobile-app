import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_app/app/core/utils/app_dialog.dart';
import 'package:salesforce_app/app/data/models/region_model.dart';

class AddOutletController extends GetxController {
  // State tahap form
  var currentStep = 0.obs;
  final int totalSteps = 3;

  // Forms keys
  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();

  // Tahap 1
  // Tanggal Registrasi
  final dateC = TextEditingController();

  // Jenis dan tipe outlet
  final typeC = Rxn<String>();
  final distributionTypeC = Rxn<String>();
  final categoryC = Rxn<String>();
  final purchaseTypeC = Rxn<String>();
  final employeeCountC = Rxn<String>();
  final studentCountC = Rxn<String>();
  final coopMemberCountC = Rxn<String>();

  // Informasi dasar
  final nameC = TextEditingController();
  final managerC = TextEditingController();
  final managerPhoneC = TextEditingController();

  // Pemilik dan legalitas
  final ownerC = TextEditingController();
  final ownerPhoneC = TextEditingController();
  final ktpC = TextEditingController();
  final telephoneC = TextEditingController();
  final npwpC = TextEditingController();
  final plafonC = TextEditingController();

  // Tahap 2
  // Foto identitas dan lokasi
  var ktpPhotoPath = Rxn<String>();
  var npwpPhotoPath = Rxn<String>();
  var shopPhotoPaths = <String>[].obs;
  final ImagePicker _picker = ImagePicker();

  // Alamat dan lokasi
  final areaC = TextEditingController();
  final provinceC = TextEditingController();
  final cityC = TextEditingController();
  final districtC = TextEditingController();
  final villageC = TextEditingController();
  var selectedRegion = Rxn<RegionModel>();
  var isSearchingRegion = false.obs;
  var regionSearchQuery = ''.obs;
  var regionSearchResults = <RegionModel>[].obs;
  final List<RegionModel> _allRegionsMaster = [];
  final isDetailAreaVisible = false.obs;
  final addressC = TextEditingController();
  final postalCodeC = TextEditingController();

  // Detail bangunan
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
    "Modern Market",
    "Semi Modern Market",
    "Supermarket",
    "Minimarket",
    "Reseller",
    "Kemitraan",
  ];

  // Tradisional, Ponpes, Koperasi, Modern Market
  final distributionTypeList = ["Agen", "Grosir", "Grosir + Retail", "Retail"];

  // Tradisional, B2G, Ponpes, Party, Koperasi, Modern Market
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

  final locationTypeList = ["Jalan Utaama", "Pasar", "Pusat Perbelanjaan"];
  final shopStatusList = ["Tetap", "Menyewa"];
  final buildingSizeList = ["10 - 20 m2", "< 10 m2>", "> 20 m2", "Gift"];
  final buildingTypeList = ["1 Lantai", "2 Lantai", "> 2 Lantai"];

  final uplineList = ["Distributor Pusat", "Sub-Distributor", "Agen"];
  final brandList = ["Brand A", "Brand B", "Multi Brand"];
  final promoList = ["Banner", "Rak Display", "Poster", "Tidak Ada"];
  final onlineShopList = ["Shopee", "Tokopedia", "Tiktok Shop", "Tidak Ada"];
  final dayList = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat"];

  @override
  void onInit() {
    super.onInit();
    dateC.text = DateFormat('yyyy-MM-dd').format(DateTime.now());

    _generateDummyRegions();

    regionSearchResults.assignAll(_allRegionsMaster);

    debounce(
      regionSearchQuery,
      (query) => searchRegion(query),
      time: const Duration(milliseconds: 500),
    );
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

  void addShopPhoto() {
    if (shopPhotoPaths.length >= 5) {
      Get.snackbar(
        "Batas Tercapai",
        "Maksimal 5 foto lokasi yang diperbolehkan.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    Get.bottomSheet(
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text('Ambil Foto Baru'),
              onTap: () async {
                Get.back();
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 50,
                );
                if (image != null) {
                  shopPhotoPaths.add(image.path);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: const Text('Pilih dari Galeri'),
              onTap: () async {
                Get.back();
                int remainingSlots = 5 - shopPhotoPaths.length;

                final List<XFile> images = await _picker.pickMultiImage(
                  imageQuality: 50,
                );

                if (images.isNotEmpty) {
                  final imagesToAdd = images
                      .take(remainingSlots)
                      .map((e) => e.path)
                      .toList();

                  shopPhotoPaths.addAll(imagesToAdd);

                  if (images.length > remainingSlots) {
                    Get.snackbar(
                      "Info",
                      "Hanya ${imagesToAdd.length} foto yang ditambahkan karena batas maksimal 5.",
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void removeShopPhoto(int index) {
    shopPhotoPaths.removeAt(index);
  }

  void showImagePicker(Rxn<String> targetVariable) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text('Ambil dari Kamera'),
              onTap: () {
                Get.back();
                _pickImage(targetVariable, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: const Text('Ambil dari Galeri'),
              onTap: () {
                Get.back();
                _pickImage(targetVariable, ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(
    Rxn<String> targetVariable,
    ImageSource source,
  ) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 50,
      );

      if (image != null) {
        targetVariable.value = image.path;
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal mengambil gambar: $e");
    }
  }

  void _generateDummyRegions() {
    _allRegionsMaster.addAll([
      RegionModel(
        kelurahan: "DAHANREJO",
        kecamatan: "KEBOMAS",
        kota: "KABUPATEN GRESIK",
        provinsi: "JAWA TIMUR",
        kodePos: "61124",
      ),
      RegionModel(
        kelurahan: "GENDING",
        kecamatan: "KEBOMAS",
        kota: "KABUPATEN GRESIK",
        provinsi: "JAWA TIMUR",
        kodePos: "61123",
      ),
      RegionModel(
        kelurahan: "GIRI",
        kecamatan: "KEBOMAS",
        kota: "KABUPATEN GRESIK",
        provinsi: "JAWA TIMUR",
        kodePos: "61124",
      ),
      RegionModel(
        kelurahan: "GULOMANTUNG",
        kecamatan: "KEBOMAS",
        kota: "KABUPATEN GRESIK",
        provinsi: "JAWA TIMUR",
        kodePos: "61124",
      ),
      RegionModel(
        kelurahan: "INDRO",
        kecamatan: "KEBOMAS",
        kota: "KABUPATEN GRESIK",
        provinsi: "JAWA TIMUR",
        kodePos: "61124",
      ),
      RegionModel(
        kelurahan: "KARANGKERING",
        kecamatan: "KEBOMAS",
        kota: "KABUPATEN GRESIK",
        provinsi: "JAWA TIMUR",
        kodePos: "61124",
      ),
      RegionModel(
        kelurahan: "KAWISANYAR",
        kecamatan: "KEBOMAS",
        kota: "KABUPATEN GRESIK",
        provinsi: "JAWA TIMUR",
        kodePos: "61124",
      ),
      RegionModel(
        kelurahan: "KEMBANGAN",
        kecamatan: "KEBOMAS",
        kota: "KABUPATEN GRESIK",
        provinsi: "JAWA TIMUR",
        kodePos: "61124",
      ),
    ]);
  }

  void searchRegion(String query) async {
    if (query.isEmpty) {
      isSearchingRegion.value = false;
      regionSearchResults.assignAll(_allRegionsMaster);
      return;
    }

    isSearchingRegion.value = true;

    // Simulasi delay sedikit (opsional, bisa dihapus jika data lokal)
    await Future.delayed(const Duration(milliseconds: 300));

    // Filter dari Master Data
    final results = _allRegionsMaster
        .where(
          (element) =>
              element.kelurahan.toLowerCase().contains(query.toLowerCase()) ||
              element.kecamatan.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    regionSearchResults.assignAll(results);
    isSearchingRegion.value = false;
  }

  void selectRegion(RegionModel region) {
    selectedRegion.value = region;

    areaC.text =
        "${region.kelurahan}, ${region.kecamatan}, ${region.kota}, ${region.provinsi}, ${region.kodePos}";

    provinceC.text = region.provinsi;
    cityC.text = region.kota;
    districtC.text = region.kecamatan;
    villageC.text = region.kelurahan;
    postalCodeC.text = region.kodePos;

    Get.back();
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
    telephoneC.dispose();
    npwpC.dispose();
    plafonC.dispose();
    areaC.dispose();
    provinceC.dispose();
    cityC.dispose();
    districtC.dispose();
    villageC.dispose();
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
