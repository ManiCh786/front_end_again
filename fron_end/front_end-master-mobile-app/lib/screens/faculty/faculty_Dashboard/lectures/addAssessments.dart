import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../controllers/controller.dart';
import '../../../../controllers/lecturesController.dart';
import '../../../../data/repository/assessments_repo.dart';
import '../../../../data/repository/lectures_repo.dart';
import '../../../../data/repository/repository.dart';
import '../../../../models/models.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';

class AddAssessments extends StatelessWidget {
  AddAssessments({super.key});

  final scrollController = ScrollController();
  final TextEditingController topicController = TextEditingController();
  final TextEditingController bTLevelsController = TextEditingController();
  final TextEditingController courseObjectivesController =
      TextEditingController();
  var fileToUploadForOutline;

  List<String> data = [];
  List<String> objectivesData = [];
  final repo = Get.put<LecturesRepo>(LecturesRepo(apiClient: Get.find()));
  final lectureController =
      Get.put<LecturesController>(LecturesController(lecRepo: Get.find()));
  final courseController =
      Get.put<CoursesController>(CoursesController(courseRepo: Get.find()));
  final assRepo =
      Get.put<AssessmentsRepo>(AssessmentsRepo(apiClient: Get.find()));
  final assController = Get.put<AssessmentsController>(
      AssessmentsController(assRepo: Get.find()));
  final assMarksRepo = Get.put<AssessmentsMarksRepo>(
      AssessmentsMarksRepo(apiClient: Get.find()));
  final assessmenstMarksController = Get.put<AssessmentsMarksController>(
      AssessmentsMarksController(assMarksRepo: Get.find()));

  final courseId = Get.parameters['courseId'].toString();
  List<CoursesModel> subjectInfo = [];
  var fileToUpload;

