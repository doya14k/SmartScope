import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'settings_pages/settings_widgets/definitions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:smart_scope/usb_reader.dart';
import 'settings_pages/measurements_widgets/definitionMeasurements.dart';

List<FlSpot> generateSineWave({
  double numPoints = 300,
  double fine = 0.1,
  double frequency = 25,
  double amplitude = 5000.0,
}) {
  List<FlSpot> points = [];
  for (double i = -numPoints; i < numPoints; i += fine) {
    double x = i.toDouble();
    double y = amplitude * sin(frequency * x * 2 * pi / numPoints);
    points.add(FlSpot(x, y));
  }
  return points;
}

List<FlSpot> generateSineWave2({
  double numPoints = 300,
  double fine = 0.1,
  double frequency = 30,
  double amplitude = 5000.0,
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
  List<FlSpot> plotData2 = generateSineWave2();

  @override
  void initState() {
    super.initState();
    plotData.sort((a, b) => a.x.compareTo(b.x)); // Sortiere nach x-Wert
    plotData2.sort((a, b) => a.x.compareTo(b.x)); // Sortiere nach x-Wert
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
                  height: screenHeight * 0.6156,
                  child: Stack(
                    children: [
                      LineChart(
                        LineChartData(
                          backgroundColor: ChartBackgroundColor,
                          clipData:
                              FlClipData.all(), // Ensures that the line stays in the Chart
                          baselineX: 0.0,
                          baselineY: 0.0,
                          maxY: NOF_yGrids,
                          minY: -NOF_yGrids,
                          maxX: NOF_xGrids,
                          minX: -NOF_xGrids,
                          // Grid Data
                          gridData: FlGridData(
                            horizontalInterval: ((2 * NOF_yGrids) / NOF_yGrids),
                            verticalInterval: ((2 * NOF_xGrids) / NOF_xGrids),
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
                              spots: List.empty(),
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
                      // CH1
                      LineChart(
                        LineChartData(
                          backgroundColor: clear,
                          clipData:
                              FlClipData.all(), // Ensures that the line stays in the Chart
                          baselineX: 0.0,
                          baselineY: 0.0,
                          maxY:
                              Provider.of<AppState>(
                                context,
                              ).maxGraphVoltageValueCH1,
                          minY:
                              Provider.of<AppState>(
                                context,
                              ).minGraphVoltageValueCH1,
                          maxX:
                              Provider.of<AppState>(context).maxGraphTimeValue,
                          minX:
                              Provider.of<AppState>(context).minGraphTimeValue,
                          // Grid Data
                          gridData: FlGridData(
                            horizontalInterval:
                                ((2 *
                                        Provider.of<AppState>(
                                          context,
                                        ).ch1_uVoltageValue) /
                                    NOF_yGrids),
                            verticalInterval:
                                ((2 *
                                        Provider.of<AppState>(
                                          context,
                                        ).timeValue) /
                                    NOF_xGrids),
                            getDrawingHorizontalLine:
                                (value) => FlLine(
                                  color: clear,
                                  strokeWidth: 1.0,
                                  dashArray: [4, 4],
                                ),
                            getDrawingVerticalLine:
                                (value) => FlLine(
                                  color: clear,
                                  strokeWidth: 1.0,
                                  dashArray: [4, 4],
                                ),
                          ),
                          // Titles off
                          titlesData: FlTitlesData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              show: channel1.channelIsActive,
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
                            verticalLines: [
                              VerticalLine(
                                x:
                                    ((Provider.of<AppState>(context).timeValue *
                                                ((NOF_xGrids / 2) - 1)) >
                                            (Provider.of<AppState>(
                                                  context,
                                                ).triggerHorizontalOffset)
                                                .abs())
                                        ? 0
                                        : (Provider.of<AppState>(
                                              context,
                                            ).triggerHorizontalOffset <
                                            0)
                                        ? -Provider.of<AppState>(
                                                  context,
                                                ).timeValue *
                                                (NOF_xGrids / 2) -
                                            Provider.of<AppState>(
                                              context,
                                            ).triggerHorizontalOffset
                                        : Provider.of<AppState>(
                                                  context,
                                                ).timeValue *
                                                (NOF_xGrids / 2) -
                                            Provider.of<AppState>(
                                              context,
                                            ).triggerHorizontalOffset,
                                color: triggerColor,
                                strokeWidth: 0.0,
                                label: VerticalLineLabel(
                                  padding: EdgeInsets.only(top: 0),
                                  show:
                                      Provider.of<AppState>(
                                        context,
                                        listen: true,
                                      ).channel1IsTriggered,
                                  alignment: Alignment.topCenter,
                                  labelResolver: (p0) => '▼',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                            horizontalLines: [
                              HorizontalLine(
                                y:
                                    ((Provider.of<AppState>(
                                                  context,
                                                ).ch1_uVoltageLevelOffset)
                                                .abs() <
                                            (channel1.uVperDivision *
                                                (NOF_yGrids / 2)))
                                        ? 20.0
                                        : (Provider.of<AppState>(
                                              context,
                                            ).ch1_uVoltageLevelOffset >
                                            0)
                                        ? ((Provider.of<AppState>(
                                                  context,
                                                ).ch1_uVoltageValue *
                                                (NOF_yGrids / 2)) -
                                            (Provider.of<AppState>(
                                                  context,
                                                ).ch1_uVoltageLevelOffset +
                                                0))
                                        : (-Provider.of<AppState>(
                                                  context,
                                                ).ch1_uVoltageValue *
                                                (NOF_yGrids / 2) -
                                            Provider.of<AppState>(
                                              context,
                                            ).ch1_uVoltageLevelOffset +
                                            50),
                                color: channel1.channelColor,
                                strokeWidth: 0,
                                label: HorizontalLineLabel(
                                  padding: EdgeInsets.only(right: 5),
                                  show: channel1.channelIsActive,
                                  alignment: Alignment.centerLeft,
                                  labelResolver: (p0) => '▶',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Trigger offset
                              HorizontalLine(
                                y:
                                    ((Provider.of<AppState>(context).timeValue *
                                                ((NOF_yGrids / 2) - 1)) >
                                            (Provider.of<AppState>(
                                                  context,
                                                ).triggerVerticalOffset)
                                                .abs())
                                        ? 0
                                        : (Provider.of<AppState>(
                                              context,
                                            ).triggerVerticalOffset <
                                            0)
                                        ? -Provider.of<AppState>(
                                                  context,
                                                ).timeValue *
                                                (NOF_yGrids / 2) -
                                            Provider.of<AppState>(
                                              context,
                                            ).triggerVerticalOffset
                                        : Provider.of<AppState>(
                                                  context,
                                                ).timeValue *
                                                (NOF_yGrids / 2) -
                                            Provider.of<AppState>(
                                              context,
                                            ).triggerVerticalOffset,
                                color: triggerColor,
                                strokeWidth: 0.0,
                                label: HorizontalLineLabel(
                                  padding: EdgeInsets.only(top: 0),
                                  show:
                                      Provider.of<AppState>(
                                        context,
                                        listen: true,
                                      ).channel1IsTriggered,
                                  alignment: Alignment.centerRight,
                                  labelResolver: (p0) => '◀',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // CH2
                      LineChart(
                        LineChartData(
                          backgroundColor: clear,
                          clipData:
                              FlClipData.all(), // Ensures that the line stays in the Chart
                          baselineX: 0.0,
                          baselineY: 0.0,
                          maxY:
                              Provider.of<AppState>(
                                context,
                              ).maxGraphVoltageValueCH2,
                          minY:
                              Provider.of<AppState>(
                                context,
                              ).minGraphVoltageValueCH2,
                          maxX:
                              Provider.of<AppState>(context).maxGraphTimeValue,
                          minX:
                              Provider.of<AppState>(context).minGraphTimeValue,
                          // Grid Data
                          gridData: FlGridData(
                            horizontalInterval:
                                ((2 *
                                        Provider.of<AppState>(
                                          context,
                                        ).ch2_uVoltageValue) /
                                    NOF_yGrids),
                            verticalInterval:
                                ((2 *
                                        Provider.of<AppState>(
                                          context,
                                        ).timeValue) /
                                    NOF_xGrids),
                            getDrawingHorizontalLine:
                                (value) => FlLine(
                                  color: clear,
                                  strokeWidth: 1.0,
                                  dashArray: [4, 4],
                                ),
                            getDrawingVerticalLine:
                                (value) => FlLine(
                                  color: clear,
                                  strokeWidth: 1.0,
                                  dashArray: [4, 4],
                                ),
                          ),
                          // Titles off
                          titlesData: FlTitlesData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              show: channel2.channelIsActive,
                              spots: plotData2,
                              color: channel2.channelColor,
                              barWidth: 3.0,
                              isCurved: false,
                              dotData: FlDotData(show: false),
                            ),
                          ],
                          lineTouchData: LineTouchData(
                            enabled: false,
                          ), // disable the linetouchdata
                          extraLinesData: ExtraLinesData(
                            verticalLines: [
                              VerticalLine(
                                x:
                                    ((Provider.of<AppState>(context).timeValue *
                                                ((NOF_xGrids / 2) - 1)) >
                                            (Provider.of<AppState>(
                                                  context,
                                                ).triggerHorizontalOffset)
                                                .abs())
                                        ? 0
                                        : (Provider.of<AppState>(
                                              context,
                                            ).triggerHorizontalOffset <
                                            0)
                                        ? -Provider.of<AppState>(
                                                  context,
                                                ).timeValue *
                                                (NOF_xGrids / 2) -
                                            Provider.of<AppState>(
                                              context,
                                            ).triggerHorizontalOffset
                                        : Provider.of<AppState>(
                                                  context,
                                                ).timeValue *
                                                (NOF_xGrids / 2) -
                                            Provider.of<AppState>(
                                              context,
                                            ).triggerHorizontalOffset,
                                color: triggerColor,
                                strokeWidth: 0.0,
                                label: VerticalLineLabel(
                                  padding: EdgeInsets.only(top: 0),
                                  show:
                                      Provider.of<AppState>(
                                        context,
                                        listen: true,
                                      ).channel2IsTriggered,
                                  alignment: Alignment.topCenter,
                                  labelResolver: (p0) => '▼',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                            horizontalLines: [
                              // Offset Data
                              HorizontalLine(
                                y:
                                    ((Provider.of<AppState>(
                                                      context,
                                                    ).ch2_uVoltageLevelOffset +
                                                    0)
                                                .abs() <
                                            (channel2.uVperDivision *
                                                (NOF_yGrids / 2)))
                                        ? 20.0
                                        : (Provider.of<AppState>(
                                              context,
                                            ).ch2_uVoltageLevelOffset >
                                            0)
                                        ? ((Provider.of<AppState>(
                                                  context,
                                                ).ch2_uVoltageValue *
                                                (NOF_yGrids / 2)) -
                                            (Provider.of<AppState>(
                                                  context,
                                                ).ch2_uVoltageLevelOffset +
                                                0))
                                        : (-Provider.of<AppState>(
                                                  context,
                                                ).ch2_uVoltageValue *
                                                (NOF_yGrids / 2) -
                                            Provider.of<AppState>(
                                              context,
                                            ).ch2_uVoltageLevelOffset +
                                            50),
                                color: channel2.channelColor,
                                strokeWidth: 0,
                                label: HorizontalLineLabel(
                                  padding: EdgeInsets.only(left: 4),
                                  show: channel2.channelIsActive,
                                  alignment: Alignment.centerLeft,
                                  labelResolver: (p0) => '▶',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Trigger offset
                              HorizontalLine(
                                y:
                                    ((Provider.of<AppState>(context).timeValue *
                                                ((NOF_yGrids / 2) - 1)) >
                                            (Provider.of<AppState>(
                                                  context,
                                                ).triggerVerticalOffset)
                                                .abs())
                                        ? 0
                                        : (Provider.of<AppState>(
                                              context,
                                            ).triggerVerticalOffset <
                                            0)
                                        ? -Provider.of<AppState>(
                                                  context,
                                                ).timeValue *
                                                (NOF_yGrids / 2) -
                                            Provider.of<AppState>(
                                              context,
                                            ).triggerVerticalOffset
                                        : Provider.of<AppState>(
                                                  context,
                                                ).timeValue *
                                                (NOF_yGrids / 2) -
                                            Provider.of<AppState>(
                                              context,
                                            ).triggerVerticalOffset,
                                color: triggerColor,
                                strokeWidth: 0.0,
                                label: HorizontalLineLabel(
                                  padding: EdgeInsets.only(top: 0),
                                  show:
                                      Provider.of<AppState>(
                                        context,
                                        listen: true,
                                      ).channel2IsTriggered,
                                  alignment: Alignment.centerRight,
                                  labelResolver: (p0) => '◀',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), // Trigger
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                              child: Container(color: Colors.grey[200]),
                            ),
                            flex: 3,
                          ),
                          Expanded(
                            flex: 12,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                              child: Container(
                                color: channel1_lightBackgroundColor,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(child: SizedBox(), flex: 1),
                                        AutoSizeText(
                                          "Measurements CH1",
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: 'PrimaryFont',
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenHeight * 0.022,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(child: SizedBox(), flex: 10),
                                      ],
                                    ),
                                    Expanded(
                                      child: GridView.count(
                                        crossAxisCount: 2,
                                        padding: EdgeInsets.fromLTRB(
                                          10,
                                          0,
                                          10,
                                          10,
                                        ),
                                        childAspectRatio:
                                            dataWindowHeight / dataWindowWidth,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH1_Period)
                                            MeasurementDataTemplate(
                                              key: ch1_Period_key,
                                              color: ch1_WindowDataColor,
                                              title: "Period",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "s",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH1_Frequency)
                                            MeasurementDataTemplate(
                                              key: ch1_Frequency_key,
                                              color: ch1_WindowDataColor,
                                              title: "Frequency",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "Hz",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH1_widthPos)
                                            MeasurementDataTemplate(
                                              key: ch1_widthPos_key,
                                              color: ch1_WindowDataColor,
                                              title: "Width +",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "s",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH1_widthNeg)
                                            MeasurementDataTemplate(
                                              key: ch1_widthNeg_key,
                                              color: ch1_WindowDataColor,
                                              title: "Width -",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "s",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH1_DutyPos)
                                            MeasurementDataTemplate(
                                              key: ch1_dutyPos_key,
                                              color: ch1_WindowDataColor,
                                              title: "Duty-Cycle +",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "s",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH1_DutyNeg)
                                            MeasurementDataTemplate(
                                              key: ch1_dutyNeg_key,
                                              color: ch1_WindowDataColor,
                                              title: "Duty-Cycle -",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "s",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH1_Vmax)
                                            MeasurementDataTemplate(
                                              key: ch1_Vmax_key,
                                              color: ch1_WindowDataColor,
                                              title: "Vmax",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH1_Vmin)
                                            MeasurementDataTemplate(
                                              key: ch1_Vmin_key,
                                              color: ch1_WindowDataColor,
                                              title: "Vmin",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH1_Vpp)
                                            MeasurementDataTemplate(
                                              key: ch1_Vpp_key,
                                              color: ch1_WindowDataColor,
                                              title: "Vpp",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH1_Vamp)
                                            MeasurementDataTemplate(
                                              key: ch1_Vamp_key,
                                              color: ch1_WindowDataColor,
                                              title: "Vamp",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH1_Vtop)
                                            MeasurementDataTemplate(
                                              key: ch1_Vtop_key,
                                              color: ch1_WindowDataColor,
                                              title: "Vtop",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH1_Vbase)
                                            MeasurementDataTemplate(
                                              key: ch1_Vbase_key,
                                              color: ch1_WindowDataColor,
                                              title: "Vbase",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH1_Vavg)
                                            MeasurementDataTemplate(
                                              key: ch1_Vavg_key,
                                              color: ch1_WindowDataColor,
                                              title: "Vavg",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH1_Vrms)
                                            MeasurementDataTemplate(
                                              key: ch1_Vrms_key,
                                              color: ch1_WindowDataColor,
                                              title: "Vrms",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 12,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                              child: Container(
                                color: channel2_lightBackgroundColor,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(child: SizedBox(), flex: 1),
                                        AutoSizeText(
                                          "Measurements CH2",
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: 'PrimaryFont',
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenHeight * 0.022,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(child: SizedBox(), flex: 10),
                                      ],
                                    ),
                                    Expanded(
                                      child: GridView.count(
                                        crossAxisCount: 2,
                                        padding: EdgeInsets.fromLTRB(
                                          10,
                                          0,
                                          10,
                                          10,
                                        ),
                                        childAspectRatio:
                                            dataWindowHeight / dataWindowWidth,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH2_Period)
                                            MeasurementDataTemplate(
                                              key: ch2_Period_key,
                                              color: ch2_WindowDataColor,
                                              title: "Period",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "s",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH2_Frequency)
                                            MeasurementDataTemplate(
                                              key: ch2_Frequency_key,
                                              color: ch2_WindowDataColor,
                                              title: "Frequency",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "Hz",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH2_widthPos)
                                            MeasurementDataTemplate(
                                              key: ch2_widthPos_key,
                                              color: ch2_WindowDataColor,
                                              title: "Width +",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "s",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH2_widthNeg)
                                            MeasurementDataTemplate(
                                              key: ch2_widthNeg_key,
                                              color: ch2_WindowDataColor,
                                              title: "Width -",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "s",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH2_DutyPos)
                                            MeasurementDataTemplate(
                                              key: ch2_dutyPos_key,
                                              color: ch2_WindowDataColor,
                                              title: "Duty-Cycle +",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "s",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH2_DutyNeg)
                                            MeasurementDataTemplate(
                                              key: ch2_dutyNeg_key,
                                              color: ch2_WindowDataColor,
                                              title: "Duty-Cycle -",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "s",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH2_Vmax)
                                            MeasurementDataTemplate(
                                              key: ch2_Vmax_key,
                                              color: ch2_WindowDataColor,
                                              title: "Vmax",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH2_Vmin)
                                            MeasurementDataTemplate(
                                              key: ch2_Vmin_key,
                                              color: ch2_WindowDataColor,
                                              title: "Vmin",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH2_Vpp)
                                            MeasurementDataTemplate(
                                              key: ch2_Vpp_key,
                                              color: ch2_WindowDataColor,
                                              title: "Vpp",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH2_Vamp)
                                            MeasurementDataTemplate(
                                              key: ch2_Vamp_key,
                                              color: ch2_WindowDataColor,
                                              title: "Vamp",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH2_Vtop)
                                            MeasurementDataTemplate(
                                              key: ch2_Vtop_key,
                                              color: ch2_WindowDataColor,
                                              title: "Vtop",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH2_Vbase)
                                            MeasurementDataTemplate(
                                              key: ch2_Vbase_key,
                                              color: ch2_WindowDataColor,
                                              title: "Vbase",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH2_Vavg)
                                            MeasurementDataTemplate(
                                              key: ch2_Vavg_key,
                                              color: ch2_WindowDataColor,
                                              title: "Vavg",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),

                                          if (Provider.of<MeasurementsChanges>(
                                            context,
                                            listen: true,
                                          ).measCH2_Vrms)
                                            MeasurementDataTemplate(
                                              key: ch2_Vrms_key,
                                              color: ch2_WindowDataColor,
                                              title: "Vrms",
                                              initialData: 0,
                                              decimalDigits: 1,
                                              unit: "V",
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
