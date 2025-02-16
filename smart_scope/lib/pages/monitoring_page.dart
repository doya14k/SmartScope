import 'package:flutter/material.dart';
import 'dart:math';
import 'settings_pages/settings_widgets/definitions.dart';
import 'package:fl_chart/fl_chart.dart';

List<FlSpot> generateSineWave({
  int numPoints = 1000,
  double frequency = 1.0,
  double amplitude = 10.0,
}) {
  List<FlSpot> points = [];
  for (int i = 0; i < numPoints; i++) {
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
              height: 600,
              child: LineChart(
                LineChartData(
                  backgroundColor: CharBackgroundColor,
                  baselineX: 0.0,
                  baselineY: 0.0,
                  maxY: currentsliderValue,
                  minY: -currentsliderValue,
                  // Grid Data
                  gridData: FlGridData(
                    horizontalInterval: ((2 * currentsliderValue) / 8),
                    verticalInterval: 1.0,
                  ),
                  // Titles off
                  titlesData: FlTitlesData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      show: true,
                      spots: [
                        FlSpot(0, 0),
                        FlSpot(1, 1),
                        FlSpot(2, 1),
                        FlSpot(3, 4),
                        FlSpot(4, 5),
                        FlSpot(5, 2),
                      ],
                      color: ch1Color,
                      barWidth: 3.0,
                      isCurved: false,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    enabled: false,
                  ), // disable the linetouchdata
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
