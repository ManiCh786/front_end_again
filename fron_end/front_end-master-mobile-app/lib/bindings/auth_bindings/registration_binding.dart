

import '/controllers/auth_controllers/auth_controllers.dart';
import 'package:get/get.dart';

import '../../data/repository/repository.dart';

class RegistrationBinding implements Bindings {
  @override
  void dependencies() {
    // repos
    Get.lazyPut(() => RegistrationRepository(apiClient: Get.find()));

    //controllers
    Get.lazyPut(() => RegistrationController(regRepo: Get.find()));

  }
}