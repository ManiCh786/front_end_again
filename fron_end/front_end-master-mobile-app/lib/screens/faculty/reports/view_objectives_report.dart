import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/controller.dart';
import '../../../../models/models.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../../../data/repository/assessments_marks_repo.dart';
class ViewObjectivesReport extends StatelessWidget {
  ViewObjectivesReport({
    Key? key,
    required this.courseId,
    required this.courseName,
    required this.session,
  }) : super(key: key);
    final int courseId;
  final String courseName;
  final String session;

  final scrollController = ScrollController();

  bool showAddButton = false;
  final courseController =
      Get.put<CoursesController>(CoursesController(courseRepo: Get.find()));
  final userAuthController = Get.find<UserAuthController>();
  final assMarksRepo = Get.put<AssessmentsMarksRepo>(
      AssessmentsMarksRepo(apiClient: Get.find()));
  final assessmentsMarksController = Get.put<AssessmentsMarksController>(
      AssessmentsMarksController(assMarksRepo: Get.find()));
    @override
  Widget build(BuildContext context) {
 return Scaffold(
      body: GetBuilder<CoursesController>(initState: (_) async {
        Future.delayed(Duration.zero).then(
          (value) { courseController.getCourseObjectives(courseId);
          assessmentsMarksController.getObjectivesAccomplishedReport();
          }
        );
           
      }, builder: (courseController) {
        int total = 0;
        int totalWeightage = 0;
        for(int j=0;j<courseController.courseObjectives.length;j++){
          total += int.parse(courseController
                                                            .courseObjectives[j]
                                                            .quiz.toString()) + int.parse(courseController
                                                            .courseObjectives[j]
                                                            .assignment.toString())+ int.parse(courseController
                                                            .courseObjectives[j]
                                                            .presentation.toString())+ int.parse(courseController
                                                            .courseObjectives[j]
                                                            .project.toString());
        }
         RxList<dynamic> list = [].obs;
          var yearFilter = DateTime.now().year.toString().obs;
          final currentUserId = Get.find<UserAuthController>().getUserId();
        
             list = assessmentsMarksController.getAccomplishedObjectives
            //  .where((e)=> e.subject.toString().toLowerCase().contains(courseName.toString().toLowerCase().replaceAll(
            //                                                 RegExp(r"\(|\)"),
            //                                                 "")) )
            // .where((e) => e['ass_added_by']==currentUserId).where((e) => e['session']==session)
            .toList()
              .obs;
              print("total list = ${list.length }");
  print("total QUizes  = ${total.toString() }");


        int userId = userAuthController.getUserId();
        return Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Container(
              height: Get.height,
              width: Get.width,
              child: InteractiveViewer(
                scaleEnabled: false,
                child: Scrollbar(
                  trackVisibility: true,
                  controller: scrollController,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: courseController.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.black,
                            ))
                          : courseController.courseObjectives.isEmpty
                              ? const Center(
                                  child: Text("No Objectives Added !"))
                              : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                
                                children: [
                                  DataTable(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      showBottomBorder: true,
                                      dataTextStyle: const TextStyle(
                                          color: Colors.black),
                                      headingTextStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins'),
                                      columnSpacing: 50,
                                      dividerThickness: 5,
                                      border: TableBorder.all(
                                          color: Colors.deepPurple,
                                          style: BorderStyle.solid,
                                          width: 1.5),
                                      columns: const [
                                        DataColumn(
                                          label: Text('Objective Name'),
                                        ),
                                        DataColumn(
                                          label: Text('Outcome'),
                                        ),
                                        DataColumn(
                                          label: Text('Weightage'),
                                        ),
                                        DataColumn(
                                          label: Text('View Report'),
                                        ),
                                     
                                      ],
                                      rows: [
                                        for (int i = 0;
                                            i <
                                                courseController
                                                    .courseObjectives
                                                    .length;
                                            i++)
                                          DataRow(cells: [
                                            DataCell(
                                              Text(
                                                courseController
                                                        .courseObjectives[i]
                                                        .objName ??
                                                    "null",
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins'),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                courseController
                                                        .courseObjectives[i]
                                                        .outcome ??
                                                    "null",
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins'),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                "${courseController.courseObjectives[i].objWeightage.toString()} (%)" ??
                                                    "null",
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins'),
                                              ),
                                            ),
                                            DataCell(courseController
                                                        .courseObjectives[i]
                                                        .quiz
                                                        .toString() ==
                                                    "null"
                                                ? Text("Not Found !"
                                                  )
                                                : 
                                                TextButton(
                                                onPressed: () {
                                              
                                                  Get.dialog(
                                                    ObjectivesReport(
                                                      assesmentTypes:
                                                          courseController
                                                              .courseObjectives[i],
                                                      coursObjectives:
                                                          courseController
                                                              .courseObjectives[
                                                                  i]
                                                              .objName,
                                                      ploId: courseController
                                                          .courseObjectives[
                                                              i]
                                                          .objId,
                                                          courseName: courseName,
                                                          session: session,

                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  "View Report",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Poppins',
                                                      color: Colors.grey),
                                                ))
                                                
                                                ),
                                             ])
                                      ]),
                                  const SizedBox(height: 30),
                                  Text(
      'Overall Course Accomplished: ${(list.length/total)*100} %',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
                                ],
                              ),
                    ),
                  ),
                ),
              ),
            ));
      }),
    );
  
  }}

