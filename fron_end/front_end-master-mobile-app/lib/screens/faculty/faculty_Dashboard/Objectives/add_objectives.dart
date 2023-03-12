import 'package:flutter/material.dart';
import 'package:front_end/controllers/controller.dart';
import 'package:front_end/models/course_objectives_model.dart';
import 'package:front_end/screens/faculty/faculty_Dashboard/Objectives/tab_views.dart';
import 'package:front_end/screens/faculty/faculty_Dashboard/Objectives/widgets/objectivebtn.dart';
import 'package:front_end/screens/faculty/faculty_Dashboard/Objectives/widgets/objectiveswidgets.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';

class AddObjectives extends StatefulWidget {
  AddObjectives({Key? key, required this.courseId}) : super(key: key);
  final int courseId;

  @override
  State<AddObjectives> createState() => _AddObjectivesState();
}

class _AddObjectivesState extends State<AddObjectives> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController objTitleController = TextEditingController();

  final TextEditingController outcomeController = TextEditingController();
  final TextEditingController objWeightageController = TextEditingController();

  final TextEditingController bTLevelsController = TextEditingController();
  int totalWeightAdded = 0;

  final courseController = Get.find<CoursesController>();

  final List<String> bloomsTaxonomyLevels = [
    "Level1-Create",
    "Level2-Evaluate",
    "Level3-Analyze",
    "Level4-Apply",
    "Level5-Understand",
    "Level6-Remember"
  ];

  List<String> data = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(children: [
          ObjectivePageField(
            validators: validateAField,
            hintText: "Add Objective ",
            typeKeyboard: TextInputType.text,
            controller: objTitleController,
          ),
          const SizedBox(
            height: 10,
          ),
          ObjectivePageField(
            validators: validateAField,
            hintText: "Add Outcome",
            typeKeyboard: TextInputType.text,
            controller: outcomeController,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 70,
            width: 630,
            child: TextFormField(
                validator: validateAField,
                keyboardType: TextInputType.text,
                controller: bTLevelsController,
                readOnly: true,
                // maxLines: 3,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintText: "Blooms Taxonomy Level (Only Readable)",
                    hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontFamily: 'Poppins',
                        fontSize: 16))),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Select Domain & BT Level",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          GetBuilder<CoursesController>(builder: (courseController) {
            return Container(
              height: 50,
              width: 630,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text(courseController.bTLFilterDropDownPlaceholder),
                  value: courseController.selectedbTLevel,
                  items: courseController.bloomsTaxonomyLevels.map((value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Text(value.toString()),
                      ),
                      onTap: () {
                        courseController.yearFilterDropDownPlaceholder =
                            value.toString();
                      },
                    );
                  }).toList(),
                  onChanged: (value) {
                    courseController.selectedbTLevel = value!.toString();
                    // print(courseController.selectedbTLevel);
                    setState(() {
                      bTLevelsController.text =
                          courseController.selectedbTLevel;
                      if (data.map((e) => e).contains(value)) {
                        data.remove(value);
                      } else {
                        data.add(value);
                      }
                      bTLevelsController.text = data.join(', ');
                    });
                    // data.add(value.toString());
                    // data.map((e) {
                    //   bTLevelsController.text = e.toString();
                    // });
                  },
                ),
              ),
            );
          }),
          const SizedBox(
            height: 20,
          ),
          GetBuilder<CoursesController>(initState: (_) async {
            Future.delayed(Duration.zero).then(
              (value) => courseController.getCourseObjectives(widget.courseId),
            );
          }, builder: (courseController) {
            totalWeightAdded = 0;
            for (var each in courseController.courseObjectives) {
              totalWeightAdded += int.parse(each.objWeightage.toString());
            }

            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Weight Added :: $totalWeightAdded  (%)",
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Weight Left::  ${100 - totalWeightAdded} (%) ",
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ObjectivePageField(
                  validators: validateWeightageField,
                  hintText: "Objective Weightage (%)",
                  typeKeyboard: TextInputType.text,
                  controller: objWeightageController,
                ),
              ],
            );
          }),
          const SizedBox(
            height: 10,
          ),
          GetBuilder<CoursesController>(
            builder: (controller) => ObjBtn(
                title: controller.isLoading ? "Adding" : "Add Objective",
                btnTxtClr: Colors.white,
                btnBgClr: const Color(0xFF175353),
                onTap: () {
                  if (int.parse(objWeightageController.text) != 0 &&
                      int.parse(objWeightageController.text) <=
                          (100 - totalWeightAdded)) {
                    _addCourseObjective();
                  } else {
                    Get.snackbar("Objective Weights are not Valid ",
                        "Objective Weights must be less than or equals to Weight Left",
                        backgroundColor: Colors.red);
                  }
                }),
          ),
          const SizedBox(
            height: 15,
          ),
        ]),
      ),
    );
  }

  _addCourseObjective() async {
    if (_formKey.currentState!.validate()) {
      // if (totalWeightAdded) {}
      CourseObjectivesModel courseObjectivesData = CourseObjectivesModel(
        objName: objTitleController.text.trim().toLowerCase(),
        outcome: outcomeController.text.trim(),
        outcomeBtLevel: bTLevelsController.text,
        courseId: widget.courseId,
        objWeightage: int.parse(objWeightageController.text),
        createdAt: AppUtils.now,
        updatedAt: AppUtils.now,
      );

      courseController.addCourseObjective(courseObjectivesData).then((status) {
        objTitleController.text = "";
        outcomeController.text = "";
        objWeightageController.text = "";
        bTLevelsController.text = "";
        if (status.isSuccesfull) {
          Get.snackbar("Success", status.message);
        } else {
          Get.snackbar("Error Occurred ", status.message);
        }
      });
    }
  }
}
// addCourseObjective