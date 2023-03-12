import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../controllers/controller.dart';
import '../../../../models/models.dart';
import '../../../../utils/utils.dart';

class ViewCourseDescriptionScreen extends StatelessWidget {
  ViewCourseDescriptionScreen({
    super.key,
  });

  final enrolledStudentController = Get.find<EnrolledStudentsController>();

  final coursesController = Get.find<CoursesController>();
  final enrollMentScheduleController =
      Get.find<EnrollmentsScheduleController>();

  // final Map<String, dynamic> args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // final args = Get.arguments;
    // final coursesDetails = args['courseDetails'];
       final coursesDetails =
        Get.arguments != null ? Get.arguments['courseDetails'] : null;

    // final coursesDetails = args['courseDetails'];
 if (coursesDetails == null) {
      Future.delayed(Duration.zero).then((value) => Get.offAllNamed("/"));
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: RichText(
            text: const TextSpan(children: [
              TextSpan(
                  text: 'U O C     ',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 23,
                    wordSpacing: 3,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  )),
              TextSpan(
                  text: 'Student Portal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontFamily: 'Poppins',
                  )),
            ]),
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.offAllNamed("/studentDashboard");
              }),
        ),
        body: GetBuilder<EnrolledStudentsController>(
            init: EnrolledStudentsController(enrolledStRepo: Get.find()),
            builder: (controller) {
              if (Get.arguments == null) {
                Future.delayed(Duration.zero, () => Get.back());
                return SizedBox.shrink();
              } else {
                return SingleChildScrollView(
                  child: Center(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0),
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
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      '${coursesDetails!=null?coursesDetails.courseName:""}',
                                      style: const TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins',
                                          fontSize: 28),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      // Profile Section end here
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
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
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 14.0),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    'Course Code  - ${coursesDetails!=null?coursesDetails.courseCode:""}   ',
                                                style: const TextStyle(
                                                  color: Colors.deepPurple,
                                                  fontSize: 23,
                                                  wordSpacing: 5,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins',
                                                )),
                                            TextSpan(
                                                text:
                                                    '   Course CrHr  - ${coursesDetails!=null?coursesDetails.courseCrHr:""}',
                                                style: const TextStyle(
                                                  color: Colors.deepPurple,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Poppins',
                                                )),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          '   Instructor Name - ${coursesDetails!=null?coursesDetails.fName:""} ${coursesDetails!=null?coursesDetails.lName:""}',
                                          style: const TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins',
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          '   Department - ${coursesDetails!=null?coursesDetails.department:""} ',
                                          style: const TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins',
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 14.0),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        RichText(
                                          text: TextSpan(children: [
                                            const TextSpan(
                                                text: 'Course Description  - ',
                                                style: TextStyle(
                                                  color: Colors.amber,
                                                  fontSize: 23,
                                                  wordSpacing: 5,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins',
                                                )),
                                            TextSpan(
                                                text:
                                                    '${coursesDetails!=null?coursesDetails.courseDesc:""}',
                                                style: const TextStyle(
                                                  color: Colors.deepPurple,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Poppins',
                                                )),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.15,
                                  ),
                                ]),
                                coursesDetails!=null ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: GetBuilder<
                                                    EnrolledStudentsController>(
                                                builder: (controller) {
                                              return TextButton(
                                                  onPressed: () {
                                                    // enrollNewStudent
                                                    final userId = Get.find<
                                                            UserAuthController>()
                                                        .getUserId();
                                                    final session =
                                                        Get.arguments['session']??"";
                                                    final coursesId =
                                                        coursesDetails.courseId??"";

                                                    DateTime originalDateTime =
                                                        DateTime.now();
                                                    DateFormat dateFormatter =
                                                        DateFormat
                                                            .yMd(); // or any other desired format
                                                    DateTime dateOnly =
                                                        dateFormatter.parse(
                                                            dateFormatter.format(
                                                                originalDateTime));

                                                    EnrolledStudentsModel
                                                        studentData =
                                                        EnrolledStudentsModel(
                                                      courseId: coursesId,
                                                      session:
                                                          session.replaceAll(
                                                              RegExp(r"\(|\)"),
                                                              ""),
                                                      startDate:
                                                          dateOnly.toString(),
                                                      userId: userId,
                                                      createdAt: AppUtils.now,
                                                      updatedAt: AppUtils.now,
                                                    );
                                                    enrolledStudentController
                                                        .enrollNewStudent(
                                                            studentData)
                                                        .then((status) {
                                                      if (status.isSuccesfull) {
                                                        Get.snackbar("Success",
                                                            status.message);
                                                        Get.offAllNamed(
                                                            "/studentDashboard");
                                                      } else {
                                                        Get.snackbar(
                                                            "Error Occured",
                                                            status.message);
                                                      }
                                                    });
                                                  },
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.deepPurple,
                                                      minimumSize:
                                                          const Size(0, 40)),
                                                  child: Text(
                                                      controller.isLoading
                                                          ? "Enrolling"
                                                          : "Enroll",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: 'Poppins',
                                                      )));
                                            }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ):Container(),
                              ]),
                        ),
                      )
                    ]),
                  ),
                );
              }
            }));
  }
}
