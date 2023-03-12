import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/controller.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import 'dart:html' as html;

import '../admin/constants.dart';
import '../admin/screens/components/components.dart';

class AssignCourseToInstructor extends StatelessWidget {
  AssignCourseToInstructor({Key? key}) : super(key: key);

  final courseController = Get.find<CoursesController>();

  final List<int> _semeters = [1, 2, 3, 4, 5, 6, 7, 8];
  final List<String> _session = ["Fall", "Spring", "Summer"];
  late int semester = 0;
  late String department = "empty";
  late String session = "empty";
  // final roleController  =  Get.find<RolesController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Header(),
            ),
            const SizedBox(height: defaultPadding),
            Expanded(
              child: GetBuilder<CoursesController>(
                initState: (_) {
                  Get.find<CoursesController>().getAllCourses();
                  Future.delayed(Duration.zero).then((value) => 
                  Get.find<CoursesController>().getAllAssignedCourses()
                  );

                },
                builder: (courseController) {
                  return courseController.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.black))
                      : Container(
                          child: courseController.allCourses.isNotEmpty
                              ? ListView.builder(
                                  itemCount: courseController.allCourses.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2.5),
                                      child: ListTile(
                                        tileColor: Colors.white,
                                        leading: Text(
                                          (index + 1).toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                          ),
                                        ),
                                        trailing: SizedBox(
                                          width: Get.width * 0.50,
                                          child: Row(
                                            // mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GetBuilder<CoursesController>(
                                                  builder: (courseController) {
                                                return DropdownButton<int>(
                                                  // hint: const Text("Select Semester"),
                                                  hint: Text(
                                                    courseController
                                                        .dropdownPlaceholder,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Poppins'),
                                                  ),
                                                  // onTap: (){
                                                  //   courseController.dropdownPlaceholder = courseController.semDropdownInitialValue;
                                                  // },
                                                  value: courseController
                                                      .semDropdownInitialValue,
                                                  items: _semeters
                                                      .map((int value) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: value,
                                                      child: Text(
                                                          value.toString()),
                                                      onTap: () {
                                                        courseController
                                                                .dropdownPlaceholder =
                                                            value.toString();
                                                      },
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    courseController
                                                            .semDropdownInitialValue =
                                                        value!;
                                                    semester = courseController
                                                        .semDropdownInitialValue;
                                                  },
                                                );
                                              }),
                                              SpacerX(),
                                              GetBuilder<CoursesController>(
                                                  builder: (courseController) {
                                                return DropdownButton<String>(
                                                  hint: Text(
                                                    courseController
                                                        .depDropdownPlaceholder,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Poppins'),
                                                  ),
                                                  value: courseController
                                                      .depDropdownInitialValue,
                                                  items: <String>['CS', 'SE']
                                                      .map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                      onTap: () {
                                                        courseController
                                                                .depDropdownPlaceholder =
                                                            value;
                                                      },
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    courseController
                                                            .depDropdownInitialValue =
                                                        value!;
                                                    department = courseController
                                                        .depDropdownInitialValue;
                                                  },
                                                );
                                              }),
                                              SpacerX(),
                                              GetBuilder<CoursesController>(
                                                  builder: (courseController) {
                                                return DropdownButton<String>(
                                                  hint: Text(
                                                    courseController
                                                        .sessionDropdownPlaceholder,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                  value: courseController
                                                      .sessionDropdownInitialValue,
                                                  items: _session
                                                      .map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                      onTap: () {
                                                        courseController
                                                                .sessionDropdownPlaceholder =
                                                            value;
                                                      },
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    courseController
                                                            .sessionDropdownInitialValue =
                                                        value!;
                                                    session = courseController
                                                        .sessionDropdownInitialValue;
                                                  },
                                                );
                                              }),
                                              SpacerX(),
                                              GetBuilder<UserAuthController>(
                                                // init: Get.find<RolesController>(),
                                                initState: (_) async {
                                                  Future.delayed(Duration.zero)
                                                      .then(
                                                    (value) => Get.find<
                                                            UserAuthController>()
                                                        .getAllFacultyMembers(),
                                                  );
                                                },
                                                // initState: (_) =>
                                                // Get.find<RolesController>().getAllRoles(),
                                                builder: (userController) {
                                                  return DropdownButton(
                                                      value: userController
                                                          .dropdownInitialValue,
                                                      // Down Arrow Icon
                                                      icon: const Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        size: 25,
                                                        color: Colors.black,
                                                      ),
                                                      hint: Text(
                                                        userController
                                                            .dropdownPlaceholder,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'Poppins'),
                                                      ),
                                                      items: userController
                                                          .allFacultyMembers
                                                          .map((list) =>
                                                              DropdownMenuItem(
                                                                value: list
                                                                    .userId
                                                                    .toString(),
                                                                onTap: () {
                                                                  userController
                                                                      .dropdownPlaceholder = list
                                                                          .fName +
                                                                      list.lName;
                                                                },
                                                                child: Text(list
                                                                    .fName
                                                                    .toString()
                                                                    .capitalizeFirst!),
                                                              ))
                                                          .toList(),
                                                      onChanged: (value) {
                                                        userController
                                                                .dropdownInitialValue =
                                                            value;
                                                        var userId = userController
                                                            .dropdownInitialValue;
                                                        var data = {
                                                          'courseId':
                                                              courseController
                                                                  .allCourses[
                                                                      index]
                                                                  .courseId,
                                                          'instructor_userId':
                                                              userId,
                                                          'semester': semester,
                                                          'department':
                                                              department
                                                                  .toLowerCase(),
                                                          'session': session
                                                              .toLowerCase(),
                                                          'created_at':
                                                              AppUtils.now,
                                                          'updated_at':
                                                              AppUtils.now,
                                                        };
                                                        semester == 0 ||
                                                                department ==
                                                                    "empty" ||
                                                                session ==
                                                                    "empty"
                                                            ? Get.snackbar(
                                                                "All DropDowns Are Mandatory",
                                                                "Select each dropdown to continue ")
                                                            : Get.dialog(
                                                                GetBuilder<
                                                                    CoursesController>(
                                                                  builder:
                                                                      (courseController) {
         RxList<dynamic> list = [].obs;

                                                                        
                                                                                  list=Get.find<CoursesController>().allAssignedCourses.
                                                                                  where((e) => 
                                                                                   e.instructorUserId.toString()
                                                                                   .replaceAll(
                                                            RegExp(r"\(|\)"),
                                                            "").contains(userId.toString())).where((w) => w.session.toString().replaceAll(
                                                            RegExp(r"\(|\)"),
                                                            "").contains(session.toString().toLowerCase())).
                                                            toList().obs;
                                                                int totalCreditHours = 0;
                                                                  for (var course in list) {
                                                                    totalCreditHours += int.parse(course.courseCrHr.toString());
                                                                  }


                                                                                  print("list is ${list.map((e) => e.courseCrHr)}");
                                                                                  print("totalCreditHours is ${totalCreditHours}");
                                                                                
                                                                    return courseController
                                                                            .isLoading
                                                                        ? const Center(
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                            color:
                                                                                Colors.black,
                                                                          ))
                                                                        : ConfirmationDialogue(
                                                                            icon: Icons
                                                                                .info,
                                                                            iconColor: Colors
                                                                                .green,
                                                                            title:
                                                                                "Assign  ${courseController.allCourses[index].courseName} Course to  ${userController.dropdownPlaceholder.toString().capitalizeFirst}  ?",
                                                                            cancelButtonColor:
                                                                                Colors.red,
                                                                            confirmButtonColor: Colors.green,
                                                                            action: () => {
                                                                              

                                                                                  Get.back(),
                                                                                  if(totalCreditHours<12){
     courseController.assignCourseToInstructor(data).then((status) {
                                                                                    if (status.isSuccesfull) {
                                                                                      html.window.location.reload();
                                                                                      Get.snackbar("Success", status.message);
                                                                                    } else {
                                                                                      Get.snackbar("Error Occurred ", status.message);
                                                                                    }
                                                                                  }),
                                                                                  }else{
                                                                                          
                                                                                      Get.snackbar("Error Occurred ", "This user is already assigned 12 credit hours",backgroundColor: Colors.red),
                                                                                  }
                                                                             
                                                                                });
                                                                  },
                                                                ),
                                                              );
                                                      });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        title: Text(
                                          '${courseController.allCourses[index].courseName}'
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        subtitle: Text(
                                          '${courseController.allCourses[index].courseCode}',
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    );
                                  })
                              : const Center(
                                  child: Text(
                                    "Nothing to show Here !",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 26),
                                  ),
                                ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
      // GetBuilder<RegistrationController>(
      //
      //   builder: (registrationController){
      //     return Container(
      //       child: ListView.builder(
      //         itemCount: 4,
      //         itemBuilder: (BuildContext context, int index) {
      //           return ListTile(
      //             leading: IconButton(
      //                 icon: const Icon(Icons.list),
      //                 onPressed: () {
      //                   // Get.back();
      //                 }
      //             ),
      //             title: Text(registrationController.registrationData.fName!),
      //           );
      //         }),
      //     );
      //   },
      // ),
    );
  }
}
