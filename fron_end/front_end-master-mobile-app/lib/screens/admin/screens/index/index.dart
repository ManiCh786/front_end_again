import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/design_controllers/screens_index_controller.dart';
import '../../../screens.dart';
import '../dashboard/dashboard_screen.dart';
import '../screens.dart';
import '../users/allverifiedusers.dart';
import '../users/users_screen.dart';

class Index extends StatelessWidget {
  Index({Key? key}) : super(key: key);
  final List<Widget> _screens = [
    DashboardScreen(),
    UsersScreen(),
    AllVerifiedUsers(),
    ViewRoles(),
    ViewAssignedCourses(),
    AssignCourseToInstructor(),
    StartEnrollmentScreen(),
    // ViewAllCourses(),
    // UsersScreen(),
    // Container(color:Colors.white),
    // Container(color:Colors.black),
  ];

  final screensIndexController =
      Get.put<ScreensIndexController>(ScreensIndexController());
  @override
  Widget build(BuildContext context) {
    return GetX<ScreensIndexController>(
        init: ScreensIndexController(),
        initState: (_) {},
        builder: (logic) {
          return Scaffold(
              body: _screens[screensIndexController.screenIndex.value]);
        });
  }
}
