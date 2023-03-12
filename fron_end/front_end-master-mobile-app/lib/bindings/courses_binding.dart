import 'package:get/get.dart';

import '../controllers/controller.dart';
import '../data/repository/repository.dart';

class CourseBinding implements Bindings {
  @override
  void dependencies() {
    // repos
    Get.lazyPut(() => CoursesRepo(apiClient: Get.find()));
    // //controllers
    // Get.lazyPut(() => CoursesController( courseRepo: Get.find()),
    // );
    Get.put(CoursesController(courseRepo: Get.find()), permanent: true);
  }
}
