import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/controller.dart';
import '../../screens.dart';
import '../reports/tab_view_for_reports.dart';
import 'Objectives/tab_views.dart';
import 'lectures/lectures_tabview.dart';

class ObjectivesMenu extends StatelessWidget {
  ObjectivesMenu({Key? key}) : super(key: key);
  final designController =
      Get.put<ObjectiveScreenIndexController>(ObjectiveScreenIndexController());
  final courseController =
      Get.put<CoursesController>(CoursesController(courseRepo: Get.find()));
  // final  courses = Get.arguments['courses'];
  final List<Widget> _screens = [
    TabViewForObjectives(),
    TabViewForLectures(),
    TabViewForReports(),
  ];
  @override
  Widget build(BuildContext context) {
    return GetX<ObjectiveScreenIndexController>(
      init: ObjectiveScreenIndexController(),
      initState: (_) {},
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.deepPurple,
            elevation: 0.0,
            centerTitle: true,
            title: const Text(
              'Course Desc & Scheduling',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            actions: [
              TextButton(
                child: const Text(
                  "Logout",
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Poppins', fontSize: 20),
                ),
                onPressed: () {
                  if (Get.find<UserAuthController>().isUserLoggedIn()) {
                    Get.find<UserAuthController>().logout();
                    Get.toNamed("/");
                  }
                },
              ),
            ],
          ),
          bottomNavigationBar: MediaQuery.of(context).size.width < 640
              ? BottomNavigationBar(
                  currentIndex: designController.screenIndex.value,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.indigoAccent,
                  onTap: (int index) {
                    designController.updateScreenCurrentIndex(index);
                  },
                  //  bottom tab items
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.feed), label: 'Feed'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite), label: 'Favourites'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Settings'),
                  ],
                )
              : null,
          body: Row(children: [
            if (MediaQuery.of(context).size.width >= 640)
              NavigationRail(
                minWidth: 90,
                backgroundColor: Colors.deepPurple,
                onDestinationSelected: (int index) {
                  designController.updateScreenCurrentIndex(index);
                },
                selectedIndex: designController.screenIndex.value,
                destinations: const [
                  NavigationRailDestination(
                      icon: Icon(Icons.import_contacts, size: 22),
                      label: Text(
                        "Course Description",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                      )),
                  NavigationRailDestination(
                      icon: Icon(Icons.subject, size: 22),
                      label: Text(
                        "Semester Schedule",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                      )),
                  NavigationRailDestination(
                      icon: Icon(Icons.subject, size: 22),
                      label: Text(
                        "Reports",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                      ))
                ],
                unselectedIconTheme: const IconThemeData(color: Colors.black),
                selectedIconTheme: const IconThemeData(color: Colors.white),
                selectedLabelTextStyle: const TextStyle(color: Colors.white),
                unselectedLabelTextStyle: const TextStyle(color: Colors.black),
                labelType: NavigationRailLabelType.all,
              ),
            Expanded(child: _screens[designController.screenIndex.value])
          ]),
        );
      },
    );
  }
}
