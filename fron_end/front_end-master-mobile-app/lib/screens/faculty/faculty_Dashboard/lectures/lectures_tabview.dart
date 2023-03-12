import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/controller.dart';
import '../../../../models/models.dart';
import '../../../../widgets/widgets.dart';

import 'addAssessments.dart';
import 'addOutline.dart';
import 'assessment_breakdown_structure.dart';

class TabViewForLectures extends StatelessWidget {
  TabViewForLectures({Key? key, this.courses}) : super(key: key);
  // final courses = Get.find<CoursesController>().courses;
  final courseController =
      Get.put<CoursesController>(CoursesController(courseRepo: Get.find()));

  final CoursesModel? courses;
  final courseId = Get.parameters['courseId'].toString();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      courseController.getMyCourses();

      if (courseController.myCourses.isEmpty) {
        Get.offAllNamed('/');
      }
    });
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          padding: const EdgeInsets.only(top: 30.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(children: [
              Container(
                height: 60,
                width: 700,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: TabBar(
                    indicator: BoxDecoration(
                      color: Colors.amber.shade300,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      UserTypeRegisterTab(
                          title: "OutLine", icn: Icons.note_add_outlined),
                      UserTypeRegisterTab(
                          title: "Add Assesments",
                          icn: Icons.note_add_outlined),
                      // UserTypeRegisterTab(
                      //     title: "Assesments Breakdown ",
                      //     icn: Icons.note_add_outlined),
                    ]),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: TabBarView(children: [
                    AddOutline(),
                    AddAssessments(),
                  
                    // AssessmentBreakdownStructure(
                    //   courseId: int.parse(courseId),
                    // ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
