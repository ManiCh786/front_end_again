import 'package:flutter/material.dart';
import 'package:front_end/models/lectures_model.dart';
import 'package:get/get.dart';

import '../../../../../controllers/lecturesController.dart';

class OutlineTable extends StatefulWidget {
  OutlineTable(
      {super.key,
      required this.courseName,
      required this.session,
      required this.createdAt});
  String courseName;
  String session;
  String createdAt;

  @override
  State<OutlineTable> createState() => _OutlineTableState();
}

class _OutlineTableState extends State<OutlineTable> {
  final scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final feedBackController = TextEditingController();
  final lectureController = Get.find<LecturesController>();
  var year = DateTime.now().year.toString().obs;
  bool outlineApproved = false;
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
        label: Text("Status"),
        tooltip: "Approve Outline Added in this lecture"),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Column(children: [
            const Padding(
              padding: EdgeInsets.only(top: 22.0),
              child: Text(
                'Session Schedule',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            DropDownForYears(),
            GetBuilder<LecturesController>(initState: (_) {
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

              for (int i = 0; i < list.length; i++) {
                list[i].approved != "yes"
                    ? outlineApproved = false
                    : outlineApproved = true;
              }

              return lecController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : list.isEmpty
                      ? const Center(
                          child: Text("Nothing to Show Here !"),
                        )
                      : Column(
                          children: [
                            Container(
                              height: Get.height * 0.70,
                              width: Get.width * .80,
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
                                          dataRowHeight: 100,
                                          columnSpacing: 40,
                                          dividerThickness: 2,
                                          sortAscending: true,
                                          columns: _columns,
                                          rows: [
                                            for (var i = 0;
                                                i < list.length;
                                                i++)
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
                                                      style:
                                                          DefaultTextStyle.of(
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
                                                          list[i]
                                                              .file
                                                              .toString(),
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
                                                                color: Colors
                                                                    .green,
                                                              )
                                                            : const Icon(
                                                                Icons.download),
                                                        onPressed: () {
                                                          final addedBy =
                                                              list[i].addedBy;
                                                          final fileName =
                                                              list[i].file;
                                                          _downloadOutlineFile(
                                                              fileName
                                                                  .toString(),
                                                              addedBy);
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
                                                      style:
                                                          DefaultTextStyle.of(
                                                                  context)
                                                              .style,
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
                                                      style:
                                                          DefaultTextStyle.of(
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
                                                  list[i].fName.toString() !=
                                                          "null"
                                                      ? Text(
                                                          "Approved By ${list[i].fName}")
                                                      : Text("Not Approved "),
                                                ),
                                              ]),
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            !outlineApproved
                                ? Container(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          child: const Text(
                                            "Approve",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.green,
                                          ),
                                          onPressed: () {
                                            LecturesModel lecInfo =
                                                LecturesModel(
                                              subject: widget.courseName,
                                              session: widget.session,
                                              approved: "yes",
                                            );
                                            lectureController
                                                .approveOrRejectOutline(lecInfo)
                                                .then(
                                              (value) {
                                                if (value.isSuccesfull) {
                                                  Get.snackbar("Success",
                                                      "Task Completed Successfully");
                                                } else {
                                                  Get.snackbar("Error Occured",
                                                      "Error Occured",
                                                      backgroundColor:
                                                          Colors.red);
                                                }
                                              },
                                            );
                                          },
                                        ),
                                        TextButton(
                                          child: const Text(
                                            "Reject",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.red,
                                          ),
                                          onPressed: () {
                                            LecturesModel lecInfo =
                                                LecturesModel(
                                              subject: widget.courseName,
                                              session: widget.session,
                                              approved: "no",
                                            );
                                            lectureController
                                                .approveOrRejectOutline(lecInfo)
                                                .then(
                                              (value) {
                                                if (value.isSuccesfull) {
                                                  Get.snackbar("Success",
                                                      "Task Completed Successfully");
                                                } else {
                                                  Get.snackbar("Error Occured",
                                                      "Error Occured",
                                                      backgroundColor:
                                                          Colors.red);
                                                }
                                              },
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                : Text("")
                          ],
                        );
            }),

            // nn
          ])),
    );
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
