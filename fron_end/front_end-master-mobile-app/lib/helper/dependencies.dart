import '../bindings/bindings.dart';
import '/data/api/api_client.dart';
import '/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/controller.dart';
import '../data/repository/repository.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.put(sharedPreferences, permanent: true);

  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  //User Controller and repo
  Get.lazyPut(() => UserAuthController(userAuthRepo: Get.find()));
  Get.lazyPut(() => RegistrationBinding());
  Get.lazyPut(() => CourseBinding());
  // Get.lazyPut(() => UserAuthRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.put(UserAuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
}
