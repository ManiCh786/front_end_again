import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartReport extends StatefulWidget {
  const PieChartReport({super.key});

  @override
  State<PieChartReport> createState() => _PieChartReportState();
}

class _PieChartReportState extends State<PieChartReport> {
  int choiceIndex =0;
  Map<String, double> dataMap={
    "Quiz 1":18,
    "Quiz 2":19,
    "A1":8,
    "A2":8,
    "Presentation":8,
    "Mid Exam":20,
  };
  List<Color>colorList=[
    const Color(0xff095AF3),
    const Color(0xff3EE094),
    const Color(0xff3398f6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539),
    const Color(0xffFE955549),
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PieChart(
        dataMap: dataMap,
        colorList: colorList,
        chartRadius: MediaQuery.of(context).size.width/3,
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