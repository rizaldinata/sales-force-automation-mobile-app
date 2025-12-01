import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesforce_app/app/data/models/outlet_model.dart';
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

  final List<OutletModel> _allOutletsSource = [];

  final displayedOutlets = <OutletModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _generateDummyData();
    _loadInitialData();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !isLoadingMore.value &&
          hasMore.value) {
        loadMoreOutlets();
      }
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

  Future<void> pickMonth() async {
    final DateTime? picked = await Get.dialog(
      MonthPickerDialog(initialDate: selectedMonth.value),
    );

    if (picked != null) {
      selectedMonth.value = picked;
    }
  }

  void _generateDummyData() {
    for (int i = 1; i <= 45; i++) {
      _allOutletsSource.add(
        OutletModel(
          id: "OUT-${i.toString().padLeft(3, '0')}",
          name: "Outlet Sejahtera #$i",
          type: i % 2 == 0 ? "Online" : "Offline",
          address: "Jl. Raya Dummy No. $i, Kota Simulasi",
          isVerified: i % 3 == 0,
        ),
      );
    }
  }

  void _loadInitialData() {
    displayedOutlets.assignAll(_allOutletsSource.take(_limit));
    if (_allOutletsSource.length <= _limit) {
      hasMore.value = false;
    }
  }

  Future<void> loadMoreOutlets() async {
    if (isLoadingMore.value || !hasMore.value) return;

    isLoadingMore.value = true;

    await Future.delayed(const Duration(milliseconds: 1500));

    int currentCount = displayedOutlets.length;
    List<OutletModel> nextData = _allOutletsSource
        .skip(currentCount)
        .take(_limit)
        .toList();

    if (nextData.isNotEmpty) {
      displayedOutlets.addAll(nextData);
    } else {
      hasMore.value = false;
    }

    if (displayedOutlets.length >= _allOutletsSource.length) {
      hasMore.value = false;
    }

    isLoadingMore.value = false;
  }
}
