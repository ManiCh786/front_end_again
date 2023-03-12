import 'package:shared_preferences/shared_preferences.dart';

import '/controllers/auth_controllers/auth_controllers.dart';
import '/data/repository/auth_repository/auth_repository.dart';
import 'package:get/get.dart';

class UserAuthBinding implements Bindings{
  @override
  void dependencies() async{
    // TODO: implement dependencies
    // User Auth Controller
    Get.lazyPut(() => UserAuthController(userAuthRepo: Get.find()));
    // User Auth Repo
    Get.lazyPut(() => UserAuthRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  }

}