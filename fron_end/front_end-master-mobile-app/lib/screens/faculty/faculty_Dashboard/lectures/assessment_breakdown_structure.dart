import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../controllers/controller.dart';
import '../../../../data/repository/assessments_repo.dart';
import '../../../../data/repository/enrolled_students_repo.dart';
import '../../../../data/repository/repository.dart';
import '../../../../models/models.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';

class AssessmentBreakdownStructure extends StatelessWidget {
  AssessmentBreakdownStructure({
    Key? key,
    required this.courseId,
  }) : super(key: key);
  final int courseId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController outComeTitleController = TextEditingController();
  final TextEditingController outComeDescController = TextEditingController();
  final scrollController = ScrollController();
  List<TextEditingController> controllers = [];
  List<TextEditingController> assignemntsController = [];
  List<TextEditingController> presentationController = [];
  List<TextEditingController> projectController = [];
  bool showAddButton = false;
  final courseController =
      Get.put<CoursesController>(CoursesController(courseRepo: Get.find()));
  final userAuthController = Get.find<UserAuthController>();
  List<String> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CoursesController>(initState: (_) async {
        Future.delayed(Duration.zero).then(
          (value) => courseController.getCourseObjectives(courseId),
        );
      }, builder: (courseController) {
        for (int i = 0; i < courseController.courseObjectives.length; i++) {
          controllers.add(TextEditingController());
          assignemntsController.add(TextEditingController());
          presentationController.add(TextEditingController());
          projectController.add(TextEditingController());
        }
        for (int i = 0; i < courseController.courseObjectives.length; i++) {
          if (courseController.courseObjectives[i].quiz.toString() == "null") {
            showAddButton = true;
          } else {
            showAddButton = false;
          }
        }
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
                              : Form(
                                  key: _formKey,
                                  child: Column(
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
                                              label: Text('Assessment Type'),
                                            ),
                                            DataColumn(
                                              label: Text('Outcome'),
                                            ),
                                            DataColumn(
                                              label: Text('Weightage'),
                                            ),
                                            DataColumn(
                                              label: Text('Quizes'),
                                            ),
                                            DataColumn(
                                              label: Text('Assignments'),
                                            ),
                                            DataColumn(
                                              label: Text('Presentations'),
                                            ),
                                            DataColumn(
                                              label: Text('Project'),
                                            ),
                                            DataColumn(
                                              label: Text('Add Breakdown'),
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
                                                    ? TextFormField(
                                                        controller:
                                                            controllers[i],
                                                        validator:
                                                            validateAField,
                                                        decoration: const InputDecoration(
                                                            hintText:
                                                                'Add Quizes',
                                                            hintStyle: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .grey)),
                                                      )
                                                    : GestureDetector(
                                                        onTap: () {
                                                          int total = 0;
                                                          total += int.parse(
                                                              courseController
                                                                  .courseObjectives[
                                                                      i]
                                                                  .quiz
                                                                  .toString());
                                                        },
                                                        child: Text(
                                                          courseController
                                                              .courseObjectives[
                                                                  i]
                                                              .quiz
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      )),
                                                DataCell(courseController
                                                            .courseObjectives[i]
                                                            .objId
                                                            .toString() ==
                                                        "null"
                                                    ? TextFormField(
                                                        controller:
                                                            assignemntsController[
                                                                i],
                                                        validator:
                                                            validateAField,
                                                        decoration: const InputDecoration(
                                                            hintText:
                                                                'Add Assignments',
                                                            hintStyle: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .grey)),
                                                      )
                                                    : Text(
                                                        courseController
                                                            .courseObjectives[i]
                                                            .assignment
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.grey),
                                                      )),
                                                DataCell(courseController
                                                            .courseObjectives[i]
                                                            .presentation
                                                            .toString() ==
                                                        "null"
                                                    ? TextFormField(
                                                        controller:
                                                            presentationController[
                                                                i],
                                                        validator:
                                                            validateAField,
                                                        decoration: const InputDecoration(
                                                            hintText:
                                                                'Add Presentation',
                                                            hintStyle: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .grey)),
                                                      )
                                                    : Text(
                                                        courseController
                                                            .courseObjectives[i]
                                                            .presentation
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.grey),
                                                      )),
                                                DataCell(courseController
                                                            .courseObjectives[i]
                                                            .project
                                                            .toString() ==
                                                        "null"
                                                    ? TextFormField(
                                                        controller:
                                                            projectController[
                                                                i],
                                                        validator:
                                                            validateAField,
                                                        decoration: const InputDecoration(
                                                            hintText:
                                                                'Add Project',
                                                            hintStyle: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .grey)),
                                                      )
                                                    : Text(
                                                        courseController
                                                            .courseObjectives[i]
                                                            .project
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.grey),
                                                      )),
                                                DataCell(TextButton(
                                                    onPressed: () {
                                                      print("pressed");
                                                      print(
                                                          "Plo is is   ${courseController.courseObjectives[i].objId}   ");
                                                      Get.dialog(
                                                        MyDataTable(
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
                                                        ),
                                                      );
                                                    },
                                                    child: const Text(
                                                      "Add",
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'Poppins',
                                                          color: Colors.grey),
                                                    ))),
                                              ])
                                          ]),
                                      const SizedBox(height: 30),
                                      showAddButton == true
                                          ? CustomTextButton(
                                              title: "Add",
                                              onTap: () {
                                                List<CourseObjectivesModel>
                                                    _data = [];
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  for (int i = 0;
                                                      i <
                                                          courseController
                                                              .courseObjectives
                                                              .length;
                                                      i++) {
                                                    if (courseController
                                                            .courseObjectives[i]
                                                            .quiz
                                                            .toString() ==
                                                        "null") {
                                                      final objId =
                                                          courseController
                                                              .courseObjectives[
                                                                  i]
                                                              .objId;
                                                      final quiz =
                                                          controllers[i].text;
                                                      final assignment =
                                                          assignemntsController[
                                                                  i]
                                                              .text;
                                                      final presentation =
                                                          presentationController[
                                                                  i]
                                                              .text;
                                                      final project =
                                                          projectController[i]
                                                              .text;
                                                      _data = [
                                                        CourseObjectivesModel(
                                                          objId: objId,
                                                          quiz: int.parse(quiz),
                                                          presentation:
                                                              int.parse(
                                                                  presentation),
                                                          project: int.parse(
                                                              project),
                                                          assignment: int.parse(
                                                              assignment),
                                                          createdAt:
                                                              AppUtils.now,
                                                          updatedAt:
                                                              AppUtils.now,
                                                        )
                                                      ];
                                                      if (quiz.isNotEmpty) {
                                                        courseController
                                                            .addCourseObjectiveBreakdown(
                                                                _data)
                                                            .then((status) {
                                                          if (status
                                                              .isSuccesfull) {
                                                            //  Get.snackbar("Success", status.message);
                                                            Get.toNamed(Uri.base
                                                                .toString());
                                                          } else {
                                                            Get.snackbar(
                                                                "Error Occured",
                                                                status.message);
                                                          }
                                                        });
                                                      } else {
                                                        print("Quiz is empty");
                                                      }
                                                    }
                                                  }
                                                } else {
                                                  Get.snackbar(
                                                      "TextFields are Empty !",
                                                      "All the Text Fields are required !",
                                                      backgroundColor:
                                                          Colors.red);
                                                }
                                              },
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                            )
                                          : Text(""),
                                    ],
                                  ),
                                ),
                    ),
                  ),
                ),
              ),
            ));
      }),
    );
  }
}

