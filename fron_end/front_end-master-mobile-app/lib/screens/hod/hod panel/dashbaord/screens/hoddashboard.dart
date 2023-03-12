import 'package:flutter/material.dart';
import 'package:front_end/models/lectures_model.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import '../../../../../controllers/controller.dart';
import '../../../../../controllers/lecturesController.dart';
import '../widgets/sidebar_for_home.dart';
import 'coursespecification.dart/screens/coursespecification.dart';
import '../models/facultymodel.dart';
import 'facultydetail.dart';
import 'outlinetable.dart';

class HodDashboard extends StatefulWidget {
  const HodDashboard({super.key});

  @override
  State<HodDashboard> createState() => _HodDashboardState();
}

class _HodDashboardState extends State<HodDashboard> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  final lectureController = Get.find<LecturesController>();
  var year = DateTime.now().year.toString().obs;

  final userAuthController = Get.find<UserAuthController>();
  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<UserAuthController>().isUserLoggedIn();

    return Builder(
      builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return Scaffold(
          backgroundColor: Colors.grey.shade400,
          key: _key,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            title: RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: 'U O C       ',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 23,
                      wordSpacing: 3,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    )),
                TextSpan(
                    text: 'HOD Portal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    )),
              ]),
            ),
            actions: [
              GetBuilder<LecturesController>(initState: (_) {
                Future.delayed(const Duration(seconds: 1)).then((value) {
                  lectureController.getMyLecturesOutlineStream();
                });
              }, builder: (lecController) {
                // List<dynamic> list = [];
                List<dynamic> abc = [];
                List<dynamic> list = [];
                list = lecController.myLecturesOutlineObx
                    .where((e) =>
                        e.approved.toString().toLowerCase().contains("no") &&
                        e.createdAt.toString().toLowerCase().contains(year))
                    .toList()
                    .obs;
                // Set uniqueSubjects = abc.map((item) => item.subject).toSet();

                // list = abc.map((e) => e.subject).toSet().toList();

                // abc.map((e) => e.subject).toSet().toList().obs;
                return GestureDetector(
                  onTap: () {
                    Get.dialog(
                        useSafeArea: true,
                        Dialog(
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              height: 400,
                              width: 400,
                              child: Column(
                                children: [
                                  const Text(
                                    " Outlines to be approved yet ! ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: list.length.toInt(),
                                        itemBuilder: ((context, index) {
                                          return ListTile(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return OutlineTable(
                                                    courseName:
                                                        list[index].subject,
                                                    createdAt:
                                                        list[index].createdAt,
                                                    session:
                                                        list[index].session,
                                                  );
                                                },
                                              ));
                                            },
                                            title: Text(list[index]
                                                .subject
                                                .toString()
                                                .toUpperCase()),
                                            subtitle: Text(list[index]
                                                .session
                                                .toString()
                                                .toUpperCase()),
                                          );
                                        })),
                                  ),
                                ],
                              ),
                            )));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Row(
                      children: [
                        Text("${list.length.toInt()}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12)),
                        const Icon(
                          Icons.notifications,
                          size: 22,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person),
                  iconSize: 30,
                ),
              )
            ],
          ),
          drawer: HomeSideBar(controller: _controller),
          body: Row(
            children: [
              if (!isSmallScreen) HomeSideBar(controller: _controller),
              Expanded(
                  child: Center(
                      child: AnimatedBuilder(
                animation: _controller,
                builder: ((context, child) {
                  switch (_controller.selectedIndex) {
                    case 0:
                      _key.currentState?.closeDrawer();
                      return GetBuilder<UserAuthController>(initState: (_) {
                        if (userLoggedIn) {
                          Future.delayed(Duration.zero).then(
                            (value) => Get.find<UserAuthController>()
                                .getLoggedInUserInfo(),
                          );
                        } else {
                          Get.offAllNamed("authMenu");
                        }
                      }, builder: (controller) {
                        return controller.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Center(
                                    child: Column(
                                  children: [
                                    userDetailsMethod(context, controller),
                                    // Profile Section end here
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                          top: const BorderSide(
                                            color: Colors.deepPurple,
                                            width: 2.0,
                                          ),
                                          left: BorderSide(
                                            color: Colors.grey.shade400,
                                            width: 2,
                                          ),
                                          right: BorderSide(
                                            color: Colors.grey.shade400,
                                            width: 2,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.grey.shade400,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      // color: Colors.white,
                                      child: Column(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 14.0),
                                          child: Row(
                                            children: const [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                'Faculty Members',
                                                style: TextStyle(
                                                    color: Colors.deepPurple,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 7),
                                          child: GetBuilder<UserAuthController>(
                                              initState: (_) {
                                            Future.delayed(
                                                    const Duration(seconds: 0))
                                                .then((value) {
                                              userAuthController
                                                  .getAllFacultyMembers();
                                            });
                                          }, builder: (stController) {
                                            return controller.isLoading
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                : userAuthController
                                                        .allFacultyMembers
                                                        .isEmpty
                                                    ? Container(
                                                        child: const Center(
                                                          child: Text(
                                                              "Nothing to Show here"),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 400,
                                                        child: ListView.builder(
                                                          itemCount:
                                                              userAuthController
                                                                  .allFacultyMembers
                                                                  .length,
                                                          itemBuilder:
                                                              ((context,
                                                                  index) {
                                                            return ListTile(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          ((context) =>
                                                                              FacultyDetails(
                                                                                facultyList: userAuthController.allFacultyMembers[index],
                                                                              )),
                                                                    ));
                                                              },
                                                              title:
                                                                  MouseRegion(
                                                                cursor:
                                                                    SystemMouseCursors
                                                                        .click,
                                                                child: Text(
                                                                  '${userAuthController.allFacultyMembers[index].email}',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                  ),
                                                                ),
                                                              ),
                                                              subtitle:
                                                                  MouseRegion(
                                                                cursor:
                                                                    SystemMouseCursors
                                                                        .click,
                                                                child: Text(
                                                                  '${userAuthController.allFacultyMembers[index].fName} ${userAuthController.allFacultyMembers[index].lName}',
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                        ),
                                                      );
                                          }),
                                        ),
                                      ]),
                                    ),
                                  ],
                                )),
                              );
                      });
                    case 1:
                      _key.currentState?.closeDrawer();

                      return Container();
                    default:
                      _key.currentState?.closeDrawer();
                      return const Center(
                        child: Text(
                          'Home',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 40),
                        ),
                      );
                  }
                }),
              )))
            ],
          ),
        );
      },
    );
  }

  Padding userDetailsMethod(
      BuildContext context, UserAuthController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.300,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade400,
              width: 2.0,
            ),
            left: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
            right: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
            bottom: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 20),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                      size: 80,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.loggedInUserInfo.fName ?? ""} ${controller.loggedInUserInfo.lName ?? ""}",
                          style: const TextStyle(
                              color: Colors.deepPurple,
                              fontFamily: 'Poppins',
                              fontSize: 32),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          controller.loggedInUserInfo.roleName ?? "",
                          style: const TextStyle(
                              color: Colors.deepPurple,
                              fontFamily: 'Poppins',
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    controller.loggedInUserInfo.email ?? "",
                    style: const TextStyle(
                        color: Colors.deepPurple,
                        fontFamily: 'Poppins',
                        fontSize: 22),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SelectedItem(BuildContext context, Object item) {
    switch (item) {
      case 0:
        print('Start this course');
        break;
      case 1:
        print('Remove from View ');
    }
  }
}
