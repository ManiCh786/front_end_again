import 'package:flutter/material.dart';
import '../../coursespecification.dart/widgets/piechart_report.dart';

class ReportChart extends StatelessWidget {
  const ReportChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:38.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(color: Colors.grey,
            border: Border.all(width: 2,
            color: Colors.deepPurple)),
            child: TextButton(onPressed: (){
              showDialog(context: context, 
              builder: (ctx){
                return AlertDialog(
                   title: const Center(
                     child:  Text('Course Result Report',
                     style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                     ),),
                   ),
                  content: Container(
                    height: 500,
                    width: 500,
                    child: PieChartReport()),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                        width: 170,
                        height: 50,
                        color: Colors.amber,
                        padding: const EdgeInsets.all(14),
                        child:const Center(
                          child:  Text("Close Report",style: TextStyle(
      color: Colors.white,
      fontFamily: 'Poppins',
      fontSize: 15
                          ),),
                        ),
                      ),
                    ),
                  ],
              );
                
              });
            }, child:const Text(
              'Generate Graphical Report',
              style: TextStyle(color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w500),
            )),
          ),
        ],
      ),
    );
  }
}


