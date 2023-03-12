import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_end/controllers/assessments_marks_controller.dart';
import 'package:front_end/data/repository/assessments_repo.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import '../../../../controllers/controller.dart';
import '../../../../data/repository/repository.dart';
import '../../../../models/models.dart';
import '../../../../utils/utils.dart';

class CourseAssessmentTable extends StatelessWidget {
  CourseAssessmentTable(
      {super.key, required this.courseName, required this.session});
  String courseName;
  String session;
  // final enstrepo = Get.put<AssessmentsMarksRepo>(
  //     AssessmentsMarksRepo(apiClient: Get.find()));

  // final assController = Get.put<AssessmentsMarksController>(
  //     AssessmentsMarksController(assMarksRepo: Get.find()));
  final assController = Get.find<AssessmentsMarksController>();

  final coursesController = Get.find<CoursesController>();
  final enrollMentScheduleController =
      Get.find<EnrollmentsScheduleController>();

  final scrollController = ScrollController();

  final columnCount = 9;
  List<DataColumn> _generateColumns() {
    List<DataColumn> columns = [];
    for (int i = 0; i < columnCount; i++) {
      columns.add(
        i == 0
            ? const DataColumn(
                label: Text('Sr.No'),
              )
            : i == 1
                ? const DataColumn(
                    label: Text('Assessment Type'),
                  )
                : i == 2
                    ? const DataColumn(
                        label: Text('Student Name'),
                      )
                    : i == 3
                        ? const DataColumn(
                            label: Text('Total Question'),
                          )
                        : i == 4
                            ? const DataColumn(
                                label: Text('Total Marks'),
                              )
                            : i == 5
                                ? const DataColumn(
                                    label: Text('Obt. Marks'),
                                  )
                                : i == 6
                                    ? const DataColumn(
                                        label: Text('Topics'),
                                      )
                                    : i == 7
                                        ? const DataColumn(
                                            label: Text('Percentage (%)'),
                                          )
                                        : const DataColumn(
                                            label: Text('View More'),
                                          ),
      );
    }
    return columns;
  }

  @override
  Widget build(BuildContext context) {
      if (courseName.isEmpty) {
      Future.delayed(Duration.zero).then((value) => Get.offAllNamed("/"));
    }
    // if (courseName.isEmpty) {
    //   print("Empty");
    //   Get.offAllNamed("/studentDashboard");
    // }else{
    //   print("EmptNoty");

    // }
    return GetBuilder<AssessmentsMarksController>(initState: (_) {
      Future.delayed(Duration.zero)
          .then((value) => assController.getEveryInfoWithMarks());
    },
        // getEveryInfoWithMarks
        builder: (controller) {
      RxList marksList = [].obs;
      final userId = Get.find<UserAuthController>().getUserId();
      marksList = controller.everyAssessmentsMarks
          .where((e) => e.subject
              .toString()
              .toLowerCase()
              .contains(courseName.toLowerCase()))
          .where((e) => e.session
              .toString()
              .toLowerCase()
              .contains(session.toLowerCase()))
          .where((e) => e.userId.toString().contains(userId.toString()))
          .toList()
          .obs;

      final Map<dynamic, Map<dynamic, List<dynamic>>> groupedAssessments = {};

      for (var assessment in marksList) {
        if (!groupedAssessments.containsKey(assessment.userId)) {
          groupedAssessments[assessment.userId] = {};
        }
        if (!groupedAssessments[assessment.userId]!
            .containsKey(assessment.asId)) {
          groupedAssessments[assessment.userId]![assessment.asId] = [];
        }
        groupedAssessments[assessment.userId]![assessment.asId]!
            .add(assessment);
      }

      final List<Map<String, dynamic>> result = [];
      groupedAssessments.forEach((userId, assessmentMap) {
        assessmentMap.forEach((assessmentId, assessmentsForUser) {
          final int totalMarks = assessmentsForUser.fold<int>(
              0, (sum, assessment) => sum + (assessment.totalMarks as int));
          final int obtainedMarks = assessmentsForUser.fold<int>(
              0, (sum, assessment) => sum + (assessment.obtmarks as int));
          final assessmentType = assessmentsForUser
              .firstWhere((assessment) => assessment.asId == assessmentId)
              .assessmentType;
          final fName = assessmentsForUser
              .firstWhere((assessment) => assessment.userId == userId)
              .fName;
          final lName = assessmentsForUser
              .firstWhere((assessment) => assessment.userId == userId)
              .lName;
          final relatedtopics = assessmentsForUser
              .firstWhere((assessment) => assessment.asId == assessmentId)
              .relatedTopic;

          result.add({
            'userId': userId,
            'assessmentId': assessmentId,
            'totalMarks': totalMarks,
            'obtainedMarks': obtainedMarks,
            'numOfQuestions': assessmentsForUser.length,
            'assessmentType': assessmentType,
            'studentName': fName + lName,
            'topics': relatedtopics,
          });
        });
      });

      return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              height: Get.height,
              width: Get.width,
              child: InteractiveViewer(
                  scaleEnabled: false,
                  child: Scrollbar(
                      controller: scrollController,
                      child: result.isEmpty
                          ? Container(
                              child: const Text("Nothing to show here ",
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 23,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  )),
                            )
                          : SingleChildScrollView(
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                      columns: _generateColumns(),
                                      rows: [
                                        for (int i = 0; i < result.length; i++)
                                          DataRow(cells: [
                                            DataCell(Text("${i + 1}")),
                                            DataCell(Text(
                                                "${result[i]['assessmentType']}")),
                                            DataCell(Text(
                                                "${result[i]['studentName']}")),
                                            DataCell(Text(
                                                "${result[i]['numOfQuestions']}")),
                                            DataCell(Text(
                                                "${result[i]['totalMarks']}")),
                                            DataCell(Text(
                                                "${result[i]['obtainedMarks']}")),
                                            DataCell(
                                              RichText(
                                                text: TextSpan(
                                                  text: " ",
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    for (var line in result[i]
                                                            ['topics']
                                                        .toString()
                                                        .split(','))
                                                      TextSpan(
                                                          text: '$line\n',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      16)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Text(((result[i][
                                                              'obtainedMarks'] /
                                                          result[i]
                                                              ['totalMarks']) *
                                                      100)
                                                  .toString()),
                                            ),
                                            DataCell(
                                              TextButton(
                                                onPressed: () {
                                                  final asId =
                                                      result[i]['assessmentId'];

                                                  List<dynamic>
                                                      marksListByAssesmentwise =
                                                      [].obs;
                                                  marksListByAssesmentwise =
                                                      marksList
                                                          .where((p) =>
                                                              p.asId == asId)
                                                          .toList();

                                                  Get.dialog(ViewGradesDialogue(
                                                      subjectInfo:
                                                          marksListByAssesmentwise));
                                                },
                                                child:
                                                    Text("View More Details"),
                                              ),
                                            ),
                                          ])
                                      ])))))));
    });
  }
}

