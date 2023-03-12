import 'package:flutter/material.dart';

class courseReportTiles extends StatelessWidget {
  const courseReportTiles({
    Key? key, required this.title,this.icn,this.onTap
  }) : super(key: key);
 final title;
 final icn;
 final onTap;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left:8.0,top: 10,right: 7),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(color: Colors.deepPurple),
        ),
        child: ListTile(
          onTap: onTap,
           leading: Icon(icn,
           color: Colors.deepPurple,),
            title:  MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(title,
              style: const TextStyle(fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w500) ,)),
            ),
      ),
    );
  }
}