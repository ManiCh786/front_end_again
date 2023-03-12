
import 'package:flutter/material.dart';
import '/controllers/controller.dart';
import '/models/models.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class AddRole extends StatelessWidget {
  AddRole({Key? key}) : super(key: key);

  final roleController = Get.find<RolesController>();

  final TextEditingController roleNameController = TextEditingController();

  final TextEditingController roleDescController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                UserTypePageField(
                  controller: roleNameController,
                  hintText: "Role Name",
                  typeKeyboard: TextInputType.text,
                  validators: validateAField,

                ),
                const SizedBox(height: 30),
                UserTypePageField(
                  controller: roleDescController,
                  hintText: "Role Desc.",
                  typeKeyboard: TextInputType.text,
                  validators: validateAField,

                ),

                const SizedBox(height: 30),
                TextButton(
                  child: GetBuilder<RolesController>(
                    builder: (controller) =>  controller.isLoading ? const Center(child: CircularProgressIndicator()): const Text("Add Role"),
                  ),onPressed: () {
                    _addRole();
                  },
                ),TextButton(
                  child: const Text("Back"),onPressed: () {
                  Get.toNamed("/adminDashboard");
                },
                ),
              ],
            ),
          ),
        ),
      );

  }

  _addRole() async {
    
    if (_formKey.currentState!.validate()) {
      RolesModel roleData = RolesModel(
          roleName: roleNameController.text.trim().toLowerCase(),
          roleDesc: roleDescController.text.trim(),
          createdAt: AppUtils.now,
          updatedAt: AppUtils.now,
      );

      roleController.addRole(roleData).then((status){
        roleNameController.text ="";
        roleDescController.text ="";
        if(status.isSuccesfull){
          Get.snackbar("Success", status.message);
        }
        else{
          Get.snackbar("Error Occurred ", status.message);
        }
      });
    }
  }
}
