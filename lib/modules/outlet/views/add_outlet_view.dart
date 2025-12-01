// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesforce_app/app/ui/theme/app_theme.dart';
import 'package:salesforce_app/app/ui/theme/app_constants.dart';
import 'package:salesforce_app/app/ui/widgets/primary_button.dart';
import 'package:salesforce_app/app/ui/widgets/primary_text_form_field.dart';
import 'package:salesforce_app/app/ui/widgets/custom_dropdown.dart';
import 'package:salesforce_app/modules/outlet/controllers/add_outlet_controller.dart';

class AddOutletView extends StatelessWidget {
  const AddOutletView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddOutletController());

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Tambah Outlet",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black87,
            size: 20.sp,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          // Header Stepper (Putih)
          _buildStepperHeader(controller),

          // Content Form
          Expanded(
            child: Obx(() {
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 100.h),
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 24.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      AppRadius.xl,
                    ), // Radius 24
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      if (controller.currentStep.value == 0)
                        _buildStep1(controller, context),
                      if (controller.currentStep.value == 1)
                        _buildStep2(controller),
                      if (controller.currentStep.value == 2)
                        _buildStep3(controller),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(controller),
    );
  }

  // --- 1. HEADER STEPPER (Updated Style) ---
  Widget _buildStepperHeader(AddOutletController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      child: Obx(
        () => Row(
          children: [
            _stepIcon(1, "Identitas", controller.currentStep.value >= 0),
            _connector(controller.currentStep.value >= 1),
            _stepIcon(2, "Fisik", controller.currentStep.value >= 1),
            _connector(controller.currentStep.value >= 2),
            _stepIcon(3, "Bisnis", controller.currentStep.value >= 2),
          ],
        ),
      ),
    );
  }

  Widget _stepIcon(int step, String label, bool isActive) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : Colors.grey[100],
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? primaryColor : Colors.grey[300]!,
              width: 1.5,
            ),
          ),
          child: Center(
            child: isActive
                ? Icon(Icons.check, color: Colors.white, size: 18.sp)
                : Text(
                    "$step",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: isActive ? primaryColor : Colors.grey[400],
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _connector(bool isActive) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h, left: 4.w, right: 4.w),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 2.h,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : Colors.grey[200],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildStep1(AddOutletController controller, BuildContext context) {
    return Form(
      key: controller.formKeyStep1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _inputLabel("Tanggal Registrasi"),
          PrimaryTextFormField(
            controller: controller.dateC,
            hintText: "-",
            readOnly: true,
            onTap: () => controller.chooseDate(context),
            suffixIcon: Icon(
              Icons.calendar_month,
              color: primaryColor,
              size: 20.sp,
            ),
          ),
          SizedBox(height: 24.h),
          _sectionDivider("Jenis dan Tipe Outlet"),

          CustomDropdown(
            label: "Jenis & Tipe Outlet",
            hint: "Pilih Jenis",
            items: controller.typeList,
            selectedValue: controller.typeC,
            onChanged: (val) {
              controller.typeC.value = val;
              controller.distributionTypeC.value = null;
              controller.categoryC.value = null;
              controller.purchaseTypeC.value = null;
              controller.employeeCountC.value = null;
              controller.studentCountC.value = null;
              controller.coopMemberCountC.value = null;
            },
            icon: Icons.store_mall_directory,
          ),

          if (controller.typeC.value == "Tradisional" ||
              controller.typeC.value == "Modern Market" ||
              controller.typeC.value == "Semi Modern Market" ||
              controller.typeC.value == "Supermarket" ||
              controller.typeC.value == "Minimarket" ||
              controller.typeC.value == "Reseller" ||
              controller.typeC.value == "Kemitraan") ...[
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Tipe Distribusi",
              items: controller.distributionTypeList,
              selectedValue: controller.distributionTypeC,
              onChanged: (v) => controller.distributionTypeC.value = v,
              hint: "Pilih Tipe",
              icon: Icons.local_shipping_outlined,
            ),
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Kategori",
              items: controller.categoryList,
              selectedValue: controller.categoryC,
              onChanged: (v) => controller.categoryC.value = v,
              hint: "Pilih Kategori",
              icon: Icons.category_outlined,
            ),
          ] else if (controller.typeC.value == "Institusi - B2B") ...[
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Tipe Pembelian",
              items: controller.purchaseTypeList,
              selectedValue: controller.purchaseTypeC,
              onChanged: (v) => controller.purchaseTypeC.value = v,
              hint: "Pilih Tipe",
              icon: Icons.shopping_cart_checkout,
            ),
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Jumlah Karyawan",
              items: controller.employeeCountList,
              selectedValue: controller.employeeCountC,
              onChanged: (v) => controller.employeeCountC.value = v,
              hint: "Pilih Range",
              icon: Icons.people_outline,
            ),
          ] else if (controller.typeC.value == "Institusi - B2G") ...[
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Kategori",
              items: controller.categoryList,
              selectedValue: controller.categoryC,
              onChanged: (v) => controller.categoryC.value = v,
              hint: "Pilih Kategori",
              icon: Icons.category_outlined,
            ),
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Tipe Pembelian",
              items: controller.purchaseTypeList,
              selectedValue: controller.purchaseTypeC,
              onChanged: (v) => controller.purchaseTypeC.value = v,
              hint: "Pilih Tipe",
              icon: Icons.shopping_cart_checkout,
            ),
          ] else if (controller.typeC.value == "Institusi - Ponpes") ...[
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Tipe Distribusi",
              items: controller.distributionTypeList,
              selectedValue: controller.distributionTypeC,
              onChanged: (v) => controller.distributionTypeC.value = v,
              hint: "Pilih Tipe",
              icon: Icons.local_shipping_outlined,
            ),
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Kategori",
              items: controller.categoryList,
              selectedValue: controller.categoryC,
              onChanged: (v) => controller.categoryC.value = v,
              hint: "Pilih Kategori",
              icon: Icons.category_outlined,
            ),
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Tipe Pembelian",
              items: controller.purchaseTypeList,
              selectedValue: controller.purchaseTypeC,
              onChanged: (v) => controller.purchaseTypeC.value = v,
              hint: "Pilih Tipe",
              icon: Icons.shopping_cart_checkout,
            ),
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Jumlah Santri",
              items: controller.studentCountList,
              selectedValue: controller.studentCountC,
              onChanged: (v) => controller.studentCountC.value = v,
              hint: "Pilih Range",
              icon: Icons.people_alt_outlined,
            ),
          ] else if (controller.typeC.value == "Institusi - Party") ...[
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Kategori",
              items: controller.categoryList,
              selectedValue: controller.categoryC,
              onChanged: (v) => controller.categoryC.value = v,
              hint: "Pilih Kategori",
              icon: Icons.category_outlined,
            ),
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Tipe Pembelian",
              items: controller.purchaseTypeList,
              selectedValue: controller.purchaseTypeC,
              onChanged: (v) => controller.purchaseTypeC.value = v,
              hint: "Pilih Tipe",
              icon: Icons.shopping_cart_checkout,
            ),
          ] else if (controller.typeC.value == "Institusi - Koperasi") ...[
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Tipe Distribusi",
              items: controller.distributionTypeList,
              selectedValue: controller.distributionTypeC,
              onChanged: (v) => controller.distributionTypeC.value = v,
              hint: "Pilih Tipe",
              icon: Icons.local_shipping_outlined,
            ),
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Kategori",
              items: controller.categoryList,
              selectedValue: controller.categoryC,
              onChanged: (v) => controller.categoryC.value = v,
              hint: "Pilih Kategori",
              icon: Icons.category_outlined,
            ),
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Tipe Pembelian",
              items: controller.purchaseTypeList,
              selectedValue: controller.purchaseTypeC,
              onChanged: (v) => controller.purchaseTypeC.value = v,
              hint: "Pilih Tipe",
              icon: Icons.shopping_cart_checkout,
            ),
            SizedBox(height: 16.h),
            CustomDropdown(
              label: "Jumlah Anggota",
              items: controller.coopMemberCountList,
              selectedValue: controller.coopMemberCountC,
              onChanged: (v) => controller.coopMemberCountC.value = v,
              hint: "Pilih Range",
              icon: Icons.groups_outlined,
            ),
          ],

          SizedBox(height: 24.h),
          _sectionDivider("Informasi Dasar"),

          _inputLabel("Nama Outlet"),
          PrimaryTextFormField(
            controller: controller.nameC,
            hintText: "Contoh: Toko Berkah",
            validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
          ),
          SizedBox(height: 16.h),

          _inputLabel("Nama Pengelola"),
          PrimaryTextFormField(
            controller: controller.managerC,
            hintText: "Nama Lengkap",
          ),
          SizedBox(height: 16.h),

          _inputLabel("No. HP Pengelola"),
          PrimaryTextFormField(
            controller: controller.managerPhoneC,
            hintText: "08xxxxxxxx",
            keyboardType: TextInputType.phone,
          ),

          SizedBox(height: 24.h),
          _sectionDivider("Pemilik & Legalitas"),

          _inputLabel("Nama Pemilik"),
          PrimaryTextFormField(
            controller: controller.ownerC,
            hintText: "Nama Sesuai KTP",
            validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
          ),
          SizedBox(height: 16.h),

          _inputLabel("No. HP Pemilik"),
          PrimaryTextFormField(
            controller: controller.ownerPhoneC,
            hintText: "08xxxxxxxx",
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16.h),

          _inputLabel("No. KTP (NIK)"),
          PrimaryTextFormField(
            controller: controller.ktpC,
            hintText: "16 Digit NIK",
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16.h),

          _inputLabel("NPWP"),
          PrimaryTextFormField(
            controller: controller.npwpC,
            hintText: "Nomor NPWP",
          ),
          SizedBox(height: 16.h),

          _inputLabel("Plafon Kredit (Rp)"),
          PrimaryTextFormField(
            controller: controller.plafonC,
            hintText: "0",
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildStep2(AddOutletController controller) {
    return Form(
      key: controller.formKeyStep2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dokumentasi",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),

          // Style Foto
          InkWell(
            onTap: () {
              /* Logic Foto */
            },
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: Container(
              height: 140.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(AppRadius.lg),
                // PERBAIKAN DI SINI:
                // Hapus 'style: BorderStyle.dashed' ganti dengan solid atau hapus style-nya (default solid)
                border: Border.all(color: Colors.grey[300]!, width: 1.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: mintGrean.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: primaryColor,
                      size: 28.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Ambil Foto Depan Toko",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 28.h),
          _sectionDivider("Alamat & Lokasi"),

          // ... kode sisanya sama ...
          _inputLabel("Area / Wilayah"),
          PrimaryTextFormField(
            controller: controller.areaC,
            hintText: "Cari Area...",
            suffixIcon: Icon(Icons.search, color: Colors.grey[400]),
          ),

          Obx(
            () => Transform.translate(
              offset: Offset(-12.w, 0),
              child: CheckboxListTile(
                title: Text(
                  "Tampilkan Detail Area",
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
                ),
                value: controller.isDetailAreaVisible.value,
                onChanged: (val) => controller.isDetailAreaVisible.value = val!,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: primaryColor,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          _inputLabel("Alamat Lengkap"),
          PrimaryTextFormField(
            controller: controller.addressC,
            hintText: "Nama Jalan, RT/RW...",
            maxLines: 3,
            validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
          ),
          SizedBox(height: 16.h),

          _inputLabel("Kode POS"),
          PrimaryTextFormField(
            controller: controller.postalCodeC,
            hintText: "xxxxx",
            keyboardType: TextInputType.number,
          ),

          SizedBox(height: 28.h),
          _sectionDivider("Detail Bangunan"),

          CustomDropdown(
            label: "Lokasi Bangunan",
            hint: "Pilih",
            items: controller.locationTypeList,
            selectedValue: controller.locationTypeC,
            onChanged: (v) => controller.locationTypeC.value = v,
            icon: Icons.map,
          ),
          SizedBox(height: 16.h),

          CustomDropdown(
            label: "Status Kepemilikan",
            hint: "Pilih",
            items: controller.shopStatusList,
            selectedValue: controller.shopStatusC,
            onChanged: (v) => controller.shopStatusC.value = v,
            icon: Icons.home_work,
          ),
          SizedBox(height: 16.h),

          CustomDropdown(
            label: "Luas Bangunan",
            hint: "Pilih",
            items: controller.buildingSizeList,
            selectedValue: controller.buildingSizeC,
            onChanged: (v) => controller.buildingSizeC.value = v,
            icon: Icons.straighten,
          ),
          SizedBox(height: 16.h),

          CustomDropdown(
            label: "Jenis Bangunan",
            hint: "Pilih",
            items: controller.buildingTypeList,
            selectedValue: controller.buildingTypeC,
            onChanged: (v) => controller.buildingTypeC.value = v,
            icon: Icons.foundation,
          ),
        ],
      ),
    );
  }

  // --- 4. STEP 3: BISNIS ---
  Widget _buildStep3(AddOutletController controller) {
    return Form(
      key: controller.formKeyStep3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionDivider("Operasional"),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Obx(
              () => CheckboxListTile(
                title: Text(
                  "Memiliki Tim Motoris / Canvasing",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: controller.hasMotorisTeam.value,
                onChanged: (val) => controller.hasMotorisTeam.value = val!,
                activeColor: primaryColor,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          ),

          SizedBox(height: 20.h),
          CustomDropdown(
            label: "Supplier / Upline",
            hint: "Pilih Distributor",
            items: controller.uplineList,
            selectedValue: controller.uplineC,
            onChanged: (v) => controller.uplineC.value = v,
            icon: Icons.local_shipping,
          ),

          SizedBox(height: 16.h),
          CustomDropdown(
            label: "Produk Brands",
            hint: "Pilih Brand Dominan",
            items: controller.brandList,
            selectedValue: controller.brandC,
            onChanged: (v) => controller.brandC.value = v,
            icon: Icons.branding_watermark,
          ),

          SizedBox(height: 16.h),
          CustomDropdown(
            label: "Material Promo",
            hint: "Pilih Material",
            items: controller.promoList,
            selectedValue: controller.promoMaterialC,
            onChanged: (v) => controller.promoMaterialC.value = v,
            icon: Icons.ad_units,
          ),

          SizedBox(height: 16.h),
          CustomDropdown(
            label: "Akun Online Shop",
            hint: "Pilih Platform",
            items: controller.onlineShopList,
            selectedValue: controller.onlineShopC,
            onChanged: (v) => controller.onlineShopC.value = v,
            icon: Icons.shopping_bag,
          ),

          SizedBox(height: 28.h),
          _sectionDivider("Rencana Kunjungan"),
          CustomDropdown(
            label: "Jadwal Hari Kunjungan",
            hint: "Pilih Hari",
            items: controller.dayList,
            selectedValue: controller.visitDayC,
            onChanged: (v) => controller.visitDayC.value = v,
            icon: Icons.event_available,
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPERS ---

  Widget _buildBottomNav(AddOutletController controller) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50.h,
              child: OutlinedButton(
                onPressed: controller.prevStep,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  foregroundColor: primaryColor,
                ),
                child: const Text("Kembali"),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Obx(
              () => PrimaryButton(
                text: controller.currentStep.value == 2
                    ? "SIMPAN DATA"
                    : "LANJUT",
                onPressed: controller.nextStep,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _sectionDivider(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.w,
              height: 18.h,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(child: Divider(color: Colors.grey[200], thickness: 1)),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
