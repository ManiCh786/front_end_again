import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import '/controllers/auth_controllers/auth_controllers.dart';
import '/models/auth_models/auth_model.dart';
import 'package:get/get.dart';
import '../../widgets/widgets.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController pwdController = TextEditingController();

  final TextEditingController confirmPwdController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController fNameController = TextEditingController();

  final TextEditingController lNameController = TextEditingController();
  final registrationController = Get.find<RegistrationController>();

  _register() async {
    if (_formKey.currentState!.validate()) {
      if (pwdController.text != confirmPwdController.text) {
        Get.snackbar(
            "Passwords do not match", "Confirm passwords before signup");
      } else if (!phoneController.text.isPhoneNumber) {
        Get.snackbar(
            "Phone Number is not valid !", "Enter a valid Phone Number");
      } else {
        RegistrationModel registrationData = RegistrationModel(
            regId: 0,
            fName: fNameController.text.trim().capitalizeFirst,
            lName: lNameController.text.trim().capitalizeFirst,
            email: emailController.text.trim(),
            phone: phoneController.text.trim(),
            password: pwdController.text.trim(),
            createdAt: AppUtils.now,
            updatedAt: AppUtils.now);
        registrationController
            .registerNewUser(registrationData)
            .then((status) => {
                  if (status.isSuccesfull)
                    {
                      Get.snackbar("Success", status.message),
                      Get.offAllNamed("/"),
                    }
                  else
                    {
                      Get.snackbar("Error Occurred ", status.message),
                    }
                });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(children: [
          UserTypePageField(
            hintText: 'First Name',
            controller: fNameController,
            validators: validateUserName,
            typeKeyboard: TextInputType.text,
          ),
          const SizedBox(
            height: 20,
          ),
          UserTypePageField(
            hintText: 'Last Name',
            controller: lNameController,
            validators: validateUserName,
            typeKeyboard: TextInputType.text,
          ),
          const SizedBox(
            height: 20,
          ),
          UserTypePageField(
            hintText: 'Sap ID',
            controller: emailController,
            validators: validateAField,
            typeKeyboard: TextInputType.text,
          ),
          const SizedBox(
            height: 20,
          ),
          UserTypePageField(
            hintText: 'Phone no',
            controller: phoneController,
            validators: validateMobile,
            typeKeyboard: TextInputType.number,
          ),
          const SizedBox(
            height: 20,
          ),
          UserTypePageField(
            hintText: 'Password',
            controller: pwdController,
            validators: validatePassword,
            typeKeyboard: TextInputType.text,
          ),
          const SizedBox(
            height: 20,
          ),
          UserTypePageField(
            hintText: 'Confirm Password',
            controller: confirmPwdController,
            validators: validatePassword,
            typeKeyboard: TextInputType.text,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              title: 'Sign Up',
              btnTxtClr: Colors.white,
              // btnBgClr: Color(0xFF175353),
              btnBgClr: Colors.amber,
              onTap: () {
                _register();
              }),
          const SizedBox(
            height: 15,
          ),
        ]),
      ),
    );
  }
}
