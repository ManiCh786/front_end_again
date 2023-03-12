import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/controller.dart';
import '../../../../models/models.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../../../screens.dart';
import '../../constants.dart';
import '../components/components.dart';

class AllVerifiedUsers extends StatelessWidget {
  AllVerifiedUsers({Key? key}) : super(key: key);
  final userAuthController = Get.find<UserAuthController>();
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
              child: GetBuilder<UserAuthController>(
                initState: (_) {
                  Future.delayed(Duration.zero).then(
                      (value) => Get.find<UserAuthController>().getAllUsers());
                },
                // future: registrationController.getRegisteredUsers(),
                builder: (registrationController) {
                  return userAuthController.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.black))
                      : Container(
                          child: userAuthController.allUsersList.isNotEmpty
                              ? ListView.builder(
                                  itemCount:
                                      userAuthController.allUsersList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SingleChildScrollView(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey)),
                                          child: ListTile(
                                            tileColor: Colors.white,
                                            leading: IconButton(
                                                icon: const Icon(
                                                  Icons.list,
                                                  size: 25,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
                                                  // Get.back();
                                                }),
                                            trailing: Text(
                                              '${userAuthController.allUsersList[index].roleName}'
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                              ),
                                            ),
                                            title: Text(
                                              userAuthController
                                                      .allUsersList[index]
                                                      .fName +
                                                  userAuthController
                                                      .allUsersList[index]
                                                      .lName,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            subtitle: Text(
                                              userAuthController
                                                  .allUsersList[index].email,
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              : const Center(
                                  child: Text(
                                  "Nothing to show Here !",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontSize: 20),
                                )),
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
