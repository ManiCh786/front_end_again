import 'package:flutter/material.dart';

class UserTypePageText extends StatelessWidget {
  const UserTypePageText({
    required this.title,
    required this.titleColor,
    this.fontSize,
    Key? key,
  }) : super(key: key);
  final String title;
  final Color titleColor;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: titleColor,
        fontFamily: 'Dongle',
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
