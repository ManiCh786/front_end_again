import 'package:get/get.dart';

class ObjectiveScreenIndexController extends GetxController{
  var screenIndex = 0.obs;

  updateScreenCurrentIndex(int index) {
    screenIndex.value = index;
  }
}