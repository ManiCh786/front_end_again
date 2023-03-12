import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '/controllers/auth_controllers/auth_controllers.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController pwdController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _login() async {
    var data = {
      'email': emailController.text,
      'password': pwdController.text,
    };
    if (_formKey.currentState!.validate()) {
      if (pwdController.text.isEmpty || emailController.text.isEmpty) {
        Get.snackbar("All the Fields are Mandatory", "Fields can't be Empty");
      }  else {
        userAuthController.login(data).then((status) => {
              if (status.isSuccesfull)
                {
                  Get.snackbar("Success", "Login Approved"),
                  Get.offAllNamed("/"),

                  // if (status.message != "")
                  //   {
                  //     Get.offAllNamed("/verify-email"),
                  //   }
                  // else
                  //   {
                  //     Get.offAllNamed("/"),
                  //   }
                }
              else
                {
                  Get.snackbar("Error Occurred ", status.message,
                      colorText: Colors.white, backgroundColor: Colors.red),
                  pwdController.text = "",
                  emailController.text = "",
                }
            });
      }
    }
  }

  final userAuthController = Get.find<UserAuthController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(children: [
          UserTypePageField(
            hintText: 'Sap Id',
            controller: emailController,
            validators: validateAField,
            typeKeyboard: TextInputType.text,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: 370,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: pwdController,
              obscureText: true,
              obscuringCharacter: "*",
               decoration: InputDecoration(
          errorStyle: const TextStyle(height:50 ,
          color: Colors.white, fontSize: 12, fontFamily: 'Inter-ExtraBold'),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.deepPurple, width: 1),
              borderRadius: BorderRadius.circular(8)),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(8)
          ),
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: "Password",
          hintStyle: const TextStyle(fontSize: 18,fontFamily: 'Poppins'),
          isDense: false,
        ),
              keyboardType: TextInputType.text,
              validator: validatePassword,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GetBuilder<UserAuthController>(
            builder: (authController) {
              return Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: CustomButton(
                    title: authController.isLoading ? 'Logging In ...' : 'Login',
                    btnTxtClr: Colors.black,
                    btnBgClr: Colors.amber.shade400,
                    onTap: () {
                      _login();
                    }),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
        ]),
      ),
    );
  }
}
