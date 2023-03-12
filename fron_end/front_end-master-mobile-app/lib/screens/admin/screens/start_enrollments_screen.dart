import 'package:flutter/material.dart';
import 'package:front_end/data/repository/start_enrollment_repo.dart';
import 'package:front_end/models/start_enrollment_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/controller.dart';
import '../../../controllers/lecturesController.dart';
import '../../../data/repository/lectures_repo.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../constants.dart';
import 'components/header.dart';

class StartEnrollmentScreen extends StatefulWidget {
  const StartEnrollmentScreen({Key? key}) : super(key: key);

  @override
  _StartEnrollmentScreen createState() => _StartEnrollmentScreen();
}

class _StartEnrollmentScreen extends State<StartEnrollmentScreen> {
  late DateTime _fromDate;
  late DateTime _toDate;

  final List<String> _session = ["Fall", "Spring", "Summer"];
  late String session = "empty";
  final repo =
      Get.put<StartEnrollmentRepo>(StartEnrollmentRepo(apiClient: Get.find()));
  final enrollmentScheduleController =
      Get.put<EnrollmentsScheduleController>(EnrollmentsScheduleController(
    enrScheduleRepo: Get.find(),
  ));
  @override
  void initState() {
    super.initState();
    // Set the initial values for the dates to the current date.
    _fromDate = DateTime.now();
    _toDate = DateTime.now();
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _fromDate = picked;
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _toDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _toDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Header(),
          ),
          const SizedBox(height: defaultPadding),
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: ListTile(
                  // tileColor: Colors.white,
                  hoverColor: secondaryColor,
                  leading: const Text(
                    "Start Enrollment",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: SizedBox(
                    width: Get.width * 0.50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // Sessions Dropdown
                        GetBuilder<EnrollmentsScheduleController>(
                            builder: (startSchedController) {
                          return DropdownButton<String>(
                            hint: Text(
                              startSchedController.sessionDropdownPlaceholder,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 18),
                            ),
                            value: startSchedController
                                .sessionDropdownInitialValue,
                            items: _session.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                                onTap: () {
                                  startSchedController
                                      .sessionDropdownPlaceholder = value;
                                },
                              );
                            }).toList(),
                            onChanged: (value) {
                              startSchedController.sessionDropdownInitialValue =
                                  value!;
                              session = startSchedController
                                  .sessionDropdownInitialValue;
                            },
                          );
                        }),
                        // From Date Picker
                        GestureDetector(
                          onTap: () => _selectFromDate(context),
                          child: Column(
                            children: <Widget>[
                              const Text(
                                'From',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${_fromDate.day}/${_fromDate.month}/${_fromDate.year}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),

                        // To Date Picker
                        GestureDetector(
                          onTap: () => _selectToDate(context),
                          child: Column(
                            children: <Widget>[
                              const Text(
                                'To',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${_toDate.day}/${_toDate.month}/${_toDate.year}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        GetBuilder<EnrollmentsScheduleController>(
                          builder: (controller) => TextButton(
                              child: Text(
                                  controller.isLoading
                                      ? "Adding"
                                      : "Add Schedule",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 16)),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                              ),
                              onPressed: () {
                                print(_fromDate);
                                print(_toDate);
                                if (session == "empty") {
                                  Get.snackbar("Session is Empty",
                                      "Select Session to Start  Enrollment");
                                } else {
                                  StartEnrollmentModel addEnrollmentData =
                                      StartEnrollmentModel(
                                    // startDate: _fromDate.toString(),
                                    startDate: DateFormat('yyyy-MM-dd')
                                        .format(_fromDate.toLocal())
                                        .toString(),
                                    endDate: DateFormat('yyyy-MM-dd')
                                        .format(_toDate.toLocal())
                                        .toString(),

                                    // endDate: _toDate.toString(),
                                    // endDate: DateFormat.yMd().format(dateTime)
                                    session: session.toLowerCase(),
                                    createdAt: AppUtils.now,
                                    updatedAt: AppUtils.now,
                                  );
                                  enrollmentScheduleController
                                      .addEnrollmentSchedule(addEnrollmentData)
                                      .then((status) {
                                    if (status.isSuccesfull) {
                                      Get.snackbar("Success", status.message);
                                    } else {
                                      Get.snackbar(
                                          "Error Occurred ", status.message);
                                    }
                                  });
                                }
                              }),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          //   Expanded(
          // child: GetBuilder<EnrollmentsScheduleController>(
          //   initState: (_) {
          //     Get.find<EnrollmentsScheduleController>()
          //         .getAllEnrollmentSchedules();
          //   },
          //   builder: (scheduleController) {
          //     return scheduleController.isLoading
          //         ? const Center(
          //             child: CircularProgressIndicator(color: Colors.black))
          //         : Container(
          //             child: scheduleController
          //                     .allEnrollmentSchedules.isNotEmpty
          //                 ? ListView.builder(
          //                     itemCount: scheduleController
          //                         .allEnrollmentSchedules.length,
          //                     itemBuilder: (BuildContext context, int index) {
          //                       return Padding(
          //                         padding: const EdgeInsets.symmetric(
          //                             horizontal: 10, vertical: 2.5),
          //                         child: ListTile(
          //                           tileColor: Colors.white,
          //                           hoverColor: secondaryColor,
          //                           leading: Text((index + 1).toString()),
          //                           trailing: SizedBox(
          //                             width: Get.width * 0.50,
          //                             child: Row(
          //                               // mainAxisSize: MainAxisSize.min,
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.spaceEvenly,
          //                               children: [
          //                                 Text(
          //                                     " Session : ${scheduleController.allEnrollmentSchedules[index].session}"),
          //                                 Text(
          //                                     " Added BY : ${scheduleController.allEnrollmentSchedules[index].fName + scheduleController.allEnrollmentSchedules[index].lName}"),
          //                               ],
          //                             ),
          //                           ),
          //                           title: Text(
          //                               " Start Date : ${scheduleController.allEnrollmentSchedules[index].startDate}"),
          //                           subtitle: Text(
          //                               " End Date : ${scheduleController.allEnrollmentSchedules[index].endDate}"),
          //                         ),
          //                       );
          //                     })
          //                 : const Center(
          //                     child: Text(
          //                       "Nothing to show Here !",
          //                       style: TextStyle(
          //                           color: Colors.white, fontSize: 26),
          //                     ),
          //                   ),
          //           );
          //   },
          // ),
          //   ),
        ]));
  }
}
