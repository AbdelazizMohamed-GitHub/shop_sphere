import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomMainChart extends StatelessWidget {
  const CustomMainChart({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 100,
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
              
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  String weekDay;
                  switch (group.x.toInt()) {
                    case 0:
                      weekDay = 'Monday';
                      break;
                    case 1:
                      weekDay = 'Tuesday';
                      break;
                    case 2:
                      weekDay = 'Wednesday';
                      break;
                    case 3:
                      weekDay = 'Thursday';
                      break;
                    case 4:
                      weekDay = 'Friday';
                      break;
                    case 5:
                      weekDay = 'Saturday';
                      break;
                    case 6:
                      weekDay = 'Sunday';
                      break;
                    default:
                      weekDay = '';
                  }
                  return BarTooltipItem(
                    '$weekDay\n${rod.fromY.toInt()}',
                    TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    );
                    String text;
                    switch (value.toInt()) {
                      case 0:
                        text = 'M';
                        break;
                      case 1:
                        text = 'T';
                        break;
                      case 2:
                        text = 'W';
                        break;
                      case 3:
                        text = 'T';
                        break;
                      case 4:
                        text = 'F';
                        break;
                      case 5:
                        text = 'S';
                        break;
                      case 6:
                        text = 'S';
                        break;
                      default:
                        text = '';
                    }
                    return SideTitleWidget(
                     meta: meta,
                      space: 4,
                      child: Text(text, style: style),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    );
                    return SideTitleWidget(
                      space: 4,
                      meta: meta,
                      child: Text(value.toInt().toString(), style: style),
                    );
                  },
                  reservedSize: 28,
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: 20,
                    color: Colors.blue,
                    width: 16,
                  )
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    toY: 50,
                    color: Colors.blue,
                    width: 16,
                  )
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    toY: 80,
                    color: Colors.blue,
                    width: 16,
                  )
                ],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                    toY: 65,
                    color: Colors.blue,
                    width: 16,
                  )
                ],
              ),
              BarChartGroupData(
                x: 4,
                barRods: [
                  BarChartRodData(
                    toY: 90,
                    color: Colors.blue,
                    width: 16,
                  )
                ],
              ),
              BarChartGroupData(
                x: 5,
                barRods: [
                  BarChartRodData(
                    toY: 40,
                    color: Colors.blue,
                    width: 16,
                  )
                ],
              ),
              BarChartGroupData(
                x: 6,
                barRods: [
                  BarChartRodData(
                    toY: 30,
                    color: Colors.blue,
                    width: 16,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  
  }
}