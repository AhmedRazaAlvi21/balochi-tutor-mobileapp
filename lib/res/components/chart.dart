import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../colors/app_color.dart';
import 'custom_text.dart';

class UserLineChart extends StatefulWidget {
  const UserLineChart({super.key});

  @override
  State<UserLineChart> createState() => _UserLineChartState();
}

class _UserLineChartState extends State<UserLineChart> {
  List<Color> gradientColors = [
    AppColor.primaryColor.withOpacity(0.2),
    AppColor.primaryColor.withOpacity(0.1),
    // AppColors.contentColorBlue,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
        left: 0,
        top: 20,
        bottom: 10,
      ),
      child: LineChart(
        mainData(),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    // log('bottom: ${value.toString()}');
    switch (value.toInt()) {
      case 1:
        text = 'Mon';
        break;
      case 3:
        text = 'Tue';
        break;
      case 5:
        text = 'Wed';
        break;
      case 7:
        text = 'Thu';
        break;
      case 9:
        text = 'Fri';
        break;
      case 11:
        text = 'Sat';
        break;
      case 13:
        text = 'Sun';
        break;
      default:
        return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CustomText(
        title: text,
        fontsize: 13,
        textalign: TextAlign.left,
        fontcolor: AppColor.blackColor,
        fontweight: FontWeight.w500,
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 1:
        text = '0';
        break;
      case 2:
        text = '200';
        break;
      case 3:
        text = '400';
        break;
      case 4:
        text = '600';
        break;
      case 5:
        text = '800';
        break;
      case 6:
        text = '1000';
        break;
      default:
        return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CustomText(
        title: text,
        textalign: TextAlign.left,
        fontsize: 13,
        fontcolor: AppColor.blackColor,
        fontweight: FontWeight.w500,
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBorderRadius: BorderRadius.circular(8),
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              return LineTooltipItem(
                '${touchedSpot.y.toString()}',
                TextStyle(
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              );
            }).toList();
          },
        ),
        touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
          // Handle touch interactions if needed
        },
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 2,
        verticalInterval: 2,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
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
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 40,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 13,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
            FlSpot(13, 3),
          ],
          isCurved: true,

          color: AppColor.primaryColor,
          // gradient: LinearGradient(
          //   colors: gradientColors,
          // ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }

// LineChartData avgData() {
//   return LineChartData(
//     lineTouchData: LineTouchData(enabled: false),
//     gridData: FlGridData(
//       show: true,
//       drawHorizontalLine: true,
//       verticalInterval: 1,
//       horizontalInterval: 1,
//       getDrawingVerticalLine: (value) {
//         return FlLine(
//           color: Color(0xff37434d),
//           strokeWidth: 1,
//         );
//       },
//       getDrawingHorizontalLine: (value) {
//         return FlLine(
//           color: Color(0xff37434d),
//           strokeWidth: 1,
//         );
//       },
//     ),
//     titlesData: FlTitlesData(
//       show: true,
//       bottomTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 30,
//           getTitlesWidget: bottomTitleWidgets,
//           interval: 1,
//         ),
//       ),
//       leftTitles: AxisTitles(
//         sideTitles: SideTitles(
//           showTitles: true,
//           getTitlesWidget: leftTitleWidgets,
//           reservedSize: 42,
//           interval: 1,
//         ),
//       ),
//       topTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//       rightTitles: AxisTitles(
//         sideTitles: SideTitles(showTitles: false),
//       ),
//     ),
//     borderData: FlBorderData(
//       show: true,
//       border: Border.all(color: const Color(0xff37434d)),
//     ),
//     minX: 0,
//     maxX: 11,
//     minY: 0,
//     maxY: 6,
//     lineBarsData: [
//       LineChartBarData(
//         spots: const [
//           FlSpot(0, 3.44),
//           FlSpot(2.6, 3.44),
//           FlSpot(4.9, 3.44),
//           FlSpot(6.8, 3.44),
//           FlSpot(8, 3.44),
//           FlSpot(9.5, 3.44),
//           FlSpot(11, 3.44),
//         ],
//         isCurved: true,
//         gradient: LinearGradient(
//           colors: [
//             ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                 .lerp(0.2)!,
//             ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                 .lerp(0.2)!,
//           ],
//         ),
//         barWidth: 5,
//         isStrokeCapRound: true,
//         dotData: FlDotData(
//           show: false,
//         ),
//         belowBarData: BarAreaData(
//           show: true,
//           gradient: LinearGradient(
//             colors: [
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!
//                   .withOpacity(0.1),
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!
//                   .withOpacity(0.1),
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
// }
}

// class AppColors {
//   static const Color primary = contentColorCyan;
//   static const Color menuBackground = Color(0xFF090912);
//   static const Color itemsBackground = Color(0xFF1B2339);
//   static const Color pageBackground = Color(0xFF282E45);
//   static const Color mainTextColor1 = Colors.white;
//   static const Color mainTextColor2 = Colors.white70;
//   static const Color mainTextColor3 = Colors.white38;
//   static const Color mainGridLineColor = Colors.white10;
//   static const Color borderColor = Colors.white54;
//   static const Color gridLinesColor = Color(0x11FFFFFF);

//   static const Color contentColorBlack = Colors.black;
//   static const Color contentColorWhite = Colors.white;
//   static const Color contentColorBlue = Color(0xFF2196F3);
//   static const Color contentColorYellow = Color(0xFFFFC300);
//   static const Color contentColorOrange = Color(0xFFFF683B);
//   static const Color contentColorGreen = Color(0xFF3BFF49);
//   static const Color contentColorPurple = Color(0xFF6E1BFF);
//   static const Color contentColorPink = Color(0xFFFF3AF2);
//   static const Color contentColorRed = Color(0xFFE80054);
//   static const Color contentColorCyan = Color(0xFF50E4FF);
// }
