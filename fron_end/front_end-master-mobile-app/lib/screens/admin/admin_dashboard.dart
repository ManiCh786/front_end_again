import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/controller.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        // Spacer(),
        TextButton(
          child: const Text(
            "Registered Users",
          ),
          onPressed: () {
            Get.toNamed("/adminDashboard/viewAllRegisteredUsers");
          },
        ),
        TextButton(
          child: const Text("View Roles"),
          onPressed: () {
            Get.toNamed("/adminDashboard/viewRoles");
          },
        ),
        TextButton(
          child: const Text("Add Roles"),
          onPressed: () {
            Get.toNamed("/adminDashboard/addRole");
          },
        ),
        TextButton(
          child: const Text("Profile"),
          onPressed: () {
            Get.toNamed("adminDashboard/loggedInUserInfo");
          },
        ),
        TextButton(
          child: const Text("Add Courses"),
          onPressed: () {
            Get.toNamed("adminDashboard/addCourses");
          },
        ),

        TextButton(
          child: const Text("Assign Courses"),
          onPressed: () {
            Get.toNamed("adminDashboard/assignCourse");
          },
        ),
        TextButton(
          child: const Text("View Assigned Courses"),
          onPressed: () {
            Get.toNamed("adminDashboard/assignedCourses");
          },
        ),
        TextButton(
          child: const Text("Start Enrollments"),
          onPressed: () {
            Get.toNamed("adminDashboard/assignedCourses");
          },
        ),
        Spacer(),
        TextButton(
          child: const Text("Logout"),
          onPressed: () {
            if (Get.find<UserAuthController>().isUserLoggedIn()) {
              Get.find<UserAuthController>().logout();
              Get.toNamed("/");
            }
          },
        ),
      ]),
    );
  }
}
