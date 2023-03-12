import 'package:get/get.dart';

import '../../controllers/controller.dart';

class ObjectiveScreenBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ObjectiveScreenIndexController());
  }

}