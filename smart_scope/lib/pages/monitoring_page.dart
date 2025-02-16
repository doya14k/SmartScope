import 'package:flutter/material.dart';
import 'dart:math';
import 'settings_pages/settings_widgets/definitions.dart';
import 'package:fl_chart/fl_chart.dart';

List<FlSpot> generateSineWave({
  double numPoints = 300,
  double fine = 0.1,
  double frequency = 25,
  double amplitude = 5.0,
}) {
  List<FlSpot> points = [];
  for (double i = -numPoints; i < numPoints; i += fine) {
    double x = i.toDouble();
    double y = amplitude * sin(frequency * x * 2 * pi / numPoints);
    points.add(FlSpot(x, y));
  }
  return points;
}

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  List<FlSpot> plotData = generateSineWave();

  @override
  void initState() {
    super.initState();
    plotData.sort((a, b) => a.x.compareTo(b.x)); // Sortiere nach x-Wert
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SizedBox(
              height: 700,
              child: LineChart(
                LineChartData(
                  backgroundColor: CharBackgroundColor,
                  clipData:
                      FlClipData.all(), // Ensures that the line stays in the Chart
                  baselineX: 0.0,
                  baselineY: 0.0,
                  maxY: currentsliderValue,
                  minY: -currentsliderValue,
                  maxX: timeValue,
                  minX: -timeValue,
                  // Grid Data
                  gridData: FlGridData(
                    horizontalInterval: ((2 * currentsliderValue) / NOF_yGrids),
                    verticalInterval: ((2 * timeValue) / NOF_xGrids),
                    getDrawingHorizontalLine:
                        (value) => FlLine(
                          color: GridLineColor,
                          strokeWidth: 1.0,
                          dashArray: [4, 4],
                        ),
                    getDrawingVerticalLine:
                        (value) => FlLine(
                          color: GridLineColor,
                          strokeWidth: 1.0,
                          dashArray: [4, 4],
                        ),
                  ),
                  // Titles off
                  titlesData: FlTitlesData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      show: true,
                      spots: plotData,
                      color: ch1Color,
                      barWidth: 3.0,
                      isCurved: false,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    enabled: false,
                  ), // disable the linetouchdata
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: 0,
                        color: CharBackgroundColor,
                        strokeWidth: 1,
                      ),
                      HorizontalLine(
                        y: 0,
                        color: BaseLineColor,
                        strokeWidth: 1.5,
                        dashArray: [5, 5],
                      ),
                    ],
                    verticalLines: [
                      VerticalLine(
                        x: 0,
                        color: CharBackgroundColor,
                        strokeWidth: 1,
                      ),
                      VerticalLine(
                        x: 0,
                        color: BaseLineColor,
                        strokeWidth: 1.5,
                        dashArray: [5, 5],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
