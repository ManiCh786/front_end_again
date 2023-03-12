import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/controller.dart';
import '../../../models/models.dart';
import '../../../widgets/widgets.dart';
import '../../utils/utils.dart';
import '../admin/constants.dart';
import '../admin/responsive.dart';
import '../admin/screens/components/components.dart';
import 'dart:html' as html;

class ViewRoles extends StatelessWidget {
  ViewRoles({Key? key}) : super(key: key);
  final roleController = Get.find<RolesController>();
  final TextEditingController roleNameController = TextEditingController();

  final TextEditingController roleDescController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 10),
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
                    Get.dialog(
                      //Add ROles Dialog
                      Dialog(
                          child: SizedBox(
                        width: Get.width * 0.40,
                        height: Get.height * 0.70,
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 30, 20, 20),
                                  child: const Text("Add New Roles ",
                                      style: TextStyle(fontSize: 24),
                                      textAlign: TextAlign.center),
                                ),
                                const SizedBox(height: 20),
                                UserTypePageField(
                                  controller: roleNameController,
                                  hintText: "Role Name",
                                  typeKeyboard: TextInputType.text,
                                  validators: validateAField,
                                ),
                                const SizedBox(height: 20),
                                UserTypePageField(
                                  controller: roleDescController,
                                  hintText: "Role Desc.",
                                  typeKeyboard: TextInputType.text,
                                  validators: validateAField,
                                ),
                                const SizedBox(height: 30),
                                GetBuilder<RolesController>(
                                  builder: (controller) => controller.isLoading
                                      ? CustomButton(
                                          title: "Adding ..",
                                          btnTxtClr: Colors.white,
                                          btnBgClr: secondaryColor,
                                          onTap: () {})
                                      : CustomButton(
                                          title: "Add Role",
                                          btnTxtClr: Colors.white,
                                          btnBgClr: secondaryColor,
                                          onTap: () {
                                            _addRole();
                                          }),
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                      )),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 25,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Add New Role",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: GetBuilder<RolesController>(
              initState: (_) async {
                Future.delayed(Duration.zero).then(
                  (value) => Get.find<RolesController>().getAllRoles(),
                );
              },
              // init:            Get.find<RolesController>().getAllRoles(),
              // future:  roleController.getAllRoles(),
              builder: (roleController) {
                return roleController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      )
                    : Container(
                        child: roleController.rolesModel.isNotEmpty
                            ? ListView.builder(
                                itemCount: roleController.rolesModel.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return SingleChildScrollView(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2.5),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                          width: 1,
                                          color: Colors.grey,
                                        )),
                                        child: ListTile(
                                          tileColor: Colors.white,
                                          leading: Text(
                                            (index! + 1)
                                                .toString()
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                                fontSize: 18),
                                          ),
                                          trailing: TextButton(
                                              onPressed: () {
                                                Get.snackbar(
                                                    "${roleController.rolesModel[index].roleId}",
                                                    "Not Implemented Yet !");
                                                Get.back();
                                              },
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 25,
                                                ),
                                                color: Colors.red,
                                                onPressed: () {
                                                  var roleId = roleController
                                                      .rolesModel[index].roleId;
                                                  RolesModel roleData =
                                                      RolesModel(
                                                    roleId: roleId,
                                                  );
                                                  Get.dialog(GetBuilder<
                                                          RolesController>(
                                                      builder:
                                                          (roleController) {
                                                    return roleController
                                                            .isLoading
                                                        ? const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          )
                                                        : ConfirmationDialogue(
                                                            icon: Icons.warning,
                                                            iconColor:
                                                                Colors.red,
                                                            title:
                                                                "ARE YOU SURE ?",
                                                            action: () =>
                                                                roleController
                                                                    .deleteTheRole(
                                                                        roleData)
                                                                    .then(
                                                                        (status) {
                                                              if (status
                                                                  .isSuccesfull) {
                                                                Get.snackbar(
                                                                    "Success",
                                                                    status
                                                                        .message);

                                                                html.window
                                                                    .location
                                                                    .reload();
                                                                // Get.toNamed(Uri.base.toString());
                                                              } else {
                                                                Get.snackbar(
                                                                    "Error Occurred ",
                                                                    status
                                                                        .message);
                                                              }
                                                            }),
                                                          );
                                                  }));
                                                },
                                              )),
                                          title: Text(
                                            '${roleController.rolesModel[index].roleName}'
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          subtitle: Text(
                                            '${roleController.rolesModel[index].roleDesc}',
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontFamily: 'Poppins'),
                                          ),
                                        ),
                                      ),
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
        ],
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

      roleController.addRole(roleData).then((status) {
        roleNameController.text = "";
        roleDescController.text = "";
        if (status.isSuccesfull) {
          Get.snackbar("Success", status.message);
        } else {
          Get.snackbar("Error Occurred ", status.message);
        }
      });
    }
  }
}