class MyDataTable extends StatefulWidget {
  CourseObjectivesModel assesmentTypes;
  String coursObjectives;
  int ploId;
  // int assessmentId;
  MyDataTable({
    super.key,
    required this.assesmentTypes,
    required this.coursObjectives,
    required this.ploId,
  });

  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  final scrollController = ScrollController();
  bool questionsAdded = false;
  final enstrepo = Get.put<EnrolledStudentsRepo>(
      EnrolledStudentsRepo(apiClient: Get.find()));

  final enrolledStudentController = Get.put<EnrolledStudentsController>(
      EnrolledStudentsController(enrolledStRepo: Get.find()));
  List<TextEditingController> totalMarksController = [];
  final assRepo =
      Get.put<AssessmentsRepo>(AssessmentsRepo(apiClient: Get.find()));
  final assController = Get.put<AssessmentsController>(
      AssessmentsController(assRepo: Get.find()));
  final TextEditingController bTLevelsController = TextEditingController();
  List<DataModel> assessmentBreakdownData = [];
  List<String> _selectedDropDown = ["", ""];
  List<List<TextEditingController>> _controllers = [];
  // var noOfRows;
  int _rows = 0;
  int _cols = 3;

  void _addRow() {
    setState(() {
      _controllers
          .add(List.generate(_cols, (index) => TextEditingController()));
      _rows++;
    });
  }

  void _addColumn() {
    totalMarksController.add(TextEditingController());
    setState(() {
      for (int i = 0; i < _rows; i++) {}
      _cols++;
    });
  }

