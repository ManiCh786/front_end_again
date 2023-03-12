import 'package:get/get.dart';

import '../controllers/controller.dart';
import '../data/repository/repository.dart';

class RolesBinding implements Bindings {
  @override
  void dependencies() {
    // repos
    Get.lazyPut(() => RolesRepo(apiClient: Get.find()));

    //controllers
    Get.lazyPut(() => RolesController(rolesRepo: Get.find()),
    );

  }
}