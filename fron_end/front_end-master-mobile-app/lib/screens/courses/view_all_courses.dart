import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/controller.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../admin/constants.dart';
import '../admin/responsive.dart';
import '../admin/screens/components/components.dart';

class ViewAllCourses extends StatelessWidget {
  ViewAllCourses({Key? key}) : super(key: key);
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController courseCodeController = TextEditingController();
  final TextEditingController courseCrHrController = TextEditingController();
  final TextEditingController courseDescController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final courseController = Get.find<CoursesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Header(),
          ),
          const SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {
                    addNewCourseMethod();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add New Course"),
                ),
              ),
            ],
          ),
          Expanded(
            child: GetBuilder<CoursesController>(
              initState: (_) async {
                Future.delayed(Duration.zero).then(
                  (value) => Get.find<CoursesController>().getAllCourses(),
                );
              },
              // init:            Get.find<RolesController>().getAllRoles(),
              // future:  roleController.getAllRoles(),
              builder: (courseController) {
                return courseController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      )
                    : Container(
                        child: courseController.myCourses.isNotEmpty
                            ? ListView.builder(
                                itemCount: courseController.myCourses.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return SingleChildScrollView(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2.5),
                                    child: ListTile(
                                      tileColor: Colors.white,
                                      leading: Text((index + 1).toString()),
                                      trailing: TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: IconButton(
                                            icon: const Icon(Icons.delete),
                                            color: Colors.red,
                                            onPressed: () {
                                              var courseId = courseController
                                                  .myCourses[index].courseId;
                                              CoursesModel data = CoursesModel(
                                                  courseId: courseId);
                                            },
                                          )),
                                      title: Text(courseController
                                          .allCourses[index].courseName),
                                      subtitle: Text(courseController
                                          .allCourses[index].courseDesc),
                                    ),
                                  );
                                })
                            : const Center(
                                child: Text(
                                  "Nothing Found !",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                              ),
                      );
              },
            ),
          ),
        ]));
  }

  Future<dynamic> addNewCourseMethod() {
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
                  child: const Text("Add New Roles ",
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center),
                ),
                const SizedBox(height: 20),
                UserTypePageField(
                  controller: courseNameController,
                  hintText: "Course Name",
                  typeKeyboard: TextInputType.text,
                  validators: validateAField,
                ),
                const SizedBox(height: 20),
                UserTypePageField(
                  controller: courseCodeController,
                  hintText: "Course Code",
                  typeKeyboard: TextInputType.text,
                  validators: validateAField,
                ),
                const SizedBox(height: 20),
                UserTypePageField(
                  controller: courseCrHrController,
                  hintText: "Course CrHr",
                  typeKeyboard: TextInputType.number,
                  validators: validateAField,
                ),
                const SizedBox(height: 20),
                UserTypePageField(
                  controller: courseDescController,
                  hintText: "Course Desc.",
                  typeKeyboard: TextInputType.text,
                  validators: validateAField,
                ),
                const SizedBox(height: 30),
                GetBuilder<CoursesController>(
                  builder: (controller) => controller.isLoading
                      ? CustomButton(
                          title: "Adding ..",
                          btnTxtClr: Colors.white,
                          btnBgClr: secondaryColor,
                          onTap: () {})
                      : CustomButton(
                          title: "Add Course",
                          btnTxtClr: Colors.white,
                          btnBgClr: secondaryColor,
                          onTap: () {
                            _addCourse();
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

  void _addCourse() {
    CoursesModel courseData = CoursesModel(
      courseName: courseNameController.text.toLowerCase(),
      courseCode: courseCodeController.text.toLowerCase(),
      courseCrHr: courseCrHrController.text,
      courseDesc: courseDescController.text,
      createdAt: AppUtils.now,
      updatedAt: AppUtils.now,
    );
    if (_formKey.currentState!.validate()) {
      courseController.addCourse(courseData).then((status) {
        courseNameController.text = "";
        courseCodeController.text = "";
        courseCrHrController.text = "";
        courseDescController.text = "";
        if (status.isSuccesfull) {
          Get.snackbar("Success", status.message);
        } else {
          Get.snackbar("Error Occurred ", status.message);
        }
      });
    }
    // print(courseData);
  }
}
