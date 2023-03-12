import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/controller.dart';
import '../../../models/models.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';



class AddCourses extends StatelessWidget {
   AddCourses({Key? key}) : super(key: key);

  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController courseCodeController = TextEditingController();
  final TextEditingController courseCrHrController = TextEditingController();
  final TextEditingController courseDescController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   final courseController = Get.find<CoursesController>();

   @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                UserTypePageField(
                  controller: courseNameController,
                  hintText: "Course Name",
                  typeKeyboard: TextInputType.text,
                  validators: validateAField,

                ),
                const SizedBox(height: 30),
                UserTypePageField(
                  controller: courseCodeController,
                  hintText: "Course Code" ,
                  typeKeyboard: TextInputType.text,
                  validators: validateAField,

                ),
                const SizedBox(height: 30),            UserTypePageField(
                  controller: courseCrHrController,
                  hintText: "Course CrHr",
                  typeKeyboard: TextInputType.number,
                  validators: validateAField ,

                ),
                const SizedBox(height: 30),
                UserTypePageField(
                  controller: courseDescController,
                  hintText: "Course Desc.",
                  typeKeyboard: TextInputType.text,
                  validators: validateAField,


                ),
                const SizedBox(height: 30),
                TextButton(
                  child: Text("Add"),
                  onPressed: (){
                    _addCourse();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
   void _addCourse() {
     CoursesModel  courseData = CoursesModel(
         courseName: courseNameController.text.toLowerCase(),

         courseCode: courseCodeController.text.toLowerCase(),
      courseCrHr: courseCrHrController.text,
      courseDesc: courseDescController.text ,
       createdAt: AppUtils.now,
       updatedAt: AppUtils.now,
     );
     if(_formKey.currentState!.validate()){
       courseController.addCourse(courseData).then((status){
         courseNameController.text = "";
         courseCodeController.text = "";
         courseCrHrController.text = "";
         courseDescController.text ="";
         if(status.isSuccesfull){
           Get.snackbar("Success", status.message);
         }else{
           Get.snackbar("Error Occurred ", status.message);
         }
       });
     }
     // print(courseData);
   }
}
