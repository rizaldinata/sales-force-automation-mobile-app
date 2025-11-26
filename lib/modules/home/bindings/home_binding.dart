import 'package:get/get.dart';
import 'package:salesforce_app/modules/home/controllers/home_controller.dart';
import 'package:salesforce_app/modules/home/controllers/profile_controller.dart';
import 'package:salesforce_app/modules/home/controllers/visit_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(), permanent: true);
    Get.lazyPut<VisitController>(() => VisitController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}