  final noOfWeeks =
      List<int>.generate(16, (int index) => index + 1, growable: true);
  final List<DataColumn> _columns = [
    const DataColumn(
        label: Text(
          "Weeks",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Poppins', fontSize: 16),
        ),
        tooltip: "Represents Weeks of the Semester"),
    const DataColumn(
        label: Text("Lecture",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Poppins', fontSize: 16)),
        tooltip: "Represents Lectures of the Semester"),
    const DataColumn(
        label: Text("Topics",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Poppins', fontSize: 16)),
        tooltip: "Represents Topics of the Semester"),
    const DataColumn(
        label: Text("Lecture File",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Poppins', fontSize: 16)),
        tooltip: "Upload a file of Outline"),
    const DataColumn(
        label: Text("BT Level",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Poppins', fontSize: 16)),
        tooltip: "Represents BT Level of the Semester"),
    const DataColumn(
        label: Text("Course Objectives",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Poppins', fontSize: 16)),
        tooltip: "Represents Course Objectives of the Semester"),
    const DataColumn(
        label: Text("Assessments",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Poppins', fontSize: 16)),
        tooltip: "Represents Assessments of the Semester"),
  ];
  callFunction() {
    lectureController.getMyLecturesOutlineStream();
    return;
  }

  @override
  Widget build(BuildContext context) {
    final subjectInfo = courseController.myCourses
        .where((e) => e.courseId.toString().contains(courseId.toString()))
        .toList();

    final courseNameToSearch = subjectInfo
        .map((e) => e.courseName)
        .toString()
        .replaceAll(RegExp(r"\(|\)"), "");
    final session = subjectInfo
        .map((e) => e.session)
        .toString()
        .replaceAll(RegExp(r"\(|\)"), "");
    // final weekNo = subjectInfo.map((e) => e.weekNo);
    final createdAt = subjectInfo
        .map((e) => e.createdAt)
        .toString()
        .replaceAll(RegExp(r"\(|\)"), "");

    // Future.delayed(const Duration(seconds: 1)).then((value) {
    //   callFunction();
    // });

    return Scaffold(
      body: GetBuilder<LecturesController>(initState: (_) {
        Future.delayed(const Duration(seconds: 1)).then((value) {
          lectureController.getMyLecturesOutlineStream();
        });
      }, builder: (lecController) {
        var yearFilter = DateTime.now().year.toString().obs;
        RxList<dynamic> list = [].obs;
        final currentUserId = Get.find<UserAuthController>().getUserId();
        list = lecController.myLecturesOutlineObx
            .where((e) =>
                e.session.toString().toLowerCase().contains(session) &&
                e.createdAt.toString().toLowerCase().contains(yearFilter))
            .where((e) {
              return e.subject
                  .toString()
                  .toLowerCase()
                  .contains(courseNameToSearch.toLowerCase());
            })
            .where((e) => e.addedBy == currentUserId)
            .toList()
            .obs;
        return lecController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : list.isEmpty
                ? const Center(
                    child: Text("Nothing to Show Here !"),
                  )
                : Container(
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
                            child: DataTable(
                                showBottomBorder: true,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 1, color: Colors.deepPurple)),
                                dataTextStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Poppins',
                                    fontSize: 14),
                                dataRowHeight: 100,
                                columnSpacing: 40,
                                dividerThickness: 2,
                                sortAscending: true,
                                columns: _columns,
                                rows: [
                                  for (var i = 0; i < list.length; i++)
                                    DataRow(cells: [
                                      list[i].weeks == 8
                                          ? const DataCell(Text("Mid Term"))
                                          : list[i].weeks == 16
                                              ? const DataCell(
                                                  Text("Final Term"))
                                              : DataCell(Text(
                                                  "WEEK # ${list[i].weeks}",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14),
                                                )),
                                      list[i].lectNo == 8
                                          ? const DataCell(Text("Mid Term"))
                                          : list[i].lectNo == 16
                                              ? const DataCell(
                                                  Text("Final Term"))
                                              : DataCell(Text(
                                                  "Lec # ${list[i].lectNo}")),
                                      DataCell(
                                        RichText(
                                          text: TextSpan(
                                            text: "",
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              for (var line in list[i]
                                                  .relatedTopic
                                                  .toString()
                                                  .split(','))
                                                TextSpan(
                                                    text: '$line\n',
                                                    style: const TextStyle(
                                                        fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(list[i].file.toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          color: Colors
                                                              .blueAccent)),
                                                  const SizedBox(width: 16),
                                                  IconButton(
                                                    icon: lecController
                                                            .isLoading
                                                        ? const Icon(
                                                            Icons
                                                                .downloading_outlined,
                                                            color: Colors.green,
                                                          )
                                                        : const Icon(
                                                            Icons.download),
                                                    onPressed: () {
                                                      final fileName =
                                                          list[i].file;
                                                      _downloadOutlineFile(
                                                          fileName.toString());
                                                    },
                                                    color: Colors.deepPurple,
                                                    hoverColor:
                                                        Colors.deepPurple,
                                                  )
                                                ],
                                              ),
                                              list[i].file1.toString() != "null"
                                                  ? Row(
                                                      children: [
                                                        Text(
                                                            list[i]
                                                                .file1
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .blueAccent)),
                                                        const SizedBox(
                                                            width: 16),
                                                        IconButton(
                                                          icon: lecController
                                                                  .isLoading
                                                              ? const Icon(
                                                                  Icons
                                                                      .downloading_outlined,
                                                                  color: Colors
                                                                      .green,
                                                                )
                                                              : const Icon(Icons
                                                                  .download),
                                                          onPressed: () {
                                                            final fileName =
                                                                list[i].file1;
                                                            _downloadOutlineFile(
                                                                fileName
                                                                    .toString());
                                                          },
                                                          color:
                                                              Colors.deepPurple,
                                                          hoverColor:
                                                              Colors.deepPurple,
                                                        )
                                                      ],
                                                    )
                                                  : Text(""),
                                              list[i].file2.toString() != "null"
                                                  ? Row(
                                                      children: [
                                                        Text(
                                                            list[i]
                                                                .file2
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .blueAccent)),
                                                        const SizedBox(
                                                            width: 16),
                                                        IconButton(
                                                          icon: lecController
                                                                  .isLoading
                                                              ? const Icon(
                                                                  Icons
                                                                      .downloading_outlined,
                                                                  color: Colors
                                                                      .green,
                                                                )
                                                              : const Icon(Icons
                                                                  .download),
                                                          onPressed: () {
                                                            final fileName =
                                                                list[i].file2;
                                                            _downloadOutlineFile(
                                                                fileName
                                                                    .toString());
                                                          },
                                                          color:
                                                              Colors.deepPurple,
                                                          hoverColor:
                                                              Colors.deepPurple,
                                                        )
                                                      ],
                                                    )
                                                  : Text(""),
                                              list[i].file3.toString() != "null"
                                                  ? Row(
                                                      children: [
                                                        Text(
                                                            list[i]
                                                                .file3
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .blueAccent)),
                                                        const SizedBox(
                                                            width: 16),
                                                        IconButton(
                                                          icon: lecController
                                                                  .isLoading
                                                              ? const Icon(
                                                                  Icons
                                                                      .downloading_outlined,
                                                                  color: Colors
                                                                      .green,
                                                                )
                                                              : const Icon(Icons
                                                                  .download),
                                                          onPressed: () {
                                                            final fileName =
                                                                list[i].file3;
                                                            _downloadOutlineFile(
                                                                fileName
                                                                    .toString());
                                                          },
                                                          color:
                                                              Colors.deepPurple,
                                                          hoverColor:
                                                              Colors.deepPurple,
                                                        )
                                                      ],
                                                    )
                                                  : Text(""),
                                              TextButton(
                                                child: Row(
                                                  children: const [
                                                    Text("Upload File "),
                                                    Text(
                                                      "+",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 26),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  // print("next file is $j");
                                                  final outlineId =
                                                      list[i].outlineId;
                                                  if (list[i]
                                                          .file1
                                                          .toString() ==
                                                      "null") {
                                                    _uploadlecFile(
                                                        outlineId, 1);
                                                  } else if (list[i]
                                                          .file2
                                                          .toString() ==
                                                      "null") {
                                                    _uploadlecFile(
                                                        outlineId, 2);
                                                  } else if (list[i]
                                                          .file3
                                                          .toString() ==
                                                      "null") {
                                                    _uploadlecFile(
                                                        outlineId, 3);
                                                  } else if (list[i]
                                                          .file4
                                                          .toString() ==
                                                      "null") {
                                                    _uploadlecFile(
                                                        outlineId, 4);
                                                  }

                                                  // _saveTolecFiletoServer();

                                                  print(
                                                      "outlineId is $outlineId");
                                                  // g
                                                },
                                              ),
                                              list[i].file4.toString() != "null"
                                                  ? Row(
                                                      children: [
                                                        Text(
                                                            list[i]
                                                                .file4
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .blueAccent)),
                                                        const SizedBox(
                                                            width: 16),
                                                        IconButton(
                                                          icon: lecController
                                                                  .isLoading
                                                              ? const Icon(
                                                                  Icons
                                                                      .downloading_outlined,
                                                                  color: Colors
                                                                      .green,
                                                                )
                                                              : const Icon(Icons
                                                                  .download),
                                                          onPressed: () {
                                                            final fileName =
                                                                list[i].file4;
                                                            _downloadOutlineFile(
                                                                fileName
                                                                    .toString());
                                                          },
                                                          color:
                                                              Colors.deepPurple,
                                                          hoverColor:
                                                              Colors.deepPurple,
                                                        )
                                                      ],
                                                    )
                                                  : Text(""),
                                            ],
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text: "",
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              for (var line in list[i]
                                                  .btLevel
                                                  .toString()
                                                  .split(','))
                                                TextSpan(
                                                    text: '$line\n',
                                                    style: const TextStyle(
                                                        fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text: "",
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              for (var line in list[i]
                                                  .courseObj
                                                  .toString()
                                                  .split(','))
                                                TextSpan(
                                                    text: '$line\n',
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                        fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // here add check
                                      DataCell(
                                        list[i]
                                                .approved
                                                .toString()
                                                .contains("yes")
                                            ? GetBuilder<AssessmentsController>(
                                                initState: (_) {
                                                Future.delayed(Duration.zero)
                                                    .then((value) => assController
                                                        .getAllAssessments());
                                              }, builder: (assController) {
                                                final currentUserId = Get.find<
                                                        UserAuthController>()
                                                    .getUserId();
                                                final assFileName =
                                                    assController.allAssessments
                                                        .where((e) => e
                                                            .outlineId
                                                            .toString()
                                                            .contains(list[i]
                                                                .outlineId
                                                                .toString()))
                                                        .map((e) =>
                                                            e.assFileName)
                                                        .toString()
                                                        .replaceAll(
                                                            RegExp(r"\(|\)"),
                                                            "");
                                                final fileType = assController
                                                    .allAssessments
                                                    .where((e) => e.outlineId
                                                        .toString()
                                                        .contains(list[i]
                                                            .outlineId
                                                            .toString()))
                                                    .map(
                                                        (e) => e.assessmentType)
                                                    .toString()
                                                    .replaceAll(
                                                        RegExp(r"\(|\)"), "");
                                                return assController
                                                        .allAssessments
                                                        .where((e) {
                                                          return e.outlineId
                                                              .toString()
                                                              .contains(list[i]
                                                                  .outlineId
                                                                  .toString());
                                                        })
                                                        .where((e) =>
                                                            e.assAddedBy ==
                                                            currentUserId)
                                                        .isEmpty
                                                    ?
                                                    // Here Comes DropDown
                                                    Column(
                                                        children: [
                                                          dropDownForAssessments(
                                                              lecController, i),
                                                          GetBuilder<
                                                              AssessmentsController>(
                                                            builder:
                                                                (controller) =>
                                                                    TextButton(
                                                              child: Text(
                                                                  controller
                                                                          .isLoading
                                                                      ? "Uploading ..."
                                                                      : "Upload File ",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                              onPressed: controller
                                                                      .isLoading
                                                                  ? null
                                                                  : () {
                                                                      final outlineId =
                                                                          list[i]
                                                                              .outlineId;

                                                                      String
                                                                          value =
                                                                          lecController
                                                                              .getSelectedDropDownValue(i);
                                                                      _pickFile(
                                                                          value,
                                                                          outlineId!);
                                                                    },
                                                              style: TextButton.styleFrom(
                                                                  backgroundColor: controller
                                                                          .isLoading
                                                                      ? Colors
                                                                          .grey
                                                                      : const Color(
                                                                          0xFF175353)),
                                                            ),
                                                          ),
                                                        ],
                                                      )

                                                    // Here Ends DropDown
                                                    : Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "$assFileName ( $fileType )",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                              IconButton(
                                                                icon: lecController
                                                                        .isLoading
                                                                    ? const Icon(
                                                                        Icons
                                                                            .downloading_outlined,
                                                                        color: Colors
                                                                            .green,
                                                                      )
                                                                    : const Icon(
                                                                        Icons
                                                                            .download),
                                                                onPressed: () {
                                                                  _downloadAssessmentFile(
                                                                      assFileName);
                                                                  // _downloadOutlineFile(
                                                                  //     assFileName.toString());
                                                                },
                                                                color: Colors
                                                                    .red[300],
                                                                hoverColor:
                                                                    Colors.red,
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          GetBuilder<
                                                                  AssessmentsMarksController>(
                                                              initState: (_) {
                                                            Future.delayed(
                                                                    Duration
                                                                        .zero)
                                                                .then((value) =>
                                                                    assessmenstMarksController
                                                                        .getAllAssessmentsMarks());
                                                          }, builder:
                                                                  (assMarksController) {
                                                            final assessmentId = assController
                                                                .allAssessments
                                                                .where((e) => e
                                                                    .outlineId
                                                                    .toString()
                                                                    .contains(list[
                                                                            i]
                                                                        .outlineId
                                                                        .toString()))
                                                                .map((e) =>
                                                                    e.asId)
                                                                .toString()
                                                                .replaceAll(
                                                                    RegExp(
                                                                        r"\(|\)"),
                                                                    "");
                                                            final isSentToHod = assController
                                                                .allAssessments
                                                                .where((e) => e
                                                                    .outlineId
                                                                    .toString()
                                                                    .contains(list[
                                                                            i]
                                                                        .outlineId
                                                                        .toString()))
                                                                .map((e) =>
                                                                    e.senttoHod)
                                                                .toString()
                                                                .replaceAll(
                                                                    RegExp(
                                                                        r"\(|\)"),
                                                                    "");
                                                            RxList<dynamic>
                                                                checkAssAdded =
                                                                [].obs;
                                                            checkAssAdded = assMarksController
                                                                .allAssessmentsMarks
                                                                .where((a) => a
                                                                    .assessmentId
                                                                    .toString()
                                                                    .toLowerCase()
                                                                    .contains(
                                                                        assessmentId))
                                                                .toList()
                                                                .obs;
                                                            return checkAssAdded
                                                                    .isNotEmpty
                                                                ? Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      // view grades Button
                                                                      TextButton(
                                                                          child: Text(
                                                                              assMarksController.isLoading ? " ..." : "View Grades ",
                                                                              style: const TextStyle(
                                                                                color: Colors.white,
                                                                              )),
                                                                          style: TextButton.styleFrom(backgroundColor: Colors.black),
                                                                          onPressed: () {
                                                                            final assessmentId =
                                                                                assController.allAssessments.where((e) => e.outlineId.toString().contains(list[i].outlineId.toString())).map((e) => e.asId).toString().replaceAll(RegExp(r"\(|\)"), "");

                                                                            Get.dialog(ViewGradesDialogue(
                                                                                assessmentId: assessmentId,
                                                                                subjectInfo: subjectInfo));
                                                                          }),
                                                                      // send to hod button

                                                                      isSentToHod !=
                                                                              "yes"
                                                                          ? TextButton(
                                                                              child: Text(assMarksController.isLoading ? " ..." : "Send to HOD ",
                                                                                  style: const TextStyle(
                                                                                    color: Colors.white,
                                                                                  )),
                                                                              style: TextButton.styleFrom(backgroundColor: Colors.blue),
                                                                              onPressed: () {
                                                                                assController.sendResultToHod(int.parse(assessmentId)).then((status) {
                                                                                  if (status.isSuccesfull) {
                                                                                    Get.snackbar("Success", status.message);
                                                                                    Get.toNamed(Uri.base.toString());
                                                                                  } else {
                                                                                    Get.snackbar("Error Occured", status.message);
                                                                                  }
                                                                                });
                                                                                // print("assId $assessmentId");

                                                                                // sendResultToHod
                                                                                // final assessmentId =
                                                                                //     assController.allAssessments.where((e) => e.outlineId.toString().contains(list[i].outlineId.toString())).map((e) => e.asId).toString().replaceAll(RegExp(r"\(|\)"), "");

                                                                                // Get.dialog(ViewGradesDialogue(
                                                                                //     assessmentId: assessmentId,
                                                                                //     subjectInfo: subjectInfo));
                                                                              })
                                                                          : const Text("Sent to HOD"),
                                                                    ],
                                                                  )
                                                                : Container(
                                                                    child: GetBuilder<
                                                                        AssessmentsController>(
                                                                      builder:
                                                                          (controller) =>
                                                                              TextButton(
                                                                        child: Text(
                                                                            controller.isLoading
                                                                                ? "Uploading ..."
                                                                                : "Upload Grades ",
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Colors.white,
                                                                            )),
                                                                        onPressed: controller.isLoading
                                                                            ? null
                                                                            : () {
                                                                                final assessmentId = assController.allAssessments.where((e) => e.outlineId.toString().contains(list[i].outlineId.toString())).map((e) => e.asId).toString().replaceAll(RegExp(r"\(|\)"), "");

                                                                                Get.dialog(
                                                                                  MyDataTable(
                                                                                    assessmentId: int.parse(assessmentId),
                                                                                    subjectInfo: subjectInfo,
                                                                                    coursObjectives: list[i].courseObj,
                                                                                  ),
                                                                                );
                                                                              },
                                                                        style: TextButton.styleFrom(
                                                                            backgroundColor: controller.isLoading
                                                                                ? Colors.grey
                                                                                : Color(0xFF175353)),
                                                                      ),
                                                                    ),
                                                                  );
                                                          }),
                                                        ],
                                                      );
                                              })
                                            : list[i].approved.toString() !=
                                                    "no"
                                                ? Row(
                                                    children: [
                                                      Text(
                                                          "Your outline is rejected because of : ${list[i].approved}"),
                                                      const SizedBox(width: 12),
                                                      IconButton(
                                                        icon:
                                                            Icon(Icons.delete),
                                                        onPressed: () {
                                                          topicController.text =
                                                              list[i]
                                                                  .relatedTopic;
                                                          final outlineId =
                                                              list[i].outlineId;
                                                          courseObjectivesController
                                                                  .text =
                                                              list[i].courseObj;
                                                          bTLevelsController
                                                                  .text =
                                                              list[i].btLevel;
                                                          lectureController
                                                                  .fileName =
                                                              list[i].file;

                                                          Get.dialog(
                                                            updateAssessmentMethod(
                                                                list,
                                                                i,
                                                                lecController),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                : const Text(
                                                    "Your Outline is not approved yet !"),
                                      ),
                                    ]),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  );
      }),
    );
  }

  // _uploadlecFile(int outlineId, fileNo) {
  //   final file = _picklectureFile();
  //   _saveTolecFiletoServer(outlineId, fileNo);
  //   return file;
  // }

  _uploadlecFile(int outlineId, fileNo) async {
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
          _saveTolecFiletoServer(outlineId, fileNo);
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

  _saveTolecFiletoServer(int outlineId, fileNo) {
    String fileName = lectureController.fileName;
    if (fileToUpload == null) {
      Get.snackbar("File is not selected", "Select a File to Upload !");
    } else {
      final lecDocFile = FormData({
        "file": MultipartFile(fileToUpload, filename: fileName),
      });

      lectureController.uploadNewLecFile(lecDocFile).then((status) {
        if (status.isSuccesfull) {
          var fileName = status.message;
          if (fileNo == 1) {
            print("fileName is $fileName and fileNo = $fileNo");
            LecturesModel lecInfo = LecturesModel(
              outlineId: outlineId,
              file1: fileName,
              updatedAt: AppUtils.now,
            );
            lectureController.uploadMoreLecFile(lecInfo).then((status) {
              if (status.isSuccesfull) {
                Get.snackbar("Success", status.message);
                Get.toNamed(Uri.base.toString());
              } else {
                Get.snackbar("Error Occurred ", status.message);
              }
            });
          } else if (fileNo == 2) {
            print("fileName is $fileName and fileNo = $fileNo");

            LecturesModel lecInfo = LecturesModel(
              outlineId: outlineId,
              file2: fileName,
              updatedAt: AppUtils.now,
            );
            lectureController.uploadMoreLecFile(lecInfo).then((status) {
              if (status.isSuccesfull) {
                Get.snackbar("Success", status.message);
                Get.toNamed(Uri.base.toString());
              } else {
                Get.snackbar("Error Occurred ", status.message);
              }
            });
          } else if (fileNo == 3) {
            print("fileName is $fileName and fileNo = $fileNo");

            LecturesModel lecInfo = LecturesModel(
              outlineId: outlineId,
              file3: fileName,
              updatedAt: AppUtils.now,
            );
            lectureController.uploadMoreLecFile(lecInfo).then((status) {
              if (status.isSuccesfull) {
                Get.snackbar("Success", status.message);
                Get.toNamed(Uri.base.toString());
              } else {
                Get.snackbar("Error Occurred ", status.message);
              }
            });
          } else if (fileNo == 4) {
            print("fileName is $fileName and fileNo = $fileNo");

            LecturesModel lecInfo = LecturesModel(
              outlineId: outlineId,
              file4: fileName,
              updatedAt: AppUtils.now,
            );
            lectureController.uploadMoreLecFile(lecInfo).then((status) {
              if (status.isSuccesfull) {
                Get.snackbar("Success", status.message);
                Get.toNamed(Uri.base.toString());
              } else {
                Get.snackbar("Error Occurred ", status.message);
              }
            });
          }
        } else {
          Get.snackbar("Error Occurred ", status.message);
        }
      });
    }
  }

  Dialog updateAssessmentMethod(
      RxList<dynamic> list, int i, LecturesController lecController) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          width: Get.width * 0.40,
          height: Get.height * 0.80,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 12),
                    Text("Lecture No ::  ${list[i].lectNo}",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 12),
                    Text("Week No ::  ${list[i].weeks}",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 12),
                  ],
                ),
                const SizedBox(height: 18),
                Row(children: [
                  // Topics Text Field Start
                  SizedBox(
                    width: 427,
                    child: TextFormField(
                      validator: validateAField,
                      keyboardType: TextInputType.text,
                      controller: topicController,
                      // readOnly: true,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusColor: Colors.green,
                        hintText:
                            "Add Related Topics if multiple add comma's(,) between",
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 427,
                          child: TextFormField(
                            validator: validateAField,
                            keyboardType: TextInputType.text,
                            controller: courseObjectivesController,
                            readOnly: true,
                            maxLines: 2,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusColor: Colors.green,
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

                          courseController.setSelectedObjectivesObs = firstObj;

                          return courseController.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : courseController.courseObjectives.isEmpty
                                  ? const Center(
                                      child: Text("Nothing Found !"),
                                    )
                                  : DropdownButton<String>(
                                      hint: Text(courseController
                                          .selectedObjectivesObsPlaceholder),
                                      value: courseController
                                          .selectedObjectivesObs,
                                      // HERE

                                      items: courseController.courseObjectives
                                          .map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value.objName
                                              .toString()
                                              .replaceAll(RegExp(r"\(|\)"), ''),
                                          child: Text(value.objName
                                              .toString()
                                              .replaceAll(
                                                  RegExp(r"\(|\)"), '')),
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
                                    );
                        }),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 427,
                                  child: TextFormField(
                                    validator: validateAField,
                                    keyboardType: TextInputType.text,
                                    controller: bTLevelsController,
                                    readOnly: true,
                                    maxLines: 2,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusColor: Colors.green,
                                      hintText: "Select Bloom Taxonomy Levels",
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                GetBuilder<CoursesController>(
                                    builder: (courseController) {
                                  return DropdownButton<String>(
                                    hint: Text(courseController
                                        .selectedbTLevelObsPlaceholder),
                                    value: courseController.selectedbTLevelObs,
                                    items: courseController.bloomsTaxonomyLevels
                                        .map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.toString(),
                                        child: Text(value.toString()),
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
                                    },
                                  );
                                }),
                                const SizedBox(height: 18),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _pickUpdatedAssFile();
                                        //  _uploadFile();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.blue),
                                        ),
                                        child: Row(
                                          children: [
                                            Obx(
                                              () => Text(
                                                  lecController.fileName
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.blue,
                                                  )),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: Icon(
                                                Icons.file_copy_sharp,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Choose File Ends
                                  ],
                                ),
                                const SizedBox(height: 18),
                                // BT LEVEL DROPDOWN ENDS
                                Row(
                                  children: [
                                    GetBuilder<LecturesController>(
                                      builder: (controller) => CustomButton(
                                          title: controller.isLoading
                                              ? "Adding"
                                              : "Add ",
                                          btnTxtClr: Colors.white,
                                          btnBgClr: Color(0xFF175353),
                                          onTap: () {
                                            _saveUpdatesAssToServer(
                                                list[i].outlineId);
                                            // _saveToServer(week, lecNo);
                                          }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _pickUpdatedAssFile() async {
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

  _saveUpdatesAssToServer(int outlineId) {
    Get.back();
    String fileName = lectureController.fileName;
    if (fileToUpload == null) {
      final relatedTopic = topicController.text;
      final btLevel = bTLevelsController.text;
      final objectives = courseObjectivesController.text;

      LecturesModel lecInfo = LecturesModel(
        outlineId: outlineId,
        file: fileName,
        relatedTopic: relatedTopic,
        btLevel: btLevel,
        courseObj: objectives,
        updatedAt: AppUtils.now,
      );
      lectureController.updateLectureOutline(lecInfo).then((status) {
        if (status.isSuccesfull) {
          Get.snackbar("Success", status.message);
          Get.toNamed(Uri.base.toString());
        } else {
          Get.snackbar("Error Occurred ", status.message);
        }
      });
    } else {
      final relatedTopic = topicController.text;
      final btLevel = bTLevelsController.text;
      final objectives = courseObjectivesController.text;

      final lecDocFile = FormData({
        "file": MultipartFile(fileToUpload, filename: fileName),
      });

      lectureController.uploadNewLecFile(lecDocFile).then((status) {
        if (status.isSuccesfull) {
          var fileName = status.message;

          LecturesModel lecInfo = LecturesModel(
            outlineId: outlineId,
            file: fileName,
            relatedTopic: relatedTopic,
            btLevel: btLevel,
            courseObj: objectives,
            updatedAt: AppUtils.now,
          );

          lectureController.updateLectureOutline(lecInfo).then((status) {
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

  _pickFile(String assessmentType, int outlineId) async {
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
          _saveToServer(assessmentType, outlineId);
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

  _saveToServer(String assessmentType, int outlineId) {
    String fileName = lectureController.fileName;
    if (fileToUpload == null) {
      Get.snackbar("File is not selected", "Select a File to Upload !");
    } else {
      // final relatedTopic = topicController.text;
      // final btLevel = bTLevelsController.text;

      final assDocFile = FormData({
        "file": MultipartFile(fileToUpload, filename: fileName),
      });

      assController.uploadNewAssFile(assDocFile).then((status) {
        if (status.isSuccesfull) {
          var fileName = status.message;

          AssessmentsModel assessmentInfo = AssessmentsModel(
            outlineId: outlineId,
            assessmentType: assessmentType.toLowerCase(),
            assFileName: fileName,
            createdAt: AppUtils.now,
            updatedAt: AppUtils.now,
          );

          assController.uploadAssFileRecToDB(assessmentInfo).then((status) {
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

  DropdownButton<String> dropDownForAssessments(
      LecturesController lecController, int i) {
    return DropdownButton<String>(
      items: lecController.assesmentOptions.map((value) {
        return DropdownMenuItem<String>(
          value: value.toString(),
          child: Text(value.toString()),
          onTap: () {
            lecController.setselectAssessmentObsPlaceholder = value.toString();
          },
        );
      }).toList(),
      onChanged: (value) {
        // setState(() {
        //   _selectedValues[i] = value;
        // });
        lectureController.setSelectedValues(i, value);
      },
      value: lectureController.selectedValuesForAssessmentDropDown[i],
      hint: const Text('Choose an assessment option'),
    );
  }

  _downloadOutlineFile(String fileName) async {
    // lectureController.downloadPdfVersionInfinity(fileName);
    final currentUserId = Get.find<UserAuthController>().getUserId();

    lectureController.downloadOutlineFile(fileName, currentUserId);
  }

  _downloadAssessmentFile(String fileName) async {
    // lectureController.downloadPdfVersionInfinity(fileName);
    final currentUserId = Get.find<UserAuthController>().getUserId();

    await assController.downloadAssessemntFile(fileName, currentUserId);
  }
}

class MyDataTable extends StatefulWidget {
  List<dynamic> subjectInfo;
  String coursObjectives;
  int assessmentId;
  MyDataTable({
    super.key,
    required this.subjectInfo,
    required this.assessmentId,
    required this.coursObjectives,
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
  final assMarksRepo = Get.put<AssessmentsMarksRepo>(
      AssessmentsMarksRepo(apiClient: Get.find()));
  final assessmenstMarksController = Get.put<AssessmentsMarksController>(
      AssessmentsMarksController(assMarksRepo: Get.find()));

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
      for (int i = 0; i < _rows; i++) {
        _controllers[i].add(TextEditingController());
      }
      _cols++;
    });
  }

  void _removeColumn() {
    totalMarksController.removeLast();
    setState(() {
      for (int i = 0; i < _rows; i++) {
        _controllers[i].remove(TextEditingController());
      }
      _cols--;
    });
  }

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
        0, (index) => List.generate(_cols, (index) => TextEditingController()));

    totalMarksController =
        List.generate(_cols, (index) => TextEditingController());
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _controllers = List.generate(
  //       _rows, (i) => List.generate(_cols, (j) => TextEditingController()));
  // }

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
                            children: widget.subjectInfo
                                .map((e) => Text(
                                    "${e.courseName}| ${e.semester} (${e.session}) | ${e.department.toString().toUpperCase()}",
                                    style: const TextStyle(
                                        fontFamily: 'Dongle',
                                        fontSize: 30,
                                        color: Colors.purple)))
                                .toList(),
                          ),
                          const SizedBox(height: 30),
                          GetBuilder<EnrolledStudentsController>(
                              initState: (_) {
                            Future.delayed(const Duration(seconds: 0))
                                .then((value) {
                              enrolledStudentController.getallEnrolledSudents();
                            });
                          }, builder: (stController) {
                            List<String> courseObjectivesList =
                                widget.coursObjectives.split(",");

                            final record = courseObjectivesList[0];
                            final initialValue = record;

                            RxList enrolledList = [].obs;
                            final session = widget.subjectInfo
                                .map((e) => e.session)
                                .toString()
                                .replaceAll(RegExp(r"\(|\)"), "");

                            final courseId = widget.subjectInfo
                                .map((e) => e.courseId)
                                .toString()
                                .replaceAll(RegExp(r"\(|\)"), "");

                            enrolledList = stController.getEnrolledStydentsObx
                                .where((e) =>
                                    e.courseId.toString().contains(courseId))
                                .where((e) => e.session
                                    .toString()
                                    .toLowerCase()
                                    .contains(session.toLowerCase()))
                                // .where((e) {
                                //   print("Date is ${e.endDate.toString()=="null"}");
                                //   print(
                                //       "isEmpty ${e.endDate.toString()=="null"}");
                                //   return e.endDate.toString()=="null";
                                // })
                                .toList()
                                .obs;

                            _controllers = List.generate(
                                enrolledList.isEmpty ? 1 : enrolledList.length,
                                (index) => List.generate(
                                    _cols, (index) => TextEditingController()));

                            return Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: DataTable(
                                    columns: List.generate(
                                      _cols,
                                      (index) => index == 0
                                          ? const DataColumn(
                                              label: Text('Sap Id'))
                                          : index == 1
                                              ? const DataColumn(
                                                  label: Text('Student Name'))
                                              : DataColumn(
                                                  label: Row(
                                                    children: [
                                                      stController.isLoading
                                                          ? const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : courseObjectivesList
                                                                  .isEmpty
                                                              ? const Center(
                                                                  child: Text(
                                                                      "Nothing Found !"),
                                                                )
                                                              : DropdownButton<
                                                                  String>(
                                                                  value: stController
                                                                              .selectedValues[
                                                                          index -
                                                                              2] ??
                                                                      initialValue,
                                                                  onChanged:
                                                                      (value) {
                                                                    stController.setSelectedValue(
                                                                        index -
                                                                            2,
                                                                        value!);
                                                                    // record =
                                                                    //     value!;
                                                                  },
                                                                  items: courseObjectivesList.map<
                                                                          DropdownMenuItem<
                                                                              String>>(
                                                                      (value) {
                                                                    return DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          value,
                                                                      child: Text(
                                                                          value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                              'Qno ${index - 1}'),
                                                          Container(
                                                            width: 80,
                                                            height: 40,
                                                            child:
                                                                TextFormField(
                                                              validator:
                                                                  validateAField,
                                                              controller:
                                                                  totalMarksController[
                                                                      index],
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              inputFormatters: [
                                                                LengthLimitingTextInputFormatter(
                                                                    3),
                                                              ],
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                                hintText:
                                                                    "Total Marks",
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                    ),
                                    rows: [
                                      for (int i = 0;
                                          i < enrolledList.length;
                                          i++)
                                        if (enrolledList[i]
                                                .endDate
                                                .toString() ==
                                            "null")
                                          DataRow(
                                              cells: List.generate(
                                                  _cols,
                                                  (colIndex) => colIndex == 0
                                                      ? DataCell(Text(
                                                          enrolledList[i]
                                                              .email))
                                                      : colIndex == 1
                                                          ? DataCell(Text(
                                                              enrolledList[i]
                                                                  .fName))
                                                          : DataCell(
                                                              TextFormField(
                                                                validator:
                                                                    validateAField,
                                                                controller:
                                                                    _controllers[
                                                                            i][
                                                                        colIndex],
                                                                decoration:
                                                                    const InputDecoration(
                                                                        border:
                                                                            InputBorder.none),
                                                              ),
                                                            )))
                                    ]),
                              ),
                            );
                          })
                        ],
                      ),
                    )))));
  }

  @override
  void dispose() {
    for (int i = 0; i < _rows; i++) {
      for (int j = 0; j < _cols; j++) {
        _controllers[i][j].dispose();
      }
    }
    super.dispose();
  }

  void _printValues() {
    List<AssessmentsMarksModel> assModel;
    List<Map<String, dynamic>> totalMarkstoStore = [];
    for (int t = 0; t < totalMarksController.length; t++) {
      Map<String, dynamic> rowToStore = {};
      if (totalMarksController[t].text.isNotEmpty) {
        rowToStore["${t - 1}"] = totalMarksController[t].text;
      }
      if (rowToStore.isNotEmpty) {
        totalMarkstoStore.add(rowToStore);
      }
    }
    List<Map<String, dynamic>> dataToStore = [];
    for (int i = 0; i < _controllers.length; i++) {
      Map<String, dynamic> rowToStore = {};
      for (int j = 0; j < _controllers[i].length; j++) {
        if (_controllers[i][j].text.isNotEmpty) {
          rowToStore["Qno${j - 1}"] = _controllers[i][j].text;
        }
      }
      dataToStore.add(rowToStore);
    }
    RxList enrolledList = [].obs;
    final session = widget.subjectInfo
        .map((e) => e.session)
        .toString()
        .replaceAll(RegExp(r"\(|\)"), "");

    final courseId = widget.subjectInfo
        .map((e) => e.courseId)
        .toString()
        .replaceAll(RegExp(r"\(|\)"), "");

    enrolledList = enrolledStudentController.getEnrolledStydentsObx
        .where((e) => e.courseId.toString().contains(courseId))
        .where((e) =>
            e.session.toString().toLowerCase().contains(session.toLowerCase()))
        .toList()
        .obs;
    for (int j = 0; j < totalMarkstoStore.length; j++) {
      for (final totalMarkskey in totalMarkstoStore[j].keys) {
        final totalMarks = totalMarkstoStore[j][totalMarkskey];

        for (int i = 0; i < dataToStore.length; i++) {
          for (final key in dataToStore[i].keys) {
            final inputString = key;
            final regex = RegExp(r'\d+');
            final matches = regex.allMatches(inputString);

            final numbers = matches.map((match) => match.group(0)).join();
            String obtMarks;
            if (numbers == totalMarkskey) {
              obtMarks = dataToStore[i][key];
            } else {
              obtMarks = "";
            }
            final courseObj = enrolledStudentController.selectedValues[j];
            List<AssessmentsMarksModel> assModel = [];
            if (courseObj != "") {
              if (obtMarks.isNotEmpty) {
                assModel = [
                  AssessmentsMarksModel(
                      // asId: 4,
                      assessmentId: widget.assessmentId,
                      totalMarks: int.parse(totalMarks.toString()),
                      obtmarks: int.parse(obtMarks.toString()),
                      studentId: int.parse(enrolledList[i].userId.toString()),
                      objName: courseObj,
                      qno: int.parse(totalMarkskey),
                      createdAt: AppUtils.now,
                      updatedAt: AppUtils.now),
                ];
                if (assModel.isNotEmpty) {
                  assessmenstMarksController
                      .uploadAssMarksToDB(assModel)
                      .then((status) {
                    if (status.isSuccesfull) {
                      //  Get.snackbar("Success", status.message);
                      Get.toNamed(Uri.base.toString());
                    } else {
                      Get.snackbar("Error Occured", status.message);
                    }
                  });
                }
              } else {
                assModel = [];
              }
            }
            // if (assModel.isNotEmpty) {
            //   assessmenstMarksController
            //       .uploadAssMarksToDB(assModel)
            //       .then((status) {
            //     if (status.isSuccesfull) {
            //       //  Get.snackbar("Success", status.message);
            //       Get.toNamed(Uri.base.toString());
            //     } else {
            //       Get.snackbar("Error Occured", status.message);
            //     }
            //   });
            // } // here
            // } else {
            //   Get.snackbar("Objective is not selected",
            //       "Select Objective for each Question",
            //       backgroundColor: Colors.red);

            // }
          }
        }
      }
    }
  }
}

class ViewGradesDialogue extends StatelessWidget {
  ViewGradesDialogue(
      {super.key, required this.assessmentId, required this.subjectInfo});
  final String assessmentId;
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
                            Row(
                              children: subjectInfo
                                  .map((e) => Text(
                                      "${e.courseName}| ${e.semester} (${e.session}) | ${e.department.toString().toUpperCase()}",
                                      style: const TextStyle(
                                          fontFamily: 'Dongle',
                                          fontSize: 30,
                                          color: Colors.purple)))
                                  .toList(),
                            ),
                            const SizedBox(height: 30),
                            GetBuilder<AssessmentsMarksController>(
                                initState: (_) {
                              Future.delayed(const Duration(seconds: 0))
                                  .then((value) {
                                assessmenstMarksController
                                    .getAllAssessmentsMarks();
                              });
                            }, builder: (assMarksController) {
                              RxList<dynamic> checkAssAdded = [].obs;

                              checkAssAdded = assMarksController
                                  .allAssessmentsMarks
                                  .where((a) => a.assessmentId
                                      .toString()
                                      .contains(assessmentId))
                                  .toList()
                                  .obs;

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
