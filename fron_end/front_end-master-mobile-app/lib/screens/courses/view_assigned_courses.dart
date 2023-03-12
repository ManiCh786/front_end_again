import 'package:flutter/material.dart';
import 'package:front_end/controllers/controller.dart';
import 'package:get/get.dart';

import '../../models/models.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../admin/constants.dart';
import '../admin/responsive.dart';
import '../admin/screens/components/components.dart';

class ViewAssignedCourses extends StatefulWidget {
  ViewAssignedCourses({Key? key}) : super(key: key);

  @override
  State<ViewAssignedCourses> createState() => _ViewAssignedCoursesState();
}

class _ViewAssignedCoursesState extends State<ViewAssignedCourses> {
  final TextEditingController courseNameController = TextEditingController();

  final TextEditingController courseCodeController = TextEditingController();

  final TextEditingController courseCrHrController = TextEditingController();

  final TextEditingController courseDescController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final courseController = Get.find<CoursesController>();
  String? searchQuery = ""
;  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Header(),
          ),
          const SizedBox(height: defaultPadding),
           
          const SizedBox(height: defaultPadding),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {
                    addNewCourseMethod();
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 25,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Add New Course",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: GetBuilder<CoursesController>(initState: (_) async {
              await Future.delayed(Duration.zero).then(
                (value) =>
                    Get.find<CoursesController>().getAllAssignedCourses(),
              );
            }, builder: (courseController) {
         RxList<dynamic> filterdList = [].obs;
if(searchQuery!.isNotEmpty){
              filterdList = courseController.allAssignedCourses.where((e) => e.fName.toString().toLowerCase().contains(searchQuery!)).toList().obs;

}else{
filterdList = courseController.allAssignedCourses.toList().obs;
}
              return courseController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.black,
                    ))
                  : courseController.allAssignedCourses.isEmpty
                      ? const Text(
                          "Nothing Found !",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Column(
                            children: [
                               Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    onChanged: (value){
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search by Instructor Name ...",
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    ),
                  ),
                ),
            ),
                              Expanded(
                                child: Container(
                                  width: Get.width * 0.80,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        showBottomBorder: true,
                                        dataTextStyle:
                                            const TextStyle(color: Colors.white),
                                        border: TableBorder.all(
                                            color: Colors.deepPurple,
                                            style: BorderStyle.solid,
                                            width: 2),
                                        columns: const [
                                          // Set the name of the column
                                          DataColumn(
                                            label: Text(
                                              'Course Code',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Course Name',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Semester',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Session',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Cr Hr',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Department',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Assigned To',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          // DataColumn(
                                          //   label: Text('Update',style:TextStyle(
                                          //   color: Colors.green,
                                          // )),),
                                          // DataColumn(label: Text('Delete' ,style:TextStyle(
                                          //   color: Colors.red,
                                          // )),),
                                        ],
                                        rows: filterdList
                                            .map(
                                              (e) => DataRow(cells: [
                                                DataCell(Text(
                                                  e.courseCode ?? "null",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14),
                                                )),
                                                DataCell(Text(
                                                  e.courseName ?? "null",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14),
                                                )),
                                                DataCell(Text(
                                                  e.semester.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14),
                                                )),
                                                DataCell(Text(
                                                  e.session.toString() +
                                                      " - " +
                                                      DateTime.parse(e.createdAt)
                                                          .year
                                                          .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14),
                                                )),
                                                DataCell(Text(
                                                  e.courseCrHr.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14),
                                                )),
                                                DataCell(Text(
                                                  e.department
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14),
                                                )),
                                                DataCell(Text(
                                                  e.fName + " " + e.lName,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14),
                                                )),
                                                // DataCell( CustomTextButton(
                                                //   title: "Update",
                                                //   onTap: (){},
                              
                                                //   backgroundColor: Colors.green,
                                                //   textColor: Colors.white,
                                                // )),
                                                // DataCell(
                                                //     CustomTextButton(
                                                //       title: "Delete",
                                                //       onTap: (){},
                                                //       backgroundColor: Colors.red,
                                                //       textColor: Colors.white,
                                                //     )
                                                // ),
                                              ]),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
            }),
          ),
        ],
      ),
    );
  }

  Future<dynamic> addNewCourseMethod() {
    return Get.dialog(
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
                  child: const Text("Add New Course ",
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

//
// Container(
// width: Get.width * 0.80,
// child: DataTable(
//
// dataTextStyle: TextStyle(color: Colors.white),
// border:  TableBorder.all(
// color: secondaryColor,
//
// style: BorderStyle.solid,
// width: 2),
// columns: [
// // Set the name of the column
// DataColumn(label: Text('Course Name'),),
// DataColumn(label: Text('Assigned To'),),
// DataColumn(label: Text('Semester'),),
// DataColumn(label: Text('Department'),),
// ],
// rows:[
// // Set the values to the columns
// DataRow(cells: [
// DataCell(Text("1")),
// DataCell(Text("Alex")),
// DataCell(Text("Anderson")),
// DataCell(Text("18")),
// ]),
// DataRow(cells: [
// DataCell(Text("2")),
// DataCell(Text("John")),
// DataCell(Text("Anderson")),
// DataCell(Text("24")),
// ]),
// ]
// ),
// ),