  void _removeColumn() {
    totalMarksController.removeLast();
    setState(() {
      for (int i = 0; i < _rows; i++) {}
      _cols--;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<AssessmentsController>(
                builder: (controller) => TextButton(
                  child: Text(
                      controller.isLoading ? "Adding ..." : "Add Question ",
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: controller.isLoading
                      ? null
                      : () {
                          _addColumn();
                        },
                  style: TextButton.styleFrom(
                      backgroundColor: controller.isLoading
                          ? Colors.grey
                          : Color(0xFF175353)),
                ),
              ),
              GetBuilder<AssessmentsController>(
                builder: (controller) => TextButton(
                  child: Text(
                      controller.isLoading
                          ? "Removing ..."
                          : "Remove Question ",
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: controller.isLoading
                      ? null
                      : () {
                          _removeColumn();
                        },
                  style: TextButton.styleFrom(
                      backgroundColor: controller.isLoading
                          ? Colors.grey
                          : Color.fromARGB(255, 83, 23, 23)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                onTap: () {
                  Get.back();
                },
                title: "Cancel",
                backgroundColor: Colors.red,
                textColor: Colors.white,
              ),
              CustomTextButton(
                onTap: () {
                  _printValues();
                },
                title: "Save",
                backgroundColor: Colors.green,
                textColor: Colors.white,
              ),
            ],
          ),
        ],
        content: Container(
            height: Get.height,
            width: Get.width,
            child: InteractiveViewer(
                scaleEnabled: false,
                // child: MyDataTable(),
                child: Scrollbar(
                    controller: scrollController,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Row(
                              // children: courseController.myCourses.map((e) => Text(e.courseName.where((h) => h.courseId.toString().contains(courseId.toString()).toString()))).toList()
                              children: [
                                Text(widget.coursObjectives,
                                    style: const TextStyle(
                                        fontFamily: 'Dongle',
                                        fontSize: 30,
                                        color: Colors.purple))
                              ]),
                          const SizedBox(height: 30),
                          GetBuilder<EnrolledStudentsController>(
                              initState: (_) {
                            Future.delayed(const Duration(seconds: 0))
                                .then((value) {
                              enrolledStudentController.getallEnrolledSudents();
                            });
                          }, builder: (stController) {
                            int totalNo = 0;
                            int totalQuiz = 0;
                            int totalAssignment = 0;
                            int totalPpt = 0;
                            int totalProject = 0;
                            totalNo = widget.assesmentTypes.quiz! +
                                widget.assesmentTypes.assignment! +
                                widget.assesmentTypes.presentation! +
                                widget.assesmentTypes.project!;
                            totalQuiz = widget.assesmentTypes.quiz!;
                            totalAssignment = widget.assesmentTypes.assignment!;
                            totalPpt = widget.assesmentTypes.presentation!;
                            totalProject = widget.assesmentTypes.project!;
                            return Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: DataTable(
                                    columns: List.generate(
                                      _cols,
                                      (index) => index == 0
                                          ? const DataColumn(
                                              label: Text('Assessment type'))
                                          : DataColumn(
                                              label: Text("Qno ${index}")),
                                    ),
                                    rows: [
                                      for (int i = 0; i < totalQuiz; i++)
                                        DataRow(
                                          cells:
                                              List.generate(_cols, (colIndex) {
                                            return colIndex == 0
                                                ? DataCell(
                                                    Text("Quiz ${i + 1}"))
                                                : DataCell(
                                                    GetBuilder<
                                                            CoursesController>(
                                                        builder:
                                                            (courseController) {
                                                      return DropdownButton<
                                                          String>(
                                                        items: courseController
                                                            .bloomsTaxonomyLevels
                                                            .map((value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value
                                                                .toString()),
                                                          );
                                                        }).toList(),
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            DataModel
                                                                dataModel =
                                                                DataModel(
                                                              assessmentType:
                                                                  "Quiz ${i + 1}",
                                                              bloomTaxonomyLevel:
                                                                  newValue!,
                                                              questionNumber:
                                                                  colIndex,
                                                              ploId:
                                                                  widget.ploId,
                                                              objective: widget
                                                                  .coursObjectives,
                                                            );
                                                            assessmentBreakdownData
                                                                .add(dataModel);
                                                          });
                                                          print(
                                                              "ass breakdown Data = $assessmentBreakdownData");

                                                          print(
                                                              "ass breakdown Data = ${assessmentBreakdownData.length}");
                                                        },
                                                      );
                                                    }),
                                                  );
                                          }),
                                        ),
                                      for (int i = 0; i < totalAssignment; i++)
                                        DataRow(
                                          cells:
                                              List.generate(_cols, (colIndex) {
                                            return colIndex == 0
                                                ? DataCell(Text(
                                                    "Assignement ${i + 1}"))
                                                : DataCell(
                                                    GetBuilder<
                                                            CoursesController>(
                                                        builder:
                                                            (courseController) {
                                                      return DropdownButton<
                                                          String>(
                                                        items: courseController
                                                            .bloomsTaxonomyLevels
                                                            .map((value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value
                                                                .toString()),
                                                          );
                                                        }).toList(),
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            DataModel
                                                                dataModel =
                                                                DataModel(
                                                              assessmentType:
                                                                  "Assignment ${i + 1}",
                                                              bloomTaxonomyLevel:
                                                                  newValue!,
                                                              questionNumber:
                                                                  colIndex,
                                                              ploId:
                                                                  widget.ploId,
                                                              objective: widget
                                                                  .coursObjectives,
                                                            );
                                                            assessmentBreakdownData
                                                                .add(dataModel);
                                                          });
                                                          print(
                                                              "ass breakdown Data = $assessmentBreakdownData");

                                                          print(
                                                              "ass breakdown Data = ${assessmentBreakdownData.length}");
                                                        },
                                                      );
                                                    }),
                                                  );
                                          }),
                                        ),
                                      for (int i = 0; i < totalPpt; i++)
                                        DataRow(
                                          cells:
                                              List.generate(_cols, (colIndex) {
                                            return colIndex == 0
                                                ? DataCell(Text(
                                                    "Presentation ${i + 1}"))
                                                : DataCell(
                                                    GetBuilder<
                                                            CoursesController>(
                                                        builder:
                                                            (courseController) {
                                                      return DropdownButton<
                                                          String>(
                                                        items: courseController
                                                            .bloomsTaxonomyLevels
                                                            .map((value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value
                                                                .toString()),
                                                          );
                                                        }).toList(),
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            DataModel
                                                                dataModel =
                                                                DataModel(
                                                              assessmentType:
                                                                  "Presentation ${i + 1}",
                                                              bloomTaxonomyLevel:
                                                                  newValue!,
                                                              questionNumber:
                                                                  colIndex,
                                                              ploId:
                                                                  widget.ploId,
                                                              objective: widget
                                                                  .coursObjectives,
                                                            );
                                                            assessmentBreakdownData
                                                                .add(dataModel);
                                                          });
                                                          print(
                                                              "ass breakdown Data = $assessmentBreakdownData");

                                                          print(
                                                              "ass breakdown Data = ${assessmentBreakdownData.length}");
                                                        },
                                                      );
                                                    }),
                                                  );
                                          }),
                                        ),
                                      for (int i = 0; i < totalProject; i++)
                                        DataRow(
                                          cells:
                                              List.generate(_cols, (colIndex) {
                                            return colIndex == 0
                                                ? DataCell(
                                                    Text("Project ${i + 1}"))
                                                : DataCell(
                                                    GetBuilder<
                                                            CoursesController>(
                                                        builder:
                                                            (courseController) {
                                                      return DropdownButton<
                                                          String>(
                                                        items: courseController
                                                            .bloomsTaxonomyLevels
                                                            .map((value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value
                                                                .toString()),
                                                          );
                                                        }).toList(),
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            DataModel
                                                                dataModel =
                                                                DataModel(
                                                              assessmentType:
                                                                  "Project ${i + 1}",
                                                              bloomTaxonomyLevel:
                                                                  newValue!,
                                                              questionNumber:
                                                                  colIndex,
                                                              ploId:
                                                                  widget.ploId,
                                                              objective: widget
                                                                  .coursObjectives,
                                                            );
                                                            assessmentBreakdownData
                                                                .add(dataModel);
                                                          });
                                                          print(
                                                              "ass breakdown Data = $assessmentBreakdownData");

                                                          print(
                                                              "ass breakdown Data = ${assessmentBreakdownData.length}");
                                                        },
                                                      );
                                                    }),
                                                  );
                                          }),
                                        )
                                    ]),
                              ),
                            );
                          })
                        ],
                      ),
                    )))));
  }

  void _printValues() {
    bool done = false;
    for (int i = 0; i < assessmentBreakdownData.length; i++) {
      print("type no is ${assessmentBreakdownData[i].assessmentType}");
      // print("data is ${assessmentBreakdownData[i].bloomTaxonomyLevel}");
      print("qno is ${assessmentBreakdownData[i].questionNumber}");
      assController
          .addAssessmentBreakdown(assessmentBreakdownData.toList())
          .then((status) {});
    }
  }
}
