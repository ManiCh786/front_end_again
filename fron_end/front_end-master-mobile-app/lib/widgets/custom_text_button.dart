import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
    const CustomTextButton({Key? key, required this.title,required this.onTap,
   this.backgroundColor = Colors.black,this.height = 45.0,this.width = 150.0,this.textColor= Colors.white,
     this.fontWeight= FontWeight.w400,this.textSize = 12
   }) : super(key: key);
  final  String title;
  final Color backgroundColor ;
  final double width ;
  final double height ;
  final Function onTap;
  final Color textColor ;
  final FontWeight fontWeight;
  final double textSize;
  @override
  Widget build(BuildContext context) {
    return  TextButton(
      style:TextButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(width,height),
      ),
        onPressed: (){
      onTap();
    }, child: Text(title,style: TextStyle(color: textColor,fontSize: textSize,fontWeight: fontWeight),),);
  }
}
