import 'package:flutter/material.dart';

class DashboardRegisterTab extends StatelessWidget {
 const  DashboardRegisterTab({
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
        Icon(icn, size: 25),
        Text(
          title,
          style: TextStyle(fontSize: 15, fontFamily: 'Dongle'),
        ),
      ],
    );
  }
}
