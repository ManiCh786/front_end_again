import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import '../../../../controllers/controller.dart';
import '../../../../models/models.dart';
import 'package:get/get.dart';
import '../widgets/sidebarwidget.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboard();
}

class _StudentDashboard extends State<StudentDashboard> {
  final _controller = SidebarXController(selectedIndex: 1, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  String dropdownValue = 'In progress';
  String dropValue = 'Course name';
  String sessions = 'Fall';
  // String year = "2022";
  var year = DateTime.now().year.toString().obs;
  final _itemsYear = List<DateTime>.generate(
      10,
      (i) => DateTime.utc(
            DateTime.now().year - i,
          ).add(Duration(days: i)));
  bool userLoggedIn = Get.find<UserAuthController>().isUserLoggedIn();

  final enrolledStudentController = Get.find<EnrolledStudentsController>();

  final coursesController = Get.find<CoursesController>();
  final enrollMentScheduleController =
      Get.find<EnrollmentsScheduleController>();

  @override
  Widget build(BuildContext context) {
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
                      text: 'Student Portal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      )),
                ]),
              ),
              actions: [
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.notifications,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
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
            drawer: SideBarWidget(controller: _controller),
            body: GetBuilder<UserAuthController>(initState: (_) {
              if (userLoggedIn) {
                Future.delayed(Duration.zero).then(
                  (value) =>
                      Get.find<UserAuthController>().getLoggedInUserInfo(),
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
                  : Row(
                      children: [
                        if (!isSmallScreen)
                          SideBarWidget(controller: _controller),
                        Expanded(
                            child: Center(
                                child: AnimatedBuilder(
                          animation: _controller,
                          builder: ((context, child) {
                            switch (_controller.selectedIndex) {
                              case 0:
                                _key.currentState?.closeDrawer();
                                return dashboardScreen(context, controller);
                              case 1:
                                _key.currentState?.closeDrawer();
                                return caseOneEnrollmentHeading(context);
                              case 2:
                                _key.currentState?.closeDrawer();
                                return SingleChildScrollView(
                                  child: Center(
                                    child: Column(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 28.0),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
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
                                          child: Row(
                                            children: const [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                ' Grades',
                                                style: TextStyle(
                                                    color: Colors.deepPurple,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 32),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Profile Section end here
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 35, left: 30),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Session *",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .deepPurple,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 20),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        38.0),
                                                            child:
                                                                DropDownForSessions(),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Year *",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .deepPurple,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 20),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        38.0),
                                                            child:
                                                                DropDownForYears(),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 30),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 7,
                                                    top: 15),
                                                child: GetBuilder<
                                                        EnrolledStudentsController>(
                                                    initState: (_) {
                                                  Future.delayed(const Duration(
                                                          seconds: 0))
                                                      .then((value) {
                                                    enrolledStudentController
                                                        .getallEnrolledSudents();
                                                  });
                                                }, builder: (stController) {
                                                  RxList enrolledList = [].obs;
                                                  final userId = Get.find<
                                                          UserAuthController>()
                                                      .getUserId();
                                                  enrolledList = stController
                                                      .getEnrolledStydentsObx
                                                      .where((e) => e.createdAt
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(year.value))
                                                      .where(
                                                        (e) => e.session
                                                            .toString()
                                                            .toLowerCase()
                                                            .contains(sessions
                                                                .toLowerCase()),
                                                      )
                                                      .where((e) => e.userId
                                                          .toString()
                                                          .contains(userId
                                                              .toString()))
                                                      .toList()
                                                      .obs;

                                                  return enrolledList.isEmpty
                                                      ? Container(
                                                          child: const Center(
                                                            child: Text(
                                                                "Nothing to Show here"),
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 400,
                                                          child:
                                                              ListView.builder(
                                                            itemCount:
                                                                enrolledList
                                                                    .length,
                                                            itemBuilder:
                                                                ((context,
                                                                    index) {
                                                              return ListTile(
                                                                onTap: () {
                                                                  Map<String,
                                                                          dynamic>
                                                                      _args = {
                                                                    'courseDetails':
                                                                        enrolledList[
                                                                            index]
                                                                  };

                                                                  Get.toNamed(
                                                                      '/studentDashboard/grades',
                                                                      arguments:
                                                                          _args);
                                                                },
                                                                title: Text(
                                                                    '${enrolledList[index].courseName} . ( ${enrolledList[index].courseCode} )'),
                                                                subtitle: Text(
                                                                    'Session : ${enrolledList[index].session} Cr.Hr : ${enrolledList[index].courseCrHr}'),
                                                                // trailing:
                                                                //     PopupMenuButton(
                                                                //   itemBuilder:
                                                                //       (context) =>
                                                                //           [
                                                                //     PopupMenuItem<
                                                                //         int>(
                                                                //       onTap:
                                                                //           () {
                                                                //         // grades
                                                                //         Get.toNamed(
                                                                //             '/studentDashboard/grades');
                                                                //       },
                                                                //       value: 0,
                                                                //       child: Text(
                                                                //           'View Grades'),
                                                                //     ),
                                                                //   ],
                                                                //   onSelected: (item) =>
                                                                //       SelectedItem(
                                                                //           context,
                                                                //           item),
                                                                // ),
                                                              );
                                                            }),
                                                          ),
                                                        );
                                                }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                              case 3:
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
                    );
            }));
      },
    );
  }

  Column caseOneEnrollmentHeading(BuildContext context) {
    bool enrollmentStarted = false;
    var sessionToBeEnrolled = "";
    CoursesModel _courseDetailsAsArguments;
    return Column(
      children: [
        GetBuilder<EnrollmentsScheduleController>(initState: (_) {
          Future.delayed(Duration.zero).then((value) =>
              enrollMentScheduleController.getAllEnrollmentSchedules());
        }, builder: (enrollmentScController) {
          RxList<dynamic> _currentSchedule = [].obs;
          DateTime currDate = DateTime.now();
          DateTime dateOnly =
              DateTime(currDate.year, currDate.month, currDate.day);
          _currentSchedule = enrollmentScController.allEnrollmentSchedules
              .where((schedule) {
                return DateTime.parse(schedule.startDate)
                        .isAtSameMomentAs(dateOnly) ||
                    DateTime.parse(schedule.startDate).isBefore(dateOnly);
              })
              .where((schedule) {
                return DateTime.parse(schedule.endDate)
                        .isAtSameMomentAs(dateOnly) ||
                    DateTime.parse(schedule.endDate).isAfter(dateOnly);
              })
              .toList()
              .obs;
          sessionToBeEnrolled = enrollmentScController.allEnrollmentSchedules
              .where((schedule) {
                return DateTime.parse(schedule.startDate)
                        .isAtSameMomentAs(dateOnly) ||
                    DateTime.parse(schedule.startDate).isBefore(dateOnly);
              })
              .where((schedule) {
                return DateTime.parse(schedule.endDate)
                        .isAtSameMomentAs(dateOnly) ||
                    DateTime.parse(schedule.endDate).isAfter(dateOnly);
              })
              .map((e) => e.session.toString())
              .toString();
          _currentSchedule.isEmpty
              ? enrollmentStarted = false
              : enrollmentStarted = true;
          return _currentSchedule.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
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
                    child: Row(children: const [
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Text(
                        ' Enrollment is not started yet',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontFamily: 'Poppins',
                            fontSize: 32),
                      ),
                    ]),
                  ))
              : Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
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
                    child: ListView.builder(
                        itemCount: _currentSchedule.length,
                        itemBuilder: ((context, i) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // for(int i=0;i<_currentSchedule.length;i++)

                                Row(children: const [
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                  Text(
                                    ' Enroll Courses',
                                    style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontFamily: 'Poppins',
                                        fontSize: 32),
                                  ),
                                ]),
                                Text(
                                  "Start Date ::  ${DateTime.parse(_currentSchedule[i].startDate)}",
                                  style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontFamily: 'Poppins',
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Last Date::   ${DateTime.parse(_currentSchedule[i].endDate)}",
                                  style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontFamily: 'Poppins',
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Current Session ::    ${_currentSchedule[i].session}",
                                      style: const TextStyle(
                                          color: Colors.deepPurple,
                                          fontFamily: 'Poppins',
                                          fontSize: 22),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ]);
                        })),
                  ));
        }),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 7),
                child: GetBuilder<CoursesController>(initState: (_) {
                  Future.delayed(const Duration(seconds: 0)).then((value) {
                    coursesController.getAllAssignedCourses();
                  });
                }, builder: (courseController) {
                  return courseController.allAssignedCourses.isEmpty
                      ? Container(
                          child: const Center(
                            child: Text("Nothing to Show here"),
                          ),
                        )
                      : enrollmentStarted
                          ? Container(
                              height: 400,
                              child: ListView.builder(
                                itemCount:
                                    courseController.allAssignedCourses.length,
                                itemBuilder: ((context, index) {
                                  return ListTile(
                                    onTap: () {
                                      _courseDetailsAsArguments =
                                          courseController
                                              .allAssignedCourses[index];
                                      Map<String, dynamic> _args = {
                                        'session': sessionToBeEnrolled,
                                        'courseDetails':
                                            _courseDetailsAsArguments,
                                      };
                                      // Get.back();
                                      Get.toNamed(
                                        '/studentDashboard/viewCourseDescriptionScreen',
                                        arguments: _args,
                                      );
                                    },
                                    title: Text(
                                        '${courseController.allAssignedCourses[index].courseName} . ( ${courseController.allAssignedCourses[index].courseCode} )'),
                                    subtitle: Text(
                                        'Session : ${courseController.allAssignedCourses[index].session} Cr.Hr : ${courseController.allAssignedCourses[index].courseCrHr}'),
                                    trailing: PopupMenuButton(
                                      itemBuilder: (context) => [
                                        PopupMenuItem<int>(
                                          onTap: () {
                                            _courseDetailsAsArguments =
                                                courseController
                                                    .allAssignedCourses[index];
                                            Map<String, dynamic> _args = {
                                              'session': sessionToBeEnrolled,
                                              'courseDetails':
                                                  _courseDetailsAsArguments,
                                            };
                                            // Get.back();
                                            Get.toNamed(
                                              '/studentDashboard/viewCourseDescriptionScreen',
                                              arguments: _args,
                                            );
                                          },
                                          value: 0,
                                          child: const Text('View Description'),
                                        ),
                                      ],
                                      onSelected: (item) =>
                                          SelectedItem(context, item),
                                    ),
                                  );
                                }),
                              ),
                            )
                          : Container();
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView dashboardScreen(
      BuildContext context, UserAuthController controller) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          controller.loggedInUserInfo.fName! +
                              controller.loggedInUserInfo.lName!,
                          style: const TextStyle(
                              color: Colors.deepPurple,
                              fontFamily: 'Poppins',
                              fontSize: 32),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          controller.loggedInUserInfo.roleName!,
                          style: const TextStyle(
                              color: Colors.deepPurple,
                              fontFamily: 'Poppins',
                              fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          controller.loggedInUserInfo.email!.toLowerCase(),
                          style: const TextStyle(
                              color: Colors.deepPurple,
                              fontFamily: 'Poppins',
                              fontSize: 22),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      controller.loggedInUserInfo.phone!,
                      style: const TextStyle(
                          color: Colors.deepPurple,
                          fontFamily: 'Poppins',
                          fontSize: 18),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // TextButton(
                    //   child: const Text("Logout"),
                    //   onPressed: () {
                    //     if (Get.find<UserAuthController>().isUserLoggedIn()) {
                    //       Get.find<UserAuthController>().logout();
                    //       Get.toNamed("/");
                    //     }
                    //   },
                    // ),
                  ]),
            ),
          ),
          // Profile Section end here
          const SizedBox(
            height: 15,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.75,
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
                padding: const EdgeInsets.only(top: 14.0),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Course overview',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 19.0),
                    child: DropDownMethod1(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 38.0),
                    child: DropDownMethod2(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 7),
                child: GetBuilder<EnrolledStudentsController>(initState: (_) {
                  Future.delayed(const Duration(seconds: 0)).then((value) {
                    enrolledStudentController.getallEnrolledSudents();
                  });
                }, builder: (stController) {
                  RxList enrolledList = [].obs;
                  final userId = Get.find<UserAuthController>().getUserId();
                  if (dropdownValue == "In progress") {
                    enrolledList = stController.getEnrolledStydentsObx
                        .where((e) => e.endDate.toString() == "null")
                        .where((e) =>
                            e.userId.toString().contains(userId.toString()))
                        .toList()
                        .obs;
                  } else if (dropdownValue == "Past") {
                    enrolledList = stController.getEnrolledStydentsObx
                        .where((e) => e.endDate.toString() != "null")
                        .where((e) =>
                            e.userId.toString().contains(userId.toString()))
                        .toList()
                        .obs;
                  }

                  return enrolledList.isEmpty
                      ? Container(
                          child: const Center(
                            child: Text("Nothing to Show here"),
                          ),
                        )
                      : Container(
                          height: 400,
                          child: ListView.builder(
                            itemCount: enrolledList.length,
                            itemBuilder: ((context, index) {
                              return ListTile(
                                title: Text(
                                    '${enrolledList[index].courseName} . ( ${enrolledList[index].courseCode} )'),
                                subtitle: Text(
                                    'Session : ${enrolledList[index].session} Cr.Hr : ${enrolledList[index].courseCrHr}'),
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
  }

  Container DropDownMethod2() {
    return Container(
      height: 40,
      width: 173,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        border: Border.all(width: 1, color: Colors.black38),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.grey.shade400,
        // Step 3.
        value: dropValue,
        // Step 4.
        items: <String>['Course name', 'Last accessed']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                '$value   ',
                style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ),
          );
        }).toList(),
        // Step 5.
        onChanged: (String? newValue) {
          setState(() {
            dropValue = newValue!;
          });
        },
      ),
    );
  }

  Container DropDownMethod1() {
    return Container(
      height: 40,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        border: Border.all(width: 1, color: Colors.black38),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.grey.shade400,
        // Step 3.
        value: dropdownValue,
        // Step 4.
        items: <String>['In progress', 'Past']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                '$value   ',
                style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ),
          );
        }).toList(),
        // Step 5.
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
      ),
    );
  }

  Container DropDownForSessions() {
    return Container(
      height: 40,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        border: Border.all(width: 1, color: Colors.black38),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.grey.shade400,
        // Step 3.
        value: sessions,
        // Step 4.
        items: <String>['Fall', 'Spring', 'Summer']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                '$value   ',
                style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ),
          );
        }).toList(),
        // Step 5.
        onChanged: (String? newValue) {
          setState(() {
            sessions = newValue!;
          });
        },
      ),
    );
  }

  Container DropDownForYears() {
    return Container(
      height: 40,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        border: Border.all(width: 1, color: Colors.black38),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.grey.shade400,
        // Step 3.
        value: year.value,
        // Step 4.
        items: _itemsYear.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
            value: value.year.toString(),
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                '${value.year}   ',
                style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ),
          );
        }).toList(),
        // Step 5.
        onChanged: (String? newValue) {
          setState(() {
            year.value = newValue!;
          });
        },
      ),
    );
  }

  SelectedItem(BuildContext context, Object? item) {
    switch (item) {
      case 0:
        print('Start this course');
        break;
      case 1:
        print('Remove from View ');
    }
  }
}
