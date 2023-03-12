import 'package:flutter/material.dart';

class ObjectivePageField extends StatelessWidget {
  const ObjectivePageField({
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
      height: 45,
      width: 630,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
         decoration: InputDecoration(
          errorStyle: const TextStyle(height:50 ,
          color: Colors.white, fontSize: 14, fontFamily: 'Poppins'),
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
          hintStyle: const TextStyle(fontSize: 16,fontFamily: 'Poppins'),
          isDense: false,
        ),
        keyboardType: typeKeyboard,
        validator: validators,
      ),
    );
  }
}
