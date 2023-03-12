import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/controller.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);

  final screensIndexController =
      Get.put<ScreensIndexController>(ScreensIndexController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.deepPurple,
      width: 700,
      child: ListView(
        children: [
          // DrawerHeader(
          //   child: Image.asset("assets/images/logo.png"),
          // ),
          const DrawerHeader(
            child: Center(
              child: Text(
                "UOC",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          DrawerListTile(
            title: "Dashboards",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              screensIndexController.updateScreenCurrentIndex(0);
              // Get.back();
            },
          ),
          DrawerListTile(
            title: "New Registrations",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              screensIndexController.updateScreenCurrentIndex(1);
              // Get.back();
            },
          ),
          DrawerListTile(
            title: "All Verified Users",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              screensIndexController.updateScreenCurrentIndex(2);
              // Get.back();
            },
          ),
          DrawerListTile(
            title: "Roles",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              screensIndexController.updateScreenCurrentIndex(3);
            },
          ),
          DrawerListTile(
            title: "Assigned Courses",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              screensIndexController.updateScreenCurrentIndex(4);
            },
          ),
          DrawerListTile(
            title: "Assign Course",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              screensIndexController.updateScreenCurrentIndex(5);
              //
            },
          ),
          DrawerListTile(
            title: "Start Enrollment",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              screensIndexController.updateScreenCurrentIndex(6);
            },
          ),
          // DrawerListTile(
          //   title: "View All Course",
          //   svgSrc: "assets/icons/menu_store.svg",
          //   press: () {
          //     screensIndexController.updateScreenCurrentIndex(6);
          //   //
          //   },
          // ),
          DrawerListTile(
            title: "Logout",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              if (Get.find<UserAuthController>().isUserLoggedIn()) {
                Get.find<UserAuthController>().logout();
                Get.toNamed("/");
              }
              //
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Container(
        color: Colors.white,
        height: 16,
        child: const Icon(
          Icons.draw_rounded,
          size: 22,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontFamily: 'Poppins', fontSize: 16),
      ),
    );
  }
}
