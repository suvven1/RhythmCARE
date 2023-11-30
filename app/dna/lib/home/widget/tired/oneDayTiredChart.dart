import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class oneDayTiredChart extends StatefulWidget {
  const oneDayTiredChart({super.key});

  @override
  State<StatefulWidget> createState() => oneDayTiredChartState();
}

class oneDayTiredChartState extends State<oneDayTiredChart> {
  // 하루 피로도 더미데이터
  List<int> data = [
    44, 55, 57, 56, 61, 58, 63, 60, 80
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          gridData: gridData,
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
        ),
      ),
    );
  }

  FlGridData gridData = FlGridData(
      show: true,
      horizontalInterval: 70,
      verticalInterval: 6,
      getDrawingHorizontalLine: (value){
        return const FlLine(
          color: Colors.grey,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value){
        return const FlLine(
          color: Colors.transparent,
        );
      }
  );

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  // 바텀 타이틀 양식
  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 6:
        text = '6';
        break;
      case 12:
        text = '12';
        break;
      case 18:
        text = '18';
        break;
      case 23:
        text = '23';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  // 데이터축 타이틀
  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  // 데이터를 감싸는 컨테이너 선 디자인
  FlBorderData get borderData => FlBorderData(
      show: true,
      border: Border(
        // left: BorderSide(),
        bottom: BorderSide(),
      ));

  // 바 색을 그라데이션 줄 수 있는 옵션
  // LinearGradient get _barsGradient => LinearGradient(
  //       colors: [
  //         Colors.black,
  //         Colors.black,
  //       ],
  //       begin: Alignment.bottomCenter,
  //       end: Alignment.topCenter,
  //     );

  List<BarChartGroupData> get barGroups => [
    ...List.generate(
        24,
            (index) => BarChartGroupData(x: index, barRods: [
          BarChartRodData(
            toY: (data.length > index ? data[index] : 0).toDouble(),
            // gradient: _barsGradient,
            color: Color(0xff2e2288),
          )
        ]))
  ];
}
