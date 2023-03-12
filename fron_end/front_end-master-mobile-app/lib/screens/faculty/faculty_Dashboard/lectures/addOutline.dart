
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front_end/controllers/lecturesController.dart';
import 'package:front_end/data/repository/lectures_repo.dart';
import 'package:front_end/models/models.dart';
import 'package:front_end/screens/faculty/faculty_Dashboard/lectures/widgets.dart/outlinebtn.dart';
import 'package:get/get.dart';
import '../../../../controllers/controller.dart';
import '../../../../utils/utils.dart';
class AddOutline extends StatelessWidget {
  AddOutline({Key? key}) : super(key: key);

  final repo = Get.put<LecturesRepo>(LecturesRepo(apiClient: Get.find()));
  final lectureController =
      Get.put<LecturesController>(LecturesController(lecRepo: Get.find()));
  final courseController =
      Get.put<CoursesController>(CoursesController(courseRepo: Get.find()));
  // final lecController = Get.find<LecturesController>().getMyLecturesOutline("11");
  final courseId = Get.parameters['courseId'].toString();
  List<CoursesModel> subjectInfo = [];

  final noOfWeeks =
      List<int>.generate(16, (int index) => index + 1, growable: true);
  final TextEditingController bTLevelsController = TextEditingController();
  final TextEditingController courseObjectivesController =
      TextEditingController();

  final TextEditingController topicController = TextEditingController();

  List<String> lecOneorTwo = ['1', '2', '8', '16'];

  var fileToUpload;

  List<String> data = [];
  List<String> objectivesData = [];

