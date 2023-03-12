import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/controller.dart';

class CheckAuth extends StatelessWidget {
  CheckAuth({Key? key}) : super(key: key);
  final userAuthController = Get.find<UserAuthController>();
  checkIfUserLogin() {
    if (userAuthController.isUserLoggedIn()) {
      String accountType = userAuthController.userAccountType();

      if (accountType == "admin") {
        Get.offAllNamed("/adminDashboard");
      } else if (accountType == "faculty") {
        Get.offAllNamed("/faculty-dashboard");
      } else if (accountType == "student") {
        Get.offAllNamed("/studentDashboard");
      } else if (accountType == "hod") {
        Get.offAllNamed("/HOD_Dashboard");
      } else {
        Get.offAllNamed("/authMenu");
      }
    } else {
      Get.offAllNamed("/authMenu");
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      checkIfUserLogin();
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/uoctransparent.png',
              height: 151,
              width: 150,
            ),
          ],
        ),
      ),
    );
  }
}
