import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class DropdownDemo extends StatefulWidget {
  const DropdownDemo({Key? key}) : super(key: key);
  @override
  State<DropdownDemo> createState() => _DropdownDemoState();
}
class _DropdownDemoState extends State<DropdownDemo> {
  String dropdownValue = 'In progress';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // SizedBox(
            //   height: 50,
            // ),
            // Step 2.
            Container(
              width: 170,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                border: Border.all(width: 2),
                
              ),
              child: DropdownButton<String>(
                // Step 3.
                value: dropdownValue,
                // Step 4.
                items: <String>['In progress', 'Future', 'Past', 'Starred']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(left:12.0),
                      child: Text(
                        '$value   ',
                        style:const TextStyle(fontSize: 20,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                // Step 5.
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
              ),
            ),
          //  const SizedBox(
          //     height: 20,
          //   ),
            // Text(
            //   'Selected Value: $dropdownValue',
            //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            // ),
          ],
        ),
      ),
    );
  }
}