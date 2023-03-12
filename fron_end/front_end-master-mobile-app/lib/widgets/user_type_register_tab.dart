
import 'package:flutter/material.dart';

class UserTypeRegisterTab extends StatelessWidget {
  const UserTypeRegisterTab({
    required this.title,
    required this.icn,
    Key? key,
  }) : super(key: key);
  final String title;
  final IconData icn;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icn, size: 25,),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
        ),
      ],
    );
  }
}
