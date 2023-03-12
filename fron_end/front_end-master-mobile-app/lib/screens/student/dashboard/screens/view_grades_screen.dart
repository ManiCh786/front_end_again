import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/controller.dart';
import 'assesmenttable.dart';
import '../../coursespecification.dart/widgets/reportchart.dart';

class CourseGrade extends StatelessWidget {
  CourseGrade({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final courseDetails =
        Get.arguments != null ? Get.arguments['courseDetails'] : null;

    if (courseDetails == null) {
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
                  // fontWeight: FontWeight.bold,
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
      body: SingleChildScrollView(
        child: Center(
            child: GetBuilder<EnrolledStudentsController>(
                init: EnrolledStudentsController(enrolledStRepo: Get.find()),
                builder: (controller) {
                  // if (courseDetails == null) {
                  //   Future.delayed(Duration.zero, () => Get.back());
                  //   Get.offAllNamed("/studentDashboard");

                  //   return const SizedBox.shrink();
                  // } else {
                  return Column(
                    children: [
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
                                      '${courseDetails != null ? courseDetails.courseName : "Navigate Back"}  ${courseDetails != null ? courseDetails.courseCode : ""}',
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
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 14.0),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  RichText(
                                    text: const TextSpan(children: [
                                      TextSpan(
                                          text: 'Assessments Report  - ',
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 23,
                                            wordSpacing: 5,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold,
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
                            CourseAssessmentTable(
                              courseName:
                                  courseDetails !=null ?courseDetails.courseName : "",
                              session: courseDetails !=null?courseDetails.session : "",
                            ),
                            ReportChart()
                          ]),
                        ),
                      ),
                    ],
                  );
                  // }
                })),
      ),
    );
  }
}
