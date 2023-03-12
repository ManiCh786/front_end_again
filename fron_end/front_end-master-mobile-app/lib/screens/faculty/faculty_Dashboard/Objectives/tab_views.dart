import 'package:flutter/material.dart';
import 'package:front_end/screens/faculty/faculty_Dashboard/Objectives/view_objectives.dart';
import 'package:get/get.dart';
import '../../../../controllers/controller.dart';
import '../../../../models/models.dart';
import '../../../../widgets/widgets.dart';
import 'add_objectives.dart';

class TabViewForObjectives extends StatelessWidget {
  TabViewForObjectives({Key? key, this.courses}) : super(key: key);
  // final courses = Get.find<CoursesController>().courses;
  final courseController =
      Get.put<CoursesController>(CoursesController(courseRepo: Get.find()));

  final CoursesModel? courses;
  final courseId = Get.parameters['courseId'].toString();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.amber.shade500,
          elevation: 0.0,
          centerTitle: true,
          title: Row(
            // children: courseController.myCourses.map((e) => Text(e.courseName.where((h) => h.courseId.toString().contains(courseId.toString()).toString()))).toList()
            children: courseController.myCourses
                .where(
                    (e) => e.courseId.toString().contains(courseId.toString()))
                .map((e) => Text(
                    "${e.courseName}| ${e.semester} | ${e.department.toString().toUpperCase()}",
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Colors.black)))
                .toList(),
            ),
          // Text(
          //   "${courseId}", style: TextStyle(fontFamily: 'Dongle',fontSize: 30,color: Colors.purple)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(children: [
                  Container(
                    height: 65,
                    width: 630,
                    decoration:  BoxDecoration(
                      color: Colors.amber.shade300,
                    ),
                    child:const TabBar(
                        indicator: BoxDecoration(
                          color: Colors.deepPurple,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          UserTypeRegisterTab(
                              title: "Add Objectives & Outcomes",
                              icn: Icons.note_add_outlined),
                          UserTypeRegisterTab(
                              title: 'Objective BreakDown Structure',
                              icn: Icons.view_comfortable),
                        ]),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: TabBarView(children: [
                        AddObjectives(courseId: int.parse(courseId)),
                        ViewObjectives(courseId: int.parse(courseId)),
                      ]),
                    ),
                  ),
                ]),
              )),
        ),
      ),
    );
  }
}
