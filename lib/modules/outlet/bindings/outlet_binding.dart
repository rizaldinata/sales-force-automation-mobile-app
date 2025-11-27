import 'package:get/get.dart';
import 'package:salesforce_app/modules/outlet/controllers/outlet_controller.dart';

class OutletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutletController>(() => OutletController());
  }
}
