import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controller.dart';

class AdminMiddleWare extends GetMiddleware {

  final userAuthController = Get.find<UserAuthController>();

  @override
  int? get priority => 1;
  bool isAuthenticated = false;
  @override
  RouteSettings? redirect(String? route) {
    if (!userAuthController.isUserLoggedIn()) {
      isAuthenticated = false;
    } else {
      var role = userAuthController.userAccountType();
      if (role != "admin") {
        isAuthenticated = false;

      }
      if (role == "admin") {
        isAuthenticated = true;
      }

  }
    if (isAuthenticated == false) {
      userAuthController.logout();
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}