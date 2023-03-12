import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';
import 'widgets.dart';

class InputFieldDialogue extends StatelessWidget {
   InputFieldDialogue(
      {Key? key,
    })
      : super(key: key);
 
  final TextEditingController objDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 600,
      child: Dialog(
        child: Column(
          children: [
            SizedBox(
            
      width: 427,
            child: TextFormField(
              
                validator: validateAField,
                keyboardType: TextInputType.text,
                // controller: bTLevelsController,
                readOnly: true,
                maxLines: 3,
                decoration:
                    InputDecoration.collapsed(hintText: "Blooms Taxonomy Level",)),
          ),
          Row(children: [
                Expanded(
                  child: UserTypePageField(
                            validators: validateAField,
                            hintText: "Add Objective Desc",
                            typeKeyboard: TextInputType.text,
                            controller: objDescController,
                          ),
                ),
                IconButton(icon: Icon(Icons.add),onPressed: (){},)
          ],)
          ],
        ),
        //  actions: [
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       CustomTextButton(
        //         title: "Cancel",
        //         onTap: () {
        //           Get.back();
        //         },
        //         width: 100,
        //         backgroundColor: Colors.red,
        //       ),
        //       CustomTextButton(
        //         title: "Confirm",
        //         onTap: () => action(),
        //         width: 100,
        //         backgroundColor: Colors.green,
        //       ),
        //     ],
        //   )
        // ],
        ),
    );
  }
}
