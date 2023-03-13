import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartReporttt extends StatefulWidget {
   PieChartReporttt(
    {super.key, required this.value});
 String? value;
  @override
  State<PieChartReporttt> createState() => _PieChartReportttState();
}

class _PieChartReportttState extends State<PieChartReporttt> {
  int choiceIndex =0;

  List<Color>colorList=[
    const Color(0xff095AF3),
    // const Color(0xff3EE094),
    // const Color(0xff3398f6),
    const Color(0xffFA4A42),
    // const Color(0xffFE9539),
    // const Color(0xffFE955549),
  ];
  @override
  Widget build(BuildContext context) {
      Map<String, double> dataMap={
    "Objective Accomplished":double.parse(widget.value!),
    "Left/": 100 - double.parse(widget.value!),
    
  };
  print("pie valuye is ${widget.value} ");
    return Center(
      child: PieChart(
        dataMap: dataMap,
        colorList: colorList,
        chartRadius: MediaQuery.of(context).size.width/5,
        centerText: "Result",
        chartValuesOptions: const ChartValuesOptions(
          showChartValues: true,
          showChartValuesOutside: true,
          showChartValuesInPercentage: true,
          showChartValueBackground: false,
        ),
        legendOptions: const LegendOptions(
          showLegends: true,
          legendTextStyle: TextStyle(fontFamily: 'Poppins',fontSize: 18)
          // legendShape: BoxShape.rectangle
        ),
      ),
    );
  }
}