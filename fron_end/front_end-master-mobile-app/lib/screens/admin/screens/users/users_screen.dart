import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/controller.dart';
import '../../../../models/models.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../../../screens.dart';
import '../../constants.dart';
import '../components/components.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({Key? key}) : super(key: key);
  final registrationController = Get.find<RegistrationController>();
  final roleController = Get.find<RolesController>();
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
              child: GetBuilder<RegistrationController>(
                initState: (_) {
                  Future.delayed(Duration.zero).then((value) =>
                      Get.find<RegistrationController>().getRegisteredUsers());
                },
                // future: registrationController.getRegisteredUsers(),
                builder: (registrationController) {
                  return registrationController.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.black))
                      : Container(
                          child: registrationController
                                  .registeredUsersList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: registrationController
                                      .registeredUsersList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SingleChildScrollView(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 2),
                                            color: Colors.white),
                                        child: ListTile(
                                          leading: IconButton(
                                              icon: const Icon(Icons.list,
                                                  color: Colors.black,
                                                  size: 30),
                                              onPressed: () {
                                                // Get.back();
                                              }),
                                          trailing: SizedBox(
                                            width: 300,
                                            child: Row(
                                              // mainAxisSize: MainAxisSize.min,
                                              children: [
                                                GetBuilder<RolesController>(
                                                  // init: Get.find<RolesController>(),
                                                  initState: (_) async {
                                                    Future.delayed(
                                                            Duration.zero)
                                                        .then(
                                                      (value) => Get.find<
                                                              RolesController>()
                                                          .getAllRoles(),
                                                    );
                                                  },
                                                  // initState: (_) =>
                                                  // Get.find<RolesController>().getAllRoles(),
                                                  builder: (roleController) {
                                                    return DropdownButton(
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                'Poppins',
                                                            color:
                                                                Colors.black),
                                                        value: roleController
                                                            .dropdownInitialValue,
                                                        // Down Arrow Icon
                                                        icon: const Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          color: Colors.black,
                                                          size: 30,
                                                        ),
                                                        hint: Text(
                                                          roleController
                                                              .dropdownPlaceholder,
                                                          style:
                                                              const TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        items: roleController
                                                            .rolesModel
                                                            .map((list) =>
                                                                DropdownMenuItem(
                                                                  value: list
                                                                      .roleId
                                                                      .toString(),
                                                                  onTap: () {
                                                                    roleController
                                                                            .dropdownPlaceholder =
                                                                        list.roleName;
                                                                  },
                                                                  // enabled: list == null ?true:false,
                                                                  child: Text(list
                                                                      .roleName
                                                                      .toString()
                                                                      .capitalizeFirst!),
                                                                ))
                                                            .toList(),
                                                        onChanged: (value) {
                                                          roleController
                                                                  .dropdownInitialValue =
                                                              value;
                                                          var regId =
                                                              registrationController
                                                                  .registeredUsersList[
                                                                      index]
                                                                  .regId;
                                                          var roleId =
                                                              roleController
                                                                  .dropdownInitialValue;

                                                          var data = {
                                                            'regId': regId,
                                                            'roleId': roleId,
                                                            'created_at':
                                                                AppUtils.now,
                                                            'updated_at':
                                                                AppUtils.now,
                                                          };
                                                          Get.dialog(
                                                            GetBuilder<
                                                                RegistrationController>(
                                                              builder:
                                                                  (regController) {
                                                                return regController
                                                                        .isLoading
                                                                    ? const Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                        color: Colors
                                                                            .black,
                                                                      ))
                                                                    : ConfirmationDialogue(
                                                                        icon: Icons
                                                                            .info,
                                                                        iconColor:
                                                                            Colors
                                                                                .green,
                                                                        // var t = roleController.dropdownPlaceholder;
                                                                        title:
                                                                            "Assign ${roleController.dropdownPlaceholder.toString().capitalizeFirst} to this ${registrationController.registeredUsersList[index].fName + registrationController.registeredUsersList[index].lName} ?",
                                                                        cancelButtonColor:
                                                                            Colors
                                                                                .red,
                                                                        confirmButtonColor:
                                                                            Colors
                                                                                .green,
                                                                        action: () =>
                                                                            {
                                                                              registrationController.assignRoleToRegUser(data).then((status) {
                                                                                if (status.isSuccesfull) {
                                                                                  Get.snackbar("Success", status.message);
                                                                                  Navigator.pushAndRemoveUntil(
                                                                                    context,
                                                                                    MaterialPageRoute(builder: (context) => ViewAllRegisteredUsers()),
                                                                                    (Route<dynamic> route) => false,
                                                                                  );
                                                                                  Get.toNamed("/viewAllRegisteredUsers");
                                                                                } else {
                                                                                  Get.snackbar("Error Occurred ", status.message);
                                                                                }
                                                                              }),
                                                                            });
                                                              },
                                                            ),
                                                          );
                                                        });
                                                  },
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    size: 25,
                                                  ),
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    RegistrationModel
                                                        regUserData =
                                                        RegistrationModel(
                                                      regId: registrationController
                                                          .registeredUsersList[
                                                              index]
                                                          .regId,
                                                    );
                                                    Get.dialog(
                                                      GetBuilder<
                                                          RegistrationController>(
                                                        builder:
                                                            (regController) {
                                                          return regController
                                                                  .isLoading
                                                              ? const Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                  color: Colors
                                                                      .black,
                                                                ))
                                                              : ConfirmationDialogue(
                                                                  icon: Icons
                                                                      .warning,
                                                                  iconColor:
                                                                      Colors
                                                                          .red,
                                                                  title:
                                                                      "ARE YOU SURE ?",
                                                                  action: () => regController
                                                                      .deleteRegUser(
                                                                          regUserData)
                                                                      .then(
                                                                          (status) {
                                                                    if (status
                                                                        .isSuccesfull) {
                                                                      Get.snackbar(
                                                                          "Success",
                                                                          status
                                                                              .message);
                                                                      // Navigator.pushAndRemoveUntil(
                                                                      //   context,
                                                                      //   MaterialPageRoute(builder: (context) => ViewAllRegisteredUsers()),
                                                                      //       (Route<dynamic> route) => false,
                                                                      // );
                                                                      // print(Uri.base.toString());

                                                                      // Get.toNamed("/viewAllRegisteredUsers");
                                                                      Get.toNamed(Uri
                                                                          .base
                                                                          .toString());
                                                                    } else {
                                                                      Get.snackbar(
                                                                          "Error Occurred ",
                                                                          status
                                                                              .message);
                                                                    }
                                                                  }),
                                                                );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          title: Text(
                                            registrationController
                                                    .registeredUsersList[index]
                                                    .fName +
                                                registrationController
                                                    .registeredUsersList[index]
                                                    .lName,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            registrationController
                                                .registeredUsersList[index]
                                                .email,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              : const Center(
                                  child: Text("Nothing to show Here !")),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