class ObjectivesReport extends StatelessWidget {
  ObjectivesReport({
    Key? key,
    required this.assesmentTypes,
    required this.coursObjectives,
    required this.ploId,
    required this.courseName,
    required this.session,

  }) : super(key: key);
 CourseObjectivesModel assesmentTypes;
  String coursObjectives;
  int ploId;
  String session;
  String courseName;
   final scrollController = ScrollController();
 
 
  final courseController =
      Get.put<CoursesController>(CoursesController(courseRepo: Get.find()));
  final assMarksRepo = Get.put<AssessmentsMarksRepo>(
      AssessmentsMarksRepo(apiClient: Get.find()));
  final assessmentsMarksController = Get.put<AssessmentsMarksController>(
      AssessmentsMarksController(assMarksRepo: Get.find()));
  final userAuthController = Get.find<UserAuthController>();
// getObjectivesAccomplishedReport
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: GetBuilder<AssessmentsMarksController>(initState: (_) async {
            Future.delayed(Duration.zero).then(
              (value) =>
                  assessmentsMarksController.getObjectivesAccomplishedReport(),
            );
           
          }, builder: (assMController) {
            RxList<dynamic> list = [].obs;
            var yearFilter = DateTime.now().year.toString().obs;
            final currentUserId = Get.find<UserAuthController>().getUserId();
          
               int totalNo = 0;
                                int totalQuiz = 0;
                                int totalAssignment = 0;
                                int totalPpt = 0;
                                int totalProject = 0;
                                totalNo = assesmentTypes.quiz! +
                                    assesmentTypes.assignment! +
                                    assesmentTypes.presentation! +
                                    assesmentTypes.project!;
                                totalQuiz = assesmentTypes.quiz!;
                                totalAssignment = assesmentTypes.assignment!;
                                totalPpt = assesmentTypes.presentation!;
                                totalProject = assesmentTypes.project!;
                              
            
            list = assMController.getAccomplishedObjectives
               .where((e)=> e['objectives'].toString().toLowerCase().contains(coursObjectives.toString().toLowerCase()) )
                .toList()
                .obs;
            return Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  child: InteractiveViewer(
                    scaleEnabled: false,
                    child: Scrollbar(
                      trackVisibility: true,
                      controller: scrollController,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: courseController.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.black,
                                ))
                              : list.isEmpty
                                  ? const Center(
                                      child: Text("No Assessment  Added yet !"))
                                  : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      DataTable(
                                          decoration: const BoxDecoration(
                                              color: Colors.white),
                                          showBottomBorder: true,
                                          dataTextStyle: const TextStyle(
                                              color: Colors.black),
                                          headingTextStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins'),
                                          columnSpacing: 50,
                                          dividerThickness: 5,
                                          border: TableBorder.all(
                                              color: Colors.deepPurple,
                                              style: BorderStyle.solid,
                                              width: 1.5),
                                          columns: const [
                                            DataColumn(
                                              label: Text('Objective Name'),
                                            ),
                                            DataColumn(
                                              label: Text('Outcome'),
                                            ),
                                            DataColumn(
                                              label: Text('Weightage'),
                                            ),
                                            DataColumn(
                                              label: Text('Total Assessments'),
                                            ),
                                            DataColumn(
                                              label: Text('Assessments Accomplished'),
                                            ),
                                            DataColumn(
                                              label: Text('Objective Accomplished'),
                                            ),
                                         
                                          ],
                                          rows: [
                                            for (int i = 0;
                                                i <
                                                   1;
                                                i++)
                                              DataRow(cells: [
                                                DataCell(
                                                  Text(
                                                   list[
                                                            i]['objectives'] ??
                                                        "null",
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins'),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                   list[i]
                                                            [
                                                            'assessmentType'] ??
                                                        "null",
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins'),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    "${list[i]['weightage'].toString()} (%)" ??
                                                        "null",
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins'),
                                                  ),
                                                ),
                                                DataCell(Text(totalNo.toString())),
                                                DataCell(Text(
                                                    "${list.length.toString()} " ??
                                                        "null",
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins'),
                                                  ),),
                                                DataCell(Text(
                                                    "${(list.length/totalNo) * 100.round()} (%)" ??
                                                        "null",
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins'),
                                                  ),),
                                            
                                              ])
                                          ]),
                                      const SizedBox(height: 30),
                                    
                                         
                                    ],
                                  ),
                        ),
                      ),
                    ),
                  ),
                ));
          }),
        ),
      ),
    );
  }



 
}
