import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/controller.dart';
import '../../../../models/models.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';

class ViewObjectives extends StatelessWidget {
  ViewObjectives({
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CoursesController>(initState: (_) async {
        Future.delayed(Duration.zero).then(
          (value) => courseController.getCourseObjectives(courseId),
        );
      }, builder: (courseController) {
        for (int i = 0; i < courseController.courseObjectives.length; i++) {
          // if (courseController.courseObjectives[i].quiz.toString() == "null") {
          controllers.add(TextEditingController());
          assignemntsController.add(TextEditingController());
          presentationController.add(TextEditingController());
          projectController.add(TextEditingController());
          // }
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
                                              label: Text('Objective Name'),
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
                                                    : Text(
                                                        courseController
                                                            .courseObjectives[i]
                                                            .quiz
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.grey),
                                                      )),
                                                DataCell(courseController
                                                            .courseObjectives[i]
                                                            .assignment
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

  void _uploadObjectiveBreakdownStructure(int objId) {
    List<CourseObjectivesModel> _data = [];
    for (int i = 0; i < controllers.length; i++) {}
  }

  Future<dynamic> addOutcomeMethod(e, objId) {
    return Get.dialog(
      //Add ROles Dialog
      Dialog(
          child: SizedBox(
        width: Get.width * 0.40,
        height: Get.height * 0.70,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.cancel_outlined,
                            color: Colors.red, size: 40),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: Text("Add OutComes For ${e.objName}",
                      style: const TextStyle(fontSize: 24),
                      textAlign: TextAlign.center),
                ),
                const SizedBox(height: 20),
                UserTypePageField(
                  controller: outComeTitleController,
                  hintText: "OutCome Title",
                  typeKeyboard: TextInputType.text,
                  validators: validateAField,
                ),
                const SizedBox(height: 20),
                UserTypePageField(
                  controller: outComeDescController,
                  hintText: "OutCome Desc ",
                  typeKeyboard: TextInputType.text,
                  validators: validateAField,
                ),
                const SizedBox(height: 30),
                GetBuilder<CoursesController>(
                  builder: (controller) => controller.isLoading
                      ? CustomButton(
                          title: "Adding ..",
                          btnTxtClr: Colors.white,
                          btnBgClr: Colors.purple,
                          onTap: () {})
                      : CustomButton(
                          title: "Add Outcome",
                          btnTxtClr: Colors.white,
                          btnBgClr: Colors.purple,
                          onTap: () {
                            _addOutCome(objId);
                          }),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      )),
    );
  }

  _addOutCome(objId) {
    if (_formKey.currentState!.validate()) {
      var data = {
        'objId': objId,
        'outcomeTitle': outComeTitleController.text,
        'outComeDesc': outComeDescController.text,
        'created_at': AppUtils.now,
        'updated_at': AppUtils.now,
      };
      // addCourseOutcomes
      courseController.addCourseOutcomes(data).then((status) {
        outComeTitleController.text = "";
        outComeDescController.text = "";
        if (status.isSuccesfull) {
          Get.back();
          Get.snackbar("Success", status.message);
        } else {
          Get.snackbar("Error Occurred ", status.message);
        }
      });
    }
  }
}