  @override
  Widget build(BuildContext context) {
    final courseSession = courseController.myCourses
        .where((e) => e.courseId.toString().contains(courseId.toString()))
        .map((e) => e.session);
    final courseName = courseController.myCourses
        .where((e) => e.courseId.toString().contains(courseId.toString()))
        .map((e) => e.courseName);
    final courseYear = courseController.myCourses
        .where((e) => e.courseId.toString().contains(courseId.toString()))
        .map((e) => e.createdAt.toString());
    Future.delayed(const Duration(seconds: 1)).then((value) {
      courseController.getMyCourses();
      final subjectInfo = courseController.myCourses
          .where((e) => e.courseId.toString().contains(courseId.toString()))
          .toList();
      Future.delayed(Duration.zero).then(
        (value) => courseController.getCourseObjectives(courseId),
      );

      if (subjectInfo.isEmpty) {
        Get.offAllNamed('/');
      }
    });
    return Center(
      child: SingleChildScrollView(
        child: Container(
            color: Colors.grey.shade300,
            width: Get.width,
            padding: const EdgeInsets.all(16),
            // padding: const EdgeInsets.all(20),
            child: GetBuilder<LecturesController>(initState: (_) async {
              Future.delayed(Duration.zero).then(
                (value) => lectureController
                    .getMyLecturesOutline(courseYear.toString()),
              );
            }, builder: (lecController) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Text(
                            lecController.weekDropDownPlaceholder,
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                        value: lecController.weekDropDownPlaceholder,
                        dropdownColor: Colors.white,
                        items: noOfWeeks.map((weeks) {
                    
                          return weeks == 8
                              ? DropdownMenuItem<String>(
                                  value: weeks.toString(),
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 14.0),
                                    child: Text(
                                      "Mid Term",
                                      style: TextStyle(fontFamily: 'Poppins'),
                                    ),
                                  ),
                                  onTap: () {
                                    lecController.weekDropDownPlaceholder =
                                        weeks.toString();
                                  },
                                )
                              : weeks == 16
                                  ? DropdownMenuItem<String>(
                                      value: weeks.toString(),
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 14.0),
                                        child: Text(
                                          "Final Term",
                                          style:
                                              TextStyle(fontFamily: 'Poppins'),
                                        ),
                                      ),
                                      onTap: () {
                                        lecController.weekDropDownPlaceholder =
                                            weeks.toString();
                                      },
                                    )
                                  : DropdownMenuItem<String>(
                                      value: weeks.toString(),
                                      child: weeks == 8
                                          ? const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 14.0),
                                              child: Text("Mid Term",
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins')),
                                            )
                                          : weeks == 16
                                              ? const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 14.0),
                                                  child: Text(
                                                    "Final Term",
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins'),
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 14.0),
                                                  child: Text(
                                                    "Week  ${weeks.toString()}",
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins'),
                                                  ),
                                                ),
                                      onTap: () {
                                        lecController.weekDropDownPlaceholder =
                                            weeks.toString();
                                      },
                                    );
                        }).toList(),
                        onChanged: (value) {
                          lecController.selectedWeek = value.toString();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Text(
                            lecController.lecDropDownPlaceholder,
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                        value: lecController.lecDropDownPlaceholder,
                        dropdownColor: Colors.white,
                        items: lecOneorTwo.map((lec) {
                          return DropdownMenuItem<String>(
                            value: lec.toString(),
                            child: lec.toString() == "8"
                                ? const Padding(
                                    padding: EdgeInsets.only(left: 14.0),
                                    child: Text("Mid Term",
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                  )
                                : lec.toString() == "16"
                                    ? const Padding(
                                        padding: EdgeInsets.only(left: 14.0),
                                        child: Text("Final Term",
                                            style: TextStyle(
                                                fontFamily: 'Poppins')),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14.0),
                                        child: Text("Lec # ${lec.toString()}",
                                            style: const TextStyle(
                                                fontFamily: 'Poppins')),
                                      ),
                            onTap: () {
                              lecController.lecDropDownPlaceholder =
                                  lec.toString();
                            },
                          );
                        }).toList(),
                        onChanged: (value) {
                          lecController.selectedLec = value.toString();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      lecController.myLecturesOutline
                              .where((weeksofoutline) {
                                return weeksofoutline.weeks.toString().contains(
                                    lecController.selectedWeek.toString());
                              })
                              .where((weeksofoutline) => weeksofoutline.lectNo.toString().contains(
                                  lecController.selectedLec.toString()))
                              .where((subjectName) => subjectName.subject
                                  .toString()
                                  .toLowerCase()
                                  .contains(courseName
                                      .toString()
                                      .toLowerCase()
                                      .replaceAll(RegExp(r"\(|\)"), "")))
                              .where((session) => session.session
                                  .toString()
                                  .toLowerCase()
                                  .contains(courseSession
                                      .toString()
                                      .toLowerCase()
                                      .replaceAll(RegExp(r"\(|\)"), "")))
                              .isEmpty
                          ? _uploadFile()
                          : Get.snackbar("Already Exits", "File in this week and lecture already Exits !",
                              backgroundColor: Colors.red);
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.only(left: 14.0),
                              child: Text(lecController.fileName.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontSize: 16)),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                            width: 30,
                            child: Icon(
                              Icons.file_copy_sharp,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: TextFormField(
                      validator: validateAField,
                      keyboardType: TextInputType.text,
                      controller: topicController,
                      // readOnly: true,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 14),
                        focusColor: Colors.white,
                        hintStyle: TextStyle(fontFamily: 'Poppins'),
                        hintText:
                            "Add Related Topics if multiple add comma's(,) between",
                      ),
                    ),
                  ),
                  // Select Objectives DROPDOWN ENDS
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: TextFormField(
                          validator: validateAField,
                          keyboardType: TextInputType.text,
                          controller: courseObjectivesController,
                          readOnly: true,
                          // maxLines: 2,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 14),
                            focusColor: Colors.white,
                            hintStyle: TextStyle(fontFamily: 'Poppins'),
                            hintText: "Select Objectives for this outline",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      GetBuilder<CoursesController>(
                          builder: (courseController) {
                        var firstObj;
                        courseController.courseObjectives.isNotEmpty
                            ? firstObj =
                                courseController.courseObjectives[0].objName
                            : firstObj = "Nothing Found";

                        // final firstObj = courseController.courseObjectives
                        //     .map((element) => element.objName)
                        //     .toString()
                        //     .replaceAll(RegExp(r"\(|\)"), '');

                        courseController.setSelectedObjectivesObs = firstObj;

                        return courseController.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : courseController.courseObjectives.isEmpty
                                ? const Center(
                                    child: Text(
                                      "Nothing Found !",
                                      style: TextStyle(fontFamily: 'Poppins'),
                                    ),
                                  )
                                : Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black, width: 1.5),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 14.0),
                                          child: Text(courseController
                                              .selectedObjectivesObsPlaceholder),
                                        ),
                                        value: courseController
                                            .selectedObjectivesObs,
                                        // HERE

                                        items: courseController.courseObjectives
                                            .map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value.objName
                                                .toString()
                                                .replaceAll(
                                                    RegExp(r"\(|\)"), ''),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 14.0),
                                              child: Text(value.objName
                                                  .toString()
                                                  .replaceAll(
                                                      RegExp(r"\(|\)"), '')),
                                            ),
                                            onTap: () {
                                              courseController
                                                      .selectedObjectivesObsPlaceholder =
                                                  value.toString();
                                            },
                                          );
                                        }).toList(),

                                        onChanged: (value) {
                                          courseController
                                                  .setSelectedObjectivesObs =
                                              value!.toString();
                                          // print(courseController.selectedbTLevel);

                                          courseObjectivesController.text =
                                              courseController
                                                  .selectedObjectivesObs;
                                          if (objectivesData
                                              .map((e) => e)
                                              .contains(value)) {
                                            objectivesData.remove(value);
                                          } else {
                                            objectivesData.add(value);
                                          }
                                          courseObjectivesController.text =
                                              objectivesData.join(', ');

                                          // data.add(value.toString());
                                          // data.map((e) {
                                          //   bTLevelsController.text = e.toString();
                                          // });
                                        },
                                      ),
                                    ),
                                  );
                      }),

                      // BT LEVEL DROPDOWN ENDS
                    ],
                  ),
                  const SizedBox(height: 20),

                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: TextFormField(
                          validator: validateAField,
                          keyboardType: TextInputType.text,
                          controller: bTLevelsController,
                          readOnly: true,
                          // maxLines: 2,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusColor: Colors.white,
                            hintStyle: TextStyle(fontFamily: 'Poppins'),
                            hintText: "Select Blooms Taxonomy Levels",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      GetBuilder<CoursesController>(
                          builder: (courseController) {
                        return Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Text(courseController
                                    .selectedbTLevelObsPlaceholder),
                              ),
                              value: courseController.selectedbTLevelObs,
                              items: courseController.bloomsTaxonomyLevels
                                  .map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Text(value.toString()),
                                  ),
                                  onTap: () {
                                    courseController
                                            .selectedbTLevelObsPlaceholder =
                                        value.toString();
                                  },
                                );
                              }).toList(),
                              onChanged: (value) {
                                courseController.setSelectedbTLevelObs =
                                    value!.toString();
                                // print(courseController.selectedbTLevel);

                                bTLevelsController.text =
                                    courseController.selectedbTLevelObs;
                                if (data.map((e) => e).contains(value)) {
                                  data.remove(value);
                                } else {
                                  data.add(value);
                                }
                                bTLevelsController.text = data.join(', ');

                                // data.add(value.toString());
                                // data.map((e) {
                                //   bTLevelsController.text = e.toString();
                                // });
                              },
                            ),
                          ),
                        );
                      }),

                      // BT LEVEL DROPDOWN ENDS
                    ],
                  ),
                  const SizedBox(height: 30),

                  GetBuilder<LecturesController>(
                    builder: (controller) => OutlineBtn(
                        hight: 50,
                        width: MediaQuery.of(context).size.width * 0.5,
                        title: controller.isLoading ? "Adding" : "Add ",
                        btnTxtClr: Colors.white,
                        btnBgClr: Colors.amber,
                        onTap: () {
                          final week = lecController.selectedWeek;
                          final lecNo = lecController.selectedLec;
                          if (week == "8" && lecNo != "8") {
                            Get.snackbar("Invalid Selection",
                                "Mid is Selected in weeks ! Select Mid in lectures DropDown ");
                          } else if (week == "16" && lecNo != "16") {
                            Get.snackbar("Invalid Selection",
                                "Final is Selected in weeks ! Select Final in lectures DropDown ");
                          } else if (lecNo == "16" && week != "16") {
                            Get.snackbar("Invalid Selection",
                                "Final is Selected in lectures ! Select Final in Weeks DropDown ");
                          } else if (lecNo == "8" && week != "8") {
                            Get.snackbar("Invalid Selection",
                                "Mid is Selected in lectures ! Select Mid in Weeks DropDown  ");
                          } else if (topicController.text.isEmpty ||
                              bTLevelsController.text.isEmpty) {
                            Get.snackbar("All Fields are Mendatory",
                                "All fields are required ! ");
                          } else {
                            _saveToServer(week, lecNo);
                          }
                        }),
                  ),
                  const SizedBox(height: 30),
                ],
              );
            })),
      ),
    );
  }

  _uploadFile() {
    final file = _pickFile();
    return file;
  }

  _pickFile() async {
    if (kIsWeb) {
      try {
        final _pickedFile = (await (FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'docx'],
        )))
            ?.files;
        if (_pickedFile != null) {
          final pickedFileName = _pickedFile.first.name;

          lectureController.fileName = pickedFileName;
          fileToUpload = _pickedFile.first.bytes;
          return _pickedFile.first.bytes;
          // return _pickedFile;
        } else {
          Get.snackbar(
            "Process Failed ",
            "Select a File to Upload !",
            backgroundColor: Colors.red,
          );
          // return null;
        }
      } catch (e) {
        print("Error while picking a file in try catch");
      }
    }
  }

  _saveToServer(String week, String lecNo) {
    String fileName = lectureController.fileName;
    if (fileToUpload == null) {
      Get.snackbar("File is not selected", "Select a File to Upload !");
    } else {
      final relatedTopic = topicController.text;
      final btLevel = bTLevelsController.text;
      final objectives = courseObjectivesController.text;

      final lecDocFile = FormData({
        "file": MultipartFile(fileToUpload, filename: fileName),
      });
      final courseSession = courseController.myCourses
          .where((e) => e.courseId.toString().contains(courseId.toString()))
          .map((e) => e.session);
      final courseName = courseController.myCourses
          .where((e) => e.courseId.toString().contains(courseId.toString()))
          .map((e) => e.courseName);
      lectureController.uploadNewLecFile(lecDocFile).then((status) {
        if (status.isSuccesfull) {
          var fileName = status.message;

          LecturesModel lecInfo = LecturesModel(
            lectNo: int.parse(lecNo),
            session: courseSession.toString().replaceAll(RegExp(r"\(|\)"), ""),
            subject: courseName.toString().replaceAll(RegExp(r"\(|\)"), ""),
            weeks: int.parse(week),
            file: fileName,
            relatedTopic: relatedTopic,
            btLevel: btLevel,
            courseObj: objectives,
            createdAt: AppUtils.now,
            updatedAt: AppUtils.now,
          );

          lectureController.uploadFileRecToDB(lecInfo).then((status) {
            if (status.isSuccesfull) {
              Get.snackbar("Success", status.message);
              Get.toNamed(Uri.base.toString());
            } else {
              Get.snackbar("Error Occurred ", status.message);
            }
          });
        } else {
          Get.snackbar("Error Occurred ", status.message);
        }
      });
    }
  }
}
