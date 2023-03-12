import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/controller.dart';
import '../../../../../models/models.dart';
import '../coursemodel/model.dart';
import '../models/facultymodel.dart';
import 'courseperformance.dart';

class FacultyDetails extends StatefulWidget {
  final UsersModel facultyList;
  FacultyDetails({super.key, required this.facultyList});

  @override
  State<FacultyDetails> createState() => _FacultyDetailsState();
}

class _FacultyDetailsState extends State<FacultyDetails> {
  final coursesController = Get.find<CoursesController>();
  var year = DateTime.now().year.toString().obs;
  final _itemsYear = List<DateTime>.generate(
      10,
      (i) => DateTime.utc(
            DateTime.now().year - i,
          ).add(Duration(days: i)));
  String sessions = 'Fall';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 3.0, right: 3.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  border: Border(
                    top: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                    left: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                    right: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    bottom: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
                child: Column(children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, left: 20),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.person,
                              size: 80, color: Colors.deepPurple),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${widget.facultyList.fName} ${widget.facultyList.lName}  ( ${widget.facultyList.roleName} )'
                            .toUpperCase(),
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontFamily: 'Poppins',
                            fontSize: 32),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            // course assigned to faculty
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
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
                child: GetBuilder<CoursesController>(initState: (_) {
                  Future.delayed(const Duration(seconds: 0)).then((value) {
                    coursesController.getAllAssignedCourses();
                  });
                }, builder: (courseController) {
                  final facultyId = widget.facultyList.userId;
                  RxList<dynamic> _courses = [].obs;
                  _courses = courseController.allAssignedCourses
                      .where((e) => e.instructorUserId == facultyId)
                      .where((e) => e.session
                          .toString()
                          .toLowerCase()
                          .contains(sessions.toLowerCase()))
                      .where((e) => e.createdAt
                          .toString()
                          .toLowerCase()
                          .contains(year.value))
                      .toList()
                      .obs;
                  return courseController.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Session *",
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontFamily: 'Poppins',
                                              fontSize: 20),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 38.0),
                                          child: DropDownForSessions(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Year *",
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontFamily: 'Poppins',
                                              fontSize: 20),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 38.0),
                                          child: DropDownForYears(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          _courses.isEmpty
                              ? Container(
                                  child: const Center(
                                    child: Text("Nothing to Show here"),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 14.0),
                                  child: Row(
                                    children: const [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Teaching Following Courses',
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
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 7),
                            child: Container(
                              height: 400,
                              child: ListView.builder(
                                itemCount: _courses.length,
                                itemBuilder: ((context, index) {
                                  return ListTile(
                                    onTap: () {
                                      // final courseId = _courses[index].courseId;
                                      // print("courseId is $courseId");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) =>
                                                CoursePerformance(
                                                  courseList: _courses[index],
                                                  facultyList:
                                                      widget.facultyList,
                                                )),
                                          ));
                                    },
                                    title: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Text(
                                        '${_courses[index].courseCode}',
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                    subtitle: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Text(
                                        '${_courses[index].courseName.toString().toUpperCase()}',
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ]);
                }),
              ),
            ),
          ],
        ),
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
}
