import 'package:flutter/material.dart';

class ObjBtn extends StatelessWidget {
  const ObjBtn({
    required this.title,
    required this.btnTxtClr,
    required this.btnBgClr,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final String title;
  final Color btnTxtClr;
  final Color btnBgClr;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
       height: 50,
        width: 630,
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
