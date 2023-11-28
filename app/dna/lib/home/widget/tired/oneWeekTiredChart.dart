import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class oneWeekTiredChart extends StatefulWidget {
  const oneWeekTiredChart({super.key});

  @override
  State<oneWeekTiredChart> createState() => _oneWeekTiredChartState();
}

class _oneWeekTiredChartState extends State<oneWeekTiredChart> {

  // 피로도 데이터 (index = 0 : 오늘 피로도, 1 : 어제 피로도, ... , 6 : 6일 전 피로도)
  List<double> data = [
    32,
    27,
    36,
    41,
    53,
    43,
    28,
  ];

  // 오늘 날짜로부터 일주일의 날짜 리스트
  List<String> bottomTitleText = List.generate(
      7,
          (index) =>
          (DateTime.now().subtract(Duration(days: 6 - index)).day).toString());

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, right: 10),
        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  // bottom 타이틀 양식
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    return value == -0.5 || value == 6.5
        ? Text('')
        : SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        bottomTitleText[value.toInt()],
        style: style,
      ),
    );
  }

  // left 타이틀 양식
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    return value == 0 || value == 101
        ? Text('')
        : Padding(
      padding: const EdgeInsets.all(5),
      child: Text(value.toInt().toString(),
          style: style, textAlign: TextAlign.right),
    );
  }

  // 그래프 그리는 함수
  LineChartData mainData() {
    return LineChartData(

      gridData: FlGridData(
        show: true,
        horizontalInterval: 20,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },

      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 20,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 45,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
            bottom: BorderSide()
        ),
      ),
      minX: -0.5,
      maxX: 6.5,
      minY: 0,
      maxY: 101,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(7, (index) => FlSpot((6-index).toDouble(), data.length > index ? data[index] : 0)),
          isCurved: true,
          color: Color(0xff2e2288),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}
