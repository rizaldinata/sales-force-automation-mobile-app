import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesforce_app/app/data/models/outlet_model.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/app/ui/widgets/month_picker_dialog.dart';
import 'package:salesforce_app/modules/outlet/views/widgets/outlet_filter_sheet.dart';

class OutletController extends GetxController {
  final searchC = TextEditingController();
  final scrollController = ScrollController();

  var filterDateMode = 'period'.obs;

  var selectedMonth = DateTime.now().obs;

  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();

  final statusList = ["Semua", "Terverifikasi", "Belum Verif"];
  var selectedStatus = "Semua".obs;

  final int _limit = 10;
  var isLoadingMore = false.obs;
  var hasMore = true.obs;
  var isFiltering = false.obs;

  final List<OutletModel> _allMasterData = [];

  final List<OutletModel> _filteredData = [];

  final displayedOutlets = <OutletModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _generateDummyData();
    _applyFiltersAndSearch();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoadingMore.value &&
          hasMore.value) {
        loadMoreOutlets();
      }
    });

    debounce(
      RxString(''),
      (_) => _applyFiltersAndSearch(),
      time: const Duration(milliseconds: 500),
    );
    searchC.addListener(() {
      if (searchC.text != '') _applyFiltersAndSearch();
      if (searchC.text.isEmpty) _applyFiltersAndSearch();
    });
  }

  @override
  void onClose() {
    searchC.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void openFilter() {
    Get.bottomSheet(
      const OutletFilterSheet(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  void applyFilter() {
    Get.back();
    _applyFiltersAndSearch();

    Get.snackbar(
      "Filter Diterapkan",
      "Ditemukan ${_filteredData.length} outlet",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void resetFilter() {
    filterDateMode.value = 'period';
    selectedMonth.value = DateTime.now();
    startDate.value = null;
    endDate.value = null;
    selectedStatus.value = "Semua";

    Get.rawSnackbar(
      message: "Filter direset ke default",
      duration: const Duration(seconds: 1),
    );
  }

  Future<void> pickMonth() async {
    final DateTime? picked = await Get.dialog(
      MonthPickerDialog(initialDate: selectedMonth.value),
    );
    if (picked != null) {
      selectedMonth.value = picked;
    }
  }

  Future<void> pickDate(BuildContext context, {required bool isStart}) async {
    DateTime initial = DateTime.now();
    if (isStart && startDate.value != null) {
      initial = startDate.value!;
    } else if (!isStart && endDate.value != null) {
      initial = endDate.value!;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: primaryColor),
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
      if (isStart) {
        startDate.value = picked;
        if (endDate.value != null && startDate.value!.isAfter(endDate.value!)) {
          endDate.value = null;
        }
      } else {
        if (startDate.value != null && picked.isBefore(startDate.value!)) {
          Get.snackbar(
            "Peringatan",
            "Tanggal sampai tidak boleh kurang dari tanggal mulai",
          );
          return;
        }
        endDate.value = picked;
      }
    }
  }

  void addDummyOutlet() {
    final newOutlet = OutletModel(
      id: "NEW-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
      name: "Outlet Baru ${_allMasterData.length + 1}",
      type: "Offline",
      address: "Jl. Baru Ditambah No. 1",
      isVerified: false,
      createdAt: DateTime.now(),
    );

    _allMasterData.insert(0, newOutlet);
    _applyFiltersAndSearch();
    Get.snackbar("Berhasil", "Outlet baru berhasil ditambahkan");
  }

  void _generateDummyData() {
    final now = DateTime.now();
    for (int i = 1; i <= 1000; i++) {
      final randomDays = (i * 123) % 60;
      _allMasterData.add(
        OutletModel(
          id: "OUT-${i.toString().padLeft(3, '0')}",
          name: "Outlet Sejahtera #$i",
          type: i % 2 == 0 ? "Online" : "Offline",
          address: "Jl. Raya Dummy No. $i, Kota Simulasi",
          isVerified: i % 3 == 0,
          createdAt: now.subtract(Duration(days: randomDays)),
        ),
      );
    }
  }

  void _applyFiltersAndSearch() {
    isFiltering.value = true;
    hasMore.value = true;

    // Reset data hasil filter
    _filteredData.clear();
    List<OutletModel> temp = List.from(_allMasterData);

    // Filter search text
    if (searchC.text.isNotEmpty) {
      final keyword = searchC.text.toLowerCase();
      temp = temp
          .where(
            (outlet) =>
                outlet.name.toLowerCase().contains(keyword) ||
                outlet.id.toLowerCase().contains(keyword),
          )
          .toList();
    }

    // Filter status
    if (selectedStatus.value != "Semua") {
      bool isVerif = selectedStatus.value == "Terverifikasi";
      temp = temp.where((outlet) => outlet.isVerified == isVerif).toList();
    }

    // Filter tanggal
    if (filterDateMode.value == 'period') {
      temp = temp
          .where(
            (outlet) =>
                outlet.createdAt.month == selectedMonth.value.month &&
                outlet.createdAt.year == selectedMonth.value.year,
          )
          .toList();
    } else if (filterDateMode.value == 'range' &&
        startDate.value != null &&
        endDate.value != null) {
      final start = DateTime(
        startDate.value!.year,
        startDate.value!.month,
        startDate.value!.day,
      );
      final end = DateTime(
        endDate.value!.year,
        endDate.value!.month,
        endDate.value!.day,
        23,
        59,
        59,
      );

      temp = temp
          .where(
            (outlet) =>
                outlet.createdAt.isAfter(
                  start.subtract(const Duration(seconds: 1)),
                ) &&
                outlet.createdAt.isBefore(end.add(const Duration(seconds: 1))),
          )
          .toList();
    }

    _filteredData.assignAll(temp);

    displayedOutlets.clear();
    _loadNextPage();

    isFiltering.value = false;
  }

  void _loadNextPage() {
    int currentCount = displayedOutlets.length;
    int remaining = _filteredData.length - currentCount;

    if (remaining <= 0) {
      hasMore.value = false;
      return;
    }

    int takeCount = remaining < _limit ? remaining : _limit;
    List<OutletModel> nextData = _filteredData
        .getRange(currentCount, currentCount + takeCount)
        .toList();

    displayedOutlets.addAll(nextData);

    if (displayedOutlets.length >= _filteredData.length) {
      hasMore.value = false;
    }
  }

  Future<void> loadMoreOutlets() async {
    if (isLoadingMore.value || !hasMore.value) return;

    isLoadingMore.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    _loadNextPage();
    isLoadingMore.value = false;
  }
}
