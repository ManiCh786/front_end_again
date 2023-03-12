import 'package:flutter/material.dart';
import '/controllers/auth_controllers/auth_controllers.dart';
import 'package:get/get.dart';

class LoggedInUserInfo extends StatelessWidget {
   const LoggedInUserInfo({Key? key}) : super(key: key);
  // final authController = Get.find<UserAuthController>();
  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<UserAuthController>().isUserLoggedIn();

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: const Text("Back",style: TextStyle(color: Colors.white),),onPressed: () {
          Get.toNamed("/");
        },
        ),
      ),
      body:GetBuilder<UserAuthController>(
        initState: (_){
          if(userLoggedIn) {
            Future.delayed(Duration.zero).then((value) => Get.find<UserAuthController>().getLoggedInUserInfo(),);

          }else{
            Get.offAllNamed("authMenu");
          }
        },
        builder: (controller){
          return  controller.isLoading ? const Center(
            child: CircularProgressIndicator(
              color: Colors.black,),
          )
              : controller.loggedInUserInfo == "" ? const Center(child:Text("..."))  :Container(
            child: ListTile(
              leading: Text(controller.loggedInUserInfo.userId!.toString()??""),
              title: Text(controller.loggedInUserInfo.fName! + controller.loggedInUserInfo.lName! ?? ""),
              subtitle: Text(controller.loggedInUserInfo.email!??""),
              trailing: Text(controller.loggedInUserInfo.roleName!??""),
            ),
          );
        },
      ),
    );

  }
}
