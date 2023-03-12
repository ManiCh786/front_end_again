import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_end/models/lectures_model.dart';
import 'package:get/get.dart';

import '../../../../../controllers/controller.dart';
import '../../../../../controllers/lecturesController.dart';
import '../../../../../data/repository/repository.dart';
import '../../../../../models/models.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/widgets.dart';

class AssessmentsScreen extends StatefulWidget {
  AssessmentsScreen({
    super.key,
    required this.courseName,
    required this.session,
    required this.createdAt,
    required this.courseList,
    required this.usersList,
  });
  String courseName;
  String session;
  String createdAt;
  CoursesModel courseList;
  UsersModel usersList;

  @override
  State<AssessmentsScreen> createState() => _AssessmentsScreen();
}

class _AssessmentsScreen extends State<AssessmentsScreen> {
  final scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final feedBackController = TextEditingController();
  final lectureController = Get.find<LecturesController>();
  final assController = Get.find<AssessmentsController>();
  final assessmenstMarksController = Get.find<AssessmentsMarksController>();
  var year = DateTime.now().year.toString().obs;
  final _itemsYear = List<DateTime>.generate(
      10,
      (i) => DateTime.utc(
            DateTime.now().year - i,
          ).add(Duration(days: i)));
  final List<DataColumn> _columns = [
    const DataColumn(
        label: Text("Weeks"), tooltip: "Represents Weeks of the Semester"),
    const DataColumn(
        label: Text("Lectures"),
        tooltip: "Represents Lectures of the Semester"),
    const DataColumn(
        label: Text("Topics"), tooltip: "Represents Topics of the Semester"),
    const DataColumn(
        label: Text("File(pdf/docx)"), tooltip: "Upload a file of Outline"),
    const DataColumn(
        label: Text("BT Level"),
        tooltip: "Represents BT Level of the Semester"),
    const DataColumn(
        label: Text("Course Objectives"),
        tooltip: "Represents Course Objectives of the Semester"),
    const DataColumn(
        label: Text("Assessments"),
        tooltip: "Represents Assessments of the Semester"),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 18),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.16,
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade400,
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
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Text(
                      '${widget.courseList.courseName}'.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.deepPurple,
                          fontFamily: 'Poppins',
                          fontSize: 32),
                    ),
                    Text(
                      'Assessments'.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.deepPurple,
                          fontFamily: 'Poppins',
                          fontSize: 32),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.75,
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
            child: GetBuilder<LecturesController>(initState: (_) {
              Future.delayed(const Duration(seconds: 1)).then((value) {
                lectureController.getMyLecturesOutlineStream();
              });
            }, builder: (lecController) {
              RxList<dynamic> list = [].obs;
              list = lecController.myLecturesOutlineObx
                  .where((e) =>
                      e.session
                          .toString()
                          .toLowerCase()
                          .contains(widget.session) &&
                      e.createdAt.toString().toLowerCase().contains(year))
                  .where((e) {
                    return e.subject
                        .toString()
                        .toLowerCase()
                        .contains(widget.courseName.toLowerCase());
                  })
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
                      : InteractiveViewer(
                          scaleEnabled: false,
                          child: Scrollbar(
                            trackVisibility: true,
                            controller: scrollController,
                            child: SingleChildScrollView(
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    DropDownForYears(),
                                    
                                    const SizedBox(height: 16),
                                    DataTable(
                                        dataRowHeight: 100,
                                        columnSpacing: 40,
                                        dividerThickness: 2,
                                        sortAscending: true,
                                        columns: _columns,
                                        rows: [
                                          for (var i = 0; i < list.length; i++)
                                            DataRow(cells: [
                                              list[i].weeks == 8
                                                  ? const DataCell(
                                                      Text("Mid Term"))
                                                  : list[i].weeks == 16
                                                      ? const DataCell(
                                                          Text("Final Term"))
                                                      : DataCell(Text(
                                                          "WEEK # ${list[i].weeks}")),
                                              list[i].lectNo == 8
                                                  ? const DataCell(
                                                      Text("Mid Term"))
                                                  : list[i].lectNo == 16
                                                      ? const DataCell(
                                                          Text("Final Term"))
                                                      : DataCell(Text(
                                                          "Lec # ${list[i].lectNo}")),
                                              DataCell(
                                                RichText(
                                                  text: TextSpan(
                                                    text: "",
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: <TextSpan>[
                                                      for (var line in list[i]
                                                          .relatedTopic
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
                                                Row(
                                                  children: [
                                                    Text(
                                                        list[i].file.toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                              color:
                                                                  Colors.green,
                                                            )
                                                          : const Icon(
                                                              Icons.download),
                                                      onPressed: () {
                                                        final fileName =
                                                            list[i].file;
                                                        final facultyId = widget
                                                            .usersList.userId;
                                                        _downloadOutlineFile(
                                                            fileName.toString(),
                                                            facultyId!);
                                                      },
                                                      color: Colors.red[300],
                                                      hoverColor: Colors.red,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              DataCell(
                                                RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  text: TextSpan(
                                                    text: "",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      for (var line in list[i]
                                                          .btLevel
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
                                                RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  text: TextSpan(
                                                    text: "",
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: <TextSpan>[
                                                      for (var line in list[i]
                                                          .courseObj
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
                                              // here add check
                                              DataCell(
                                                GetBuilder<
                                                        AssessmentsController>(
                                                    initState: (_) {
                                                  Future.delayed(Duration.zero)
                                                      .then((value) => assController
                                                          .getAllAssessments());
                                                }, builder: (assController) {
                                                  final facultyId =
                                                      widget.usersList.userId;
                                                  final assFileName =
                                                      assController
                                                          .allAssessments
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
                                                      .map((e) =>
                                                          e.assessmentType)
                                                      .toString()
                                                      .replaceAll(
                                                          RegExp(r"\(|\)"), "");
                                                  return assController
                                                          .allAssessments
                                                          .where((e) {
                                                            return e.outlineId
                                                                .toString()
                                                                .contains(list[
                                                                        i]
                                                                    .outlineId
                                                                    .toString());
                                                          })
                                                          .where((e) =>
                                                              e.assAddedBy ==
                                                              facultyId)
                                                          .where((e) =>
                                                              e.senttoHod ==
                                                              "yes")
                                                          .isEmpty
                                                      ? const Text(
                                                          "Nothing Found !")
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
                                                                  "$assFileName (${fileType.toUpperCase()})",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                IconButton(
                                                                  icon: lecController
                                                                          .isLoading
                                                                      ? const Icon(
                                                                          Icons
                                                                              .downloading_outlined,
                                                                          color:
                                                                              Colors.green,
                                                                        )
                                                                      : const Icon(
                                                                          Icons
                                                                              .download),
                                                                  onPressed:
                                                                      () {
                                                                    print(
                                                                        "facultyId is $facultyId");
                                                                    _downloadAssessmentFile(
                                                                        assFileName,
                                                                        facultyId!);
                                                                    // _downloadOutlineFile(
                                                                    //     assFileName.toString());
                                                                  },
                                                                  color: Colors
                                                                      .red[300],
                                                                  hoverColor:
                                                                      Colors
                                                                          .red,
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
                                                                            child: Text(assMarksController.isLoading ? " ..." : "View Grades ",
                                                                                style: const TextStyle(
                                                                                  color: Colors.white,
                                                                                )),
                                                                            style: TextButton.styleFrom(backgroundColor: Colors.black),
                                                                            onPressed: () {
                                                                              final assessmentId = assController.allAssessments.where((e) => e.outlineId.toString().contains(list[i].outlineId.toString())).map((e) => e.asId).toString().replaceAll(RegExp(r"\(|\)"), "");

                                                                              Get.dialog(ViewGradesDialogue(assessmentId: assessmentId));
                                                                            }),
                                                                        // send to hod button
                                                                      ],
                                                                    )
                                                                  : Container(
                                                                      child: GetBuilder<
                                                                          AssessmentsController>(
                                                                        builder: (controller) => Text(
                                                                            controller.isLoading
                                                                                ? "..."
                                                                                : "Marks Not Added Yet ! ",
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Colors.black,
                                                                            )),
                                                                      ),
                                                                    );
                                                            }),
                                                          ],
                                                        );

                                                  // vv
                                                }),
                                              ),
                                            ]),
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
            }),
          ),
        ),

        // nn
      ]),
    );
  }

  _downloadAssessmentFile(String fileName, int currentUserId) async {
    // lectureController.downloadPdfVersionInfinity(fileName);
    await assController.downloadAssessemntFile(fileName, currentUserId);
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

  _downloadOutlineFile(String fileName, int currentUserId) async {
    // lectureController.downloadPdfVersionInfinity(fileName);
    lectureController.downloadOutlineFile(fileName, currentUserId);
  }
}

class rejctOutlineWidget extends StatelessWidget {
  const rejctOutlineWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.feedBackController,
    required this.list,
    required this.i,
    required this.lectureController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController feedBackController;
  final RxList list;
  final int i;
  final LecturesController lectureController;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: Get.height * 0.45,
        width: Get.width * 0.45,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: Get.width * 0.90,
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ],
            ),
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Write Feedback *",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                      controller: feedBackController,
                      minLines: 3,
                      maxLines: 4,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder())),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        child: const Text(
                          "Reject",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: Size(Get.width * 0.20, 50)),
                        onPressed: () {
                          Get.back();
                          if (_formKey.currentState!.validate()) {
                            LecturesModel lecInfo = LecturesModel(
                                outlineId: list[i].outlineId,
                                approved: feedBackController.text);
                            lectureController
                                .approveOrRejectOutline(lecInfo)
                                .then((value) {
                              if (value.isSuccesfull) {
                                Get.snackbar(
                                    "Success", "Task Completed Successfully");
                              } else {
                                Get.snackbar("Error Occured", "Error Occured",
                                    backgroundColor: Colors.red);
                              }
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class ViewGradesDialogue extends StatelessWidget {
  ViewGradesDialogue({super.key, required this.assessmentId});
  final String assessmentId;
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
