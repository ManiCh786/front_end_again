import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/controller.dart';
import '../../../models/models.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class ViewAllRegisteredUsers extends StatelessWidget {
   ViewAllRegisteredUsers({Key? key}) : super(key: key);
   final registrationController = Get.find<RegistrationController>();
   final roleController  =  Get.find<RolesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: const Text("Back",style: TextStyle(color: Colors.white),),onPressed: () {
          Get.toNamed("/adminDashboard");
        },
        ),
      ),
      body:
        FutureBuilder(
          future: registrationController.getRegisteredUsers(),
          builder: (context,snapshot){
            return registrationController.isLoading ? const Center(child:CircularProgressIndicator(color: Colors.black)) : Container(
              child: registrationController.registeredUsersList.isNotEmpty ? ListView.builder(
                  itemCount: registrationController.registeredUsersList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: IconButton(
                          icon: const Icon(Icons.list),
                          onPressed: () {
                            // Get.back();
                          }
                      ),
                      trailing: SizedBox(
                        width: 300,

                        child: Row(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                           GetBuilder<RolesController>(
                             // init: Get.find<RolesController>(),
                             initState: (_)async{
                               Future.delayed(Duration.zero).then((value) => Get.find<RolesController>().getAllRoles(), );
                             },
                             // initState: (_) =>
                               // Get.find<RolesController>().getAllRoles(),
                             builder: (roleController){
                                    return DropdownButton(
                                        value: roleController.dropdownInitialValue,
                                        // Down Arrow Icon
                                        icon: const Icon(Icons.keyboard_arrow_down),
                                         hint: Text(roleController.dropdownPlaceholder),
                                         items: roleController.rolesModel.map((list) =>  DropdownMenuItem(
                                           value: list.roleId.toString(),
                                           onTap: (){
                                                 roleController.dropdownPlaceholder = list.roleName;
                                             },
                                           // enabled: list == null ?true:false,
                                           child: Text(list.roleName.toString().capitalizeFirst!),
                                         )).toList(),
                                         onChanged: (value){
                                           roleController.dropdownInitialValue = value;
                                           var regId = registrationController.registeredUsersList[index].regId ;
                                           var roleId = roleController.dropdownInitialValue ;

                                           var data = {
                                             'regId':regId,
                                             'roleId':roleId,
                                             'created_at': AppUtils.now,
                                             'updated_at': AppUtils.now,
                                           };
                                           Get.dialog(
                                             GetBuilder<RegistrationController>(
                                               builder: (regController){
                                                 return regController.isLoading ? const Center(child: CircularProgressIndicator(color: Colors.black,) ) : ConfirmationDialogue(
                                                   icon: Icons.info,
                                                   iconColor:Colors.green,
                                                   // var t = roleController.dropdownPlaceholder;
                                                   title: "Assign ${roleController.dropdownPlaceholder.toString().capitalizeFirst} to this ${registrationController.registeredUsersList[index].fName + registrationController.registeredUsersList[index].lName} ?",
                                                   cancelButtonColor: Colors.red,
                                                   confirmButtonColor: Colors.green,
                                                     action:  ()=> {
                                                   registrationController.assignRoleToRegUser(data).then((status) {
                                                     if(status.isSuccesfull){
                                                       Get.snackbar("Success", status.message);
                                                       Navigator.pushAndRemoveUntil(
                                                         context,
                                                         MaterialPageRoute(builder: (context) => ViewAllRegisteredUsers()),
                                                             (Route<dynamic> route) => false,
                                                       );
                                                     Get.toNamed("/viewAllRegisteredUsers");

                                                     }
                                                     else{
                                                       Get.snackbar("Error Occurred ", status.message);
                                                     }

                                                   }),
                                                   });
                                               },
                                             ),
                                           );

                                         }
                                     );

                             },
                           ),
                            IconButton(
                              icon:const Icon(Icons.edit),color: Colors.green,
                              onPressed: (){

                                },
                            ),
                            IconButton(
                              icon:const Icon(Icons.delete),color: Colors.red,
                              onPressed: (){
                                RegistrationModel regUserData = RegistrationModel(
                                  regId: registrationController.registeredUsersList[index].regId,
                                );
                                Get.dialog(
                                  GetBuilder<RegistrationController>(
                                    builder: (regController){
                                     return regController.isLoading ? const Center(child: CircularProgressIndicator(color: Colors.black,) ) : ConfirmationDialogue(
                                       icon: Icons.warning,
                                       iconColor: Colors.red,
                                        title: "ARE YOU SURE ?",
                                        action:  ()=> regController.deleteRegUser(regUserData).then((status){
                                        if(status.isSuccesfull){
                                            Get.snackbar("Success", status.message);
                                            // Navigator.pushAndRemoveUntil(
                                            //   context,
                                            //   MaterialPageRoute(builder: (context) => ViewAllRegisteredUsers()),
                                            //       (Route<dynamic> route) => false,
                                            // );
                                            // print(Uri.base.toString());

                                            // Get.toNamed("/viewAllRegisteredUsers");
                                            Get.toNamed(Uri.base.toString());

                                        }
                                         else{
                                     Get.snackbar("Error Occurred ", status.message);
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
                      title: Text(registrationController.registeredUsersList[index].fName + registrationController.registeredUsersList[index].lName),
                      subtitle: Text(registrationController.registeredUsersList[index].email),
                    );
                  }):const Center(child: Text("Nothing to show Here !")),
            );
          },
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


