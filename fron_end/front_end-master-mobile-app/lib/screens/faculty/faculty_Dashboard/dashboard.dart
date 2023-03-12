import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/controller.dart';
import '../../screens.dart';
import 'courses/courses.dart';

class FacultyDashboard extends StatefulWidget {
  const FacultyDashboard({Key? key}) : super(key: key);

  @override
  State<FacultyDashboard> createState() => _FacultyDashboardState();
}

class _FacultyDashboardState extends State<FacultyDashboard> {
  final List<Widget> _screens = [
    //  Content for Courses tab
    CoursesTab(),
    //  Content for Settings tab
    LoggedInUserInfo(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.deepPurple,
            elevation: 0.0,
            centerTitle: true,
            title: const Text(
              'WELCOME TO FACULTY PANEL',
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
                      color: Colors.white, fontFamily: 'Poppins',fontSize: 20),
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
                  currentIndex: _selectedIndex,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.indigoAccent,
                  //  Call when one tab is selected
                  onTap: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
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
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(children: [
              if (MediaQuery.of(context).size.width >= 640)
                NavigationRail(
                  minWidth: 105,
                  backgroundColor: Colors.deepPurple,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  selectedIndex: _selectedIndex,
                  destinations: const [
                    NavigationRailDestination(
                        icon: Padding(
                          padding: EdgeInsets.only(top:32.0),
                          child: Icon(Icons.import_contacts, size: 23,),
                        ),
                        label: Text(
                          'Courses',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 17,
                           ),
                        )),
                    NavigationRailDestination(
                        icon: Icon(Icons.settings, size: 23,),
                        label: Text(
                          'Profile',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 17,
                            ),
                        )),
                  ],
                  labelType: NavigationRailLabelType.all,
                  unselectedIconTheme: const IconThemeData(color: Colors.black),
                  unselectedLabelTextStyle: const TextStyle(color: Colors.black),
                  selectedIconTheme: const IconThemeData(color: Colors.white),
                  selectedLabelTextStyle: const TextStyle(color: Colors.white),
                ),
              Expanded(child: _screens[_selectedIndex])
            ]),
          )),
    );
  }
}
