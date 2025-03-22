import 'package:flutter/material.dart';
import 'dart:math';
import 'settings_pages/settings_widgets/definitions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:smart_scope/usb_reader.dart';

List<FlSpot> generateSineWave({
  double numPoints = 30000,
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      closePort();
                      Navigator.pushReplacementNamed(context, '/USB_Select');
                    },
                    icon: Icon(Icons.arrow_back_sharp),
                    tooltip: 'Return to Port-Select',
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 700,
                  child: LineChart(
                    LineChartData(
                      backgroundColor: ChartBackgroundColor,
                      clipData:
                          FlClipData.all(), // Ensures that the line stays in the Chart
                      baselineX: 0.0,
                      baselineY: 0.0,
                      maxY: Provider.of<AppState>(context).currentsliderValue,
                      minY: -Provider.of<AppState>(context).currentsliderValue,
                      maxX: Provider.of<AppState>(context).timeValue,
                      minX: -Provider.of<AppState>(context).timeValue,
                      // Grid Data
                      gridData: FlGridData(
                        horizontalInterval:
                            ((2 *
                                    Provider.of<AppState>(
                                      context,
                                    ).currentsliderValue) /
                                NOF_yGrids),
                        verticalInterval:
                            ((2 * Provider.of<AppState>(context).timeValue) /
                                NOF_xGrids),
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
                          color: channel1.channelColor,
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
                            color: ChartBackgroundColor,
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
                            color: ChartBackgroundColor,
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey[400],
                          child: Text(
                            'Selected Port: ${selectedPort != null ? selectedPort!.portName : "Error no one selected"}',
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
