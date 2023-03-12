import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets.dart';

class ConfirmationDialogue extends StatelessWidget {
  const ConfirmationDialogue(
      {Key? key,
      required this.title,
      required this.action,
      required this.icon,
      required this.iconColor,
      this.cancelButtonColor = Colors.green,
      this.confirmButtonColor = Colors.red})
      : super(key: key);
  final String title;
  final Function action;
  final IconData icon;
  final Color iconColor;
  final Color cancelButtonColor;
  final Color confirmButtonColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 150,
      child: AlertDialog(
        icon: Icon(
          icon, color: iconColor,
          // Icons.warning,color: Colors.red,
          size: 50,
        ),
        title: Text(title),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                title: "Cancel",
                onTap: () {
                  Get.back();
                },
                width: 100,
                backgroundColor: cancelButtonColor,
              ),
              CustomTextButton(
                title: "Confirm",
                onTap: () => action(),
                width: 100,
                backgroundColor: confirmButtonColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
