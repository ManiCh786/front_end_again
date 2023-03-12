import 'package:flutter/material.dart';

class OutlineBtn extends StatelessWidget {
   OutlineBtn({
    required this.title,
    required this.btnTxtClr,
    required this.btnBgClr,
    required this.onTap,
    required this.hight,
    required this.width,
    Key? key,
  }) : super(key: key);
  final String title;
  final Color btnTxtClr;
  final Color btnBgClr;
  final VoidCallback onTap;
  final double hight;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
       height: hight,
        width: width,
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color.fromRGBO(0, 0, 0, 1), width: 1),
                  borderRadius: BorderRadius.circular(8)),
              primary: Colors.amber.shade400),
          child: Text(
            title,
            style:const TextStyle(
                fontFamily: 'Poppins', color: Colors.black, fontSize: 18,fontWeight: FontWeight.w500),
          )),
    );
  }
}
