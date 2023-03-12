import 'package:flutter/material.dart';
class CourseAssessmentTable extends StatelessWidget {
  const CourseAssessmentTable({super.key});

  @override
  Widget build(BuildContext context) {
    return 
     Padding(
       padding: const EdgeInsets.all(16.0),
       child: Center(child: Table(
          border: TableBorder.all(),
          columnWidths: const{
            0:FractionColumnWidth(0.13),
            1:FractionColumnWidth(0.1),
            2:FractionColumnWidth(0.1),
            3:FractionColumnWidth(0.12),
            4:FractionColumnWidth(0.1),
            5:FractionColumnWidth(0.12),
            6:FractionColumnWidth(0.12)
          },
          children: [
            buildRow(['Mid Report','Quizes','','Assignments','','Presenatation','Mid Term'],isHeader: true),
            buildRow(['', 'Q1', 'Q2','A1','A2','P','M1'],isHeader: true),
            buildRow([
              'Weight', '', '','','','','',
            ],),
            buildRow(['Max Marks', '10', '10','10','10','10','25']),
            buildRow(['Marks Obtained', '10', '8','7','7','10','20']),
            buildRow(['Obtained Weighted Marks','4','','7','','8','20']),
            buildRow(['Total Weighted Marks', '5', '','10','','10','25',]),
          
          ],
        )
        ),
     );
     
  }
  
  TableRow buildRow(List<String> cells,{bool isHeader=false})=>TableRow(
    children: cells.map((cell)=>
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(child: Text(cell,style: TextStyle(
        fontWeight: isHeader?FontWeight.bold:FontWeight.w400,
        fontFamily: 'Poppins',
        fontSize: 12
      ),)),
    )).toList()
  );
  
  
  
  
}