import 'package:flutter/material.dart';

class UserTypePageField extends StatelessWidget {
  const UserTypePageField({
    required this.validators,
    required this.hintText,
    this.icn,
    required this.controller,
    required this.typeKeyboard,
    Key? key,
  }) : super(key: key);
  final String? Function(String?)? validators;
  final String hintText;
  final Widget? icn;
  final TextEditingController controller;
  final TextInputType typeKeyboard;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
       height: 50,
       width: 370,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
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
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 18,fontFamily: 'Poppins'),
          isDense: false,
        ),
        keyboardType: typeKeyboard,
        validator: validators,
      ),
    );
  }
}