class ViewGradesDialogue extends StatelessWidget {
  ViewGradesDialogue({super.key, required this.subjectInfo});

  final List<dynamic> subjectInfo;
  final enstrepo = Get.put<EnrolledStudentsRepo>(
      EnrolledStudentsRepo(apiClient: Get.find()));
  final scrollController = ScrollController();

  final enrolledStudentController = Get.put<EnrolledStudentsController>(
      EnrolledStudentsController(enrolledStRepo: Get.find()));
  List<TextEditingController> totalMarksController = [];
  final assMarksRepo = Get.put<AssessmentsMarksRepo>(
      AssessmentsMarksRepo(apiClient: Get.find()));
  final assessmenstMarksController = Get.put<AssessmentsMarksController>(
      AssessmentsMarksController(assMarksRepo: Get.find()));
  final columnCount = 8;
  List<DataColumn> _generateColumns() {
    List<DataColumn> columns = [];
    for (int i = 0; i < columnCount; i++) {
      columns.add(
        i == 0
            ? const DataColumn(
                label: Text('Sr.No'),
              )
            : i == 1
                ? const DataColumn(
                    label: Text('Email'),
                  )
                : i == 2
                    ? const DataColumn(
                        label: Text('Student Name'),
                      )
                    : i == 3
                        ? const DataColumn(
                            label: Text('Qno'),
                          )
                        : i == 4
                            ? const DataColumn(
                                label: Text('Total Marks'),
                              )
                            : i == 5
                                ? const DataColumn(
                                    label: Text('Obt. Marks'),
                                  )
                                : i == 6
                                    ? const DataColumn(
                                        label: Text('Objective'),
                                      )
                                    : const DataColumn(
                                        label: Text('Percentage (%)'),
                                      ),
      );
    }
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> listIs = subjectInfo;

    if (listIs.isEmpty) {
      Get.offAllNamed("/studentDashboard");
    }
    return AlertDialog(
        content: Container(
            height: Get.height,
            width: Get.width,
            child: InteractiveViewer(
                scaleEnabled: false,
                child: Scrollbar(
                  controller: scrollController,
                  child: SingleChildScrollView(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: Get.width * 0.90,
                              height: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: const Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red,
                                              size: 40),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            const SizedBox(height: 30),
                            GetBuilder<AssessmentsMarksController>(
                                builder: (assMarksController) {
                              RxList<dynamic> checkAssAdded = listIs.obs;

                              return Expanded(
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: DataTable(
                                          columns: _generateColumns(),
                                          rows: [
                                            for (int i = 0;
                                                i < checkAssAdded.length;
                                                i++)
                                              DataRow(cells: [
                                                DataCell(Text("${i + 1}")),
                                                DataCell(Text(
                                                    checkAssAdded[i].email)),
                                                DataCell(Text(
                                                    checkAssAdded[i].fName)),
                                                DataCell(Text(checkAssAdded[i]
                                                    .qno
                                                    .toString())),
                                                DataCell(Text(checkAssAdded[i]
                                                    .totalMarks
                                                    .toString())),
                                                DataCell(Text(checkAssAdded[i]
                                                    .obtmarks
                                                    .toString())),
                                                DataCell(Text(checkAssAdded[i]
                                                    .objName
                                                    .toString())),
                                                DataCell(
                                                  Text(((checkAssAdded[i]
                                                                  .obtmarks /
                                                              checkAssAdded[i]
                                                                  .totalMarks) *
                                                          100)
                                                      .toString()),
                                                ),
                                              ])
                                          ])));
                            })
                          ])),
                ))));
  }
}
