import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import '../../../coursemodel/model.dart';
import '../widgets/reportchart.dart';
import '../widgets/sidebar.dart';
import '../widgets/assesmenttable.dart';

class CourseSpecification extends StatefulWidget {
  const CourseSpecification({super.key});

  @override
  State<CourseSpecification> createState() => _CourseSpecificationState();
}

class _CourseSpecificationState extends State<CourseSpecification> {
  final _coursecontroller =
      SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  String dropdownValue = 'In progress';
  String dropValue = 'Course name';
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
                    text: 'Course Specification    ',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 23,
                      wordSpacing: 3,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    )),
                TextSpan(
                    text: '& Reports',
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
          drawer: CoursesSideBar(controller: _coursecontroller),
          body: Row(
            children: [
              if (!isSmallScreen) CoursesSideBar(controller: _coursecontroller),
              Expanded(
                  child: Center(
                      child: AnimatedBuilder(
                animation: _coursecontroller,
                builder: ((context, child) {
                  switch (_coursecontroller.selectedIndex) {
                    case 0:
                      _key.currentState?.closeDrawer();
                      return SingleChildScrollView(
                        child: Center(
                            child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 28.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
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
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18.0, left: 18),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          'Available Courses'.toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.deepPurple,
                                              fontFamily: 'Poppins',
                                              fontSize: 32),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                const SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 7),
                                  child: Container(
                                    height: 400,
                                    child: ListView.builder(
                                      itemCount: courseList.length,
                                      itemBuilder: ((context, index) {
                                        return ListTile(
                                          title: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: Text(
                                                '${courseList[index].id}',
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          subtitle: Text(
                                            '${courseList[index].title},',
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          trailing: PopupMenuButton(
                                            itemBuilder: (context) => const [
                                              PopupMenuItem<int>(
                                                value: 0,
                                                child: Text(
                                                  'View Specifications',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem<int>(
                                                value: 1,
                                                child: Text(
                                                  'Drop this course',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                            onSelected: (item) =>
                                                SelectedItem(context, item!),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        )),
                      );
                    case 1:
                      _key.currentState?.closeDrawer();
                      return Column(
                        children: const [
                          Text(
                            ' Participants',
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontFamily: 'Poppins',
                                fontSize: 32),
                          ),
                        ],
                      );
                    case 2:
                      _key.currentState?.closeDrawer();
                      return Center(
                        child: Text(
                          'Settings',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 40),
                        ),
                      );
                    case 3:
                      _key.currentState?.closeDrawer();
                      return CourseGrade();
                    default:
                      _key.currentState?.closeDrawer();
                      return Center(
                        child: Text(
                          'Homee',
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

  SelectedItem(BuildContext context, Object item) {
    switch (item) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CourseSpecification()));
        break;
      case 1:
        print('Remove from View ');
    }
  }
}

class CourseGrade extends StatelessWidget {
  const CourseGrade({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.16,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Fundamentals of Computing : User Report',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              fontSize: 28),
                        ),
                      ],
                    ),
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
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                              text: 'User report - ',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 23,
                                wordSpacing: 5,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              )),
                          TextSpan(
                              text: 'Munir Tabassum',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              )),
                        ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CourseAssessmentTable(),
                ReportChart()
              ]),
            ),
          ),
        ],
      )),
    );
  }
}
