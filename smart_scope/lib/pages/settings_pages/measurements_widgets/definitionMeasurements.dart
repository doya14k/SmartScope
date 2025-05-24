import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:smart_scope/usb_reader.dart';
import 'package:smart_scope/pages/settings_pages/settings_widgets/definitions.dart';
import 'package:fl_chart/fl_chart.dart';

// Channel Parameters
Color channel1_lightBackgroundColor = Colors.amber.shade200;
Color channel2_lightBackgroundColor = Colors.blue.shade100;
int selectedMeasurementSettingsChannel = 0;

Color clear2 = Colors.transparent;
Color measurementSelectedBackground = Colors.grey.shade400;
Color measurementnotSelectedBackground = Colors.grey.shade50;

double outlinedButtonWidth = 150;
double outlinedButtonHeight = 60;

final GlobalKey<_MeasurementDataTemplateState> ch1_Period_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch1_Frequency_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch1_widthPos_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch1_widthNeg_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch1_dutyPos_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch1_dutyNeg_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch1_Vmax_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch1_Vmin_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch1_Vpp_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch1_Vamp_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch1_Vtop_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch1_Vbase_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch1_Vavg_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch1_Vrms_key = GlobalKey();

final GlobalKey<_MeasurementDataTemplateState> ch2_Period_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch2_Frequency_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch2_widthPos_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch2_widthNeg_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch2_dutyPos_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch2_dutyNeg_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch2_Vmax_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch2_Vmin_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch2_Vpp_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch2_Vamp_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch2_Vtop_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch2_Vbase_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch2_Vavg_key = GlobalKey();
final GlobalKey<_MeasurementDataTemplateState> ch2_Vrms_key = GlobalKey();

// DataWindow
String Data2Text(double data, int decimalDigits, String unit) {
  double dataAbs = data.abs();
  if (dataAbs >= 1000000000) {
    return '${(data / 1000000000).toStringAsFixed(decimalDigits)} G$unit';
  } else if (dataAbs >= 1000000) {
    return '${(data / 1000000).toStringAsFixed(decimalDigits)} M$unit';
  } else if (dataAbs >= 1000) {
    return '${(data / 1000).toStringAsFixed(decimalDigits)} k$unit';
  } else if (dataAbs >= 1.0) {
    return '${data.toStringAsFixed(decimalDigits)} $unit';
  } else if (dataAbs >= 0.001) {
    return '${(data * 1000).toStringAsFixed(decimalDigits)} m$unit';
  } else if (dataAbs >= 0.000001) {
    return '${(data * 1000000).toStringAsFixed(decimalDigits)} µ$unit';
  } else if (dataAbs >= 0.000000001) {
    return '${(data * 1000000000).toStringAsFixed(decimalDigits)} n$unit';
  }
  return "$data $unit";
}

Color ch1_WindowDataColor = Colors.amber.shade50;
Color ch2_WindowDataColor = Colors.blue.shade50;

double dataWindowWidth = 95;
double dataWindowHeight = 70;

class MeasurementDataTemplate extends StatefulWidget {
  final String title;
  final Color color;
  final double? initialData;
  final int decimalDigits;
  final String unit;

  const MeasurementDataTemplate({
    required super.key,
    required this.title,
    this.initialData,
    required this.color,
    required this.decimalDigits,
    required this.unit,
  });

  @override
  State<MeasurementDataTemplate> createState() =>
      _MeasurementDataTemplateState();
}

class _MeasurementDataTemplateState extends State<MeasurementDataTemplate> {
  late double _data;

  @override
  void initState() {
    super.initState();
    if (widget.initialData == null) {
      _data = 0.0;
    } else {
      _data = widget.initialData!;
    }
  }

  void updateData(double newData) {
    setState(() {
      _data = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.06156,
      width: screenWidth * 0.049479,
      child: Padding(
        padding: EdgeInsets.all(screenHeight * 0.002638),
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            border: Border.all(
              color: Colors.black,
              width: screenHeight * 0.001099,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: AutoSizeText(
                  widget.title,
                  minFontSize: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.0132,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: AutoSizeText(
                  Data2Text(_data, widget.decimalDigits, widget.unit),
                  minFontSize: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.01759,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MeasurementsChanges extends ChangeNotifier {
  late UsbProvider usbProvider;

  void setUsbProvider_measurements(UsbProvider newUsbProvider) {
    usbProvider = newUsbProvider;
  }

  late AppState appStateProvider;

  void setAppState_measurements(AppState new_appStateProvider) {
    appStateProvider = new_appStateProvider;
  }

  // Data Variables Time
  double ch1_Period = 0;
  double ch1_Frequency = 0;
  double ch1_widthPos = 0;
  double ch1_widthNeg = 0;
  double ch1_DutyPos = 0;
  double ch1_DutyNeg = 0;
  double ch2_Period = 0;
  double ch2_Frequency = 0;
  double ch2_widthPos = 0;
  double ch2_widthNeg = 0;
  double ch2_DutyPos = 0;
  double ch2_DutyNeg = 0;

  // Data Variables Vertical
  double ch1_Vmax = 0;
  double ch1_Vmin = 0;
  double ch1_Vpp = 0;
  double ch1_Vamp = 0;
  double ch1_Vtop = 0;
  double ch1_Vbase = 0;
  double ch1_Vavg = 0;
  double ch1_Vrms = 0;
  double ch2_Vmax = 0;
  double ch2_Vmin = 0;
  double ch2_Vpp = 0;
  double ch2_Vamp = 0;
  double ch2_Vtop = 0;
  double ch2_Vbase = 0;
  double ch2_Vavg = 0;
  double ch2_Vrms = 0;

  bool measCH1_Period = false;
  bool measCH1_Frequency = false;
  bool measCH1_widthPos = false;
  bool measCH1_widthNeg = false;
  bool measCH1_DutyPos = false;
  bool measCH1_DutyNeg = false;

  update_measCH1_Period_data() {
    List<FlSpot> spots = usbProvider.ch1_data;

    if (spots.length < 2) return;

    double minY = spots.first.y;
    double maxY = spots.first.y;
    for (var spot in spots) {
      if (spot.y < minY) minY = spot.y;
      if (spot.y > maxY) maxY = spot.y;
    }

    double midLevel = (minY + maxY) / 2;

    List<double> risingCrossings = [];
    List<double> fallingCrossings = [];

    for (int i = 1; i < spots.length; i++) {
      final prev = spots[i - 1];
      final current = spots[i];

      bool crossesUp = prev.y < midLevel && current.y >= midLevel;
      bool crossesDown = prev.y > midLevel && current.y <= midLevel;

      if (crossesUp || crossesDown) {
        double crossTime =
            prev.x +
            (current.x - prev.x) * ((midLevel - prev.y) / (current.y - prev.y));

        if (crossesUp) {
          risingCrossings.add(crossTime);
        } else {
          fallingCrossings.add(crossTime);
        }
      }
    }

    if (risingCrossings.length >= 2) {
      ch1_Period = (risingCrossings[1] - risingCrossings[0]) / 1000000.0;
      ch1_Period_key.currentState?.updateData(ch1_Period);
      print("Periode_rising $ch1_Period");
    } else if (fallingCrossings.length >= 2) {
      ch1_Period = (fallingCrossings[1] - fallingCrossings[0]) / 1000000.0;
      ch1_Period_key.currentState?.updateData(ch1_Period);
      print("Periode_falling $ch1_Period");
    } else {
      print("Keine Periode gefunden");
    }
  }

  update_measCH1_Frequency_data() {
    if (ch1_Period != 0) {
      ch1_Frequency = 1 / ch1_Period;
    } else {
      ch1_Frequency = 0;
    }
    ch1_Frequency_key.currentState?.updateData(ch1_Frequency);
  }

  update_measCH1_widthPos_data() {
    List<FlSpot> spots = usbProvider.ch1_data;

    if (spots.length < 2) return;

    double minY = spots.first.y;
    double maxY = spots.first.y;
    for (var spot in spots) {
      if (spot.y < minY) minY = spot.y;
      if (spot.y > maxY) maxY = spot.y;
    }

    double midLevel = (minY + maxY) / 2;

    List<double> risingCrossings = [];
    List<double> fallingCrossings = [];

    for (int i = 1; i < spots.length; i++) {
      final prev = spots[i - 1];
      final current = spots[i];

      bool crossesUp = prev.y < midLevel && current.y >= midLevel;
      bool crossesDown = prev.y > midLevel && current.y <= midLevel;

      if (crossesUp || crossesDown) {
        double crossTime =
            prev.x +
            (current.x - prev.x) * ((midLevel - prev.y) / (current.y - prev.y));

        if (crossesUp) {
          risingCrossings.add(crossTime);
        } else {
          fallingCrossings.add(crossTime);
        }
      }
    }
    double periodStart = 0;
    double periodEnd = 0;

    if (risingCrossings.length >= 2) {
      ch1_Period = (risingCrossings[1] - risingCrossings[0]) / 1000000.0;
      periodStart = risingCrossings[0];
      periodEnd = risingCrossings[1];
      ch1_Period_key.currentState?.updateData(ch1_Period);
      print("Periode_rising $ch1_Period");
    } else if (fallingCrossings.length >= 2) {
      ch1_Period = (fallingCrossings[1] - fallingCrossings[0]) / 1000000.0;
      periodStart = fallingCrossings[0];
      periodEnd = fallingCrossings[1];
      ch1_Period_key.currentState?.updateData(ch1_Period);
      print("Periode_falling $ch1_Period");
    } else {
      print("no period found");
    }

    List<FlSpot> periodData =
        spots.where((e) => e.x >= periodStart && e.x <= periodEnd).toList();
    double summe = 0;

    for (var spot in periodData) {
      summe += spot.y;
    }

    ch1_Vavg = summe / (1000000 * periodData.length);
    ch1_Vavg_key.currentState?.updateData(ch1_Vavg);

    double widthPosTime = 0;

    for (int i = 1; i < periodData.length; i++) {
      final prev = periodData[i - 1];
      final current = periodData[i];
      final deltaTime = current.x - prev.x;

      bool crossesMid = (prev.y - midLevel) * (current.y - midLevel) < 0;

      if (crossesMid) {
        double crossX =
            prev.x +
            (current.x - prev.x) * ((midLevel - prev.y) / (current.y - prev.y));

        if (prev.y >= midLevel) {
          widthPosTime += crossX - prev.x;
        } else {
          widthPosTime += current.x - crossX;
        }
      } else {
        if (prev.y >= midLevel && current.y >= midLevel) {
          widthPosTime += deltaTime;
        }
      }
    }

    ch1_widthPos = widthPosTime / 1000000.0;
    ch1_widthPos_key.currentState?.updateData(ch1_widthPos);
    print("WidthPos: $ch1_widthPos ");
  }

  update_measCH1_widthNeg_data() {
    List<FlSpot> spots = usbProvider.ch1_data;

    if (spots.length < 2) return;

    double minY = spots.first.y;
    double maxY = spots.first.y;
    for (var spot in spots) {
      if (spot.y < minY) minY = spot.y;
      if (spot.y > maxY) maxY = spot.y;
    }

    double midLevel = (minY + maxY) / 2;

    List<double> risingCrossings = [];
    List<double> fallingCrossings = [];

    for (int i = 1; i < spots.length; i++) {
      final prev = spots[i - 1];
      final current = spots[i];

      bool crossesUp = prev.y < midLevel && current.y >= midLevel;
      bool crossesDown = prev.y > midLevel && current.y <= midLevel;

      if (crossesUp || crossesDown) {
        double crossTime =
            prev.x +
            (current.x - prev.x) * ((midLevel - prev.y) / (current.y - prev.y));

        if (crossesUp) {
          risingCrossings.add(crossTime);
        } else {
          fallingCrossings.add(crossTime);
        }
      }
    }
    double periodStart = 0;
    double periodEnd = 0;

    if (risingCrossings.length >= 2) {
      ch1_Period = (risingCrossings[1] - risingCrossings[0]) / 1000000.0;
      periodStart = risingCrossings[0];
      periodEnd = risingCrossings[1];
      ch1_Period_key.currentState?.updateData(ch1_Period);
      print("Periode_rising $ch1_Period");
    } else if (fallingCrossings.length >= 2) {
      ch1_Period = (fallingCrossings[1] - fallingCrossings[0]) / 1000000.0;
      periodStart = fallingCrossings[0];
      periodEnd = fallingCrossings[1];
      ch1_Period_key.currentState?.updateData(ch1_Period);
      print("Periode_falling $ch1_Period");
    } else {
      print("no period found");
    }

    List<FlSpot> periodData =
        spots.where((e) => e.x >= periodStart && e.x <= periodEnd).toList();
    double summe = 0;

    for (var spot in periodData) {
      summe += spot.y;
    }

    ch1_Vavg = summe / (1000000 * periodData.length);
    ch1_Vavg_key.currentState?.updateData(ch1_Vavg);

    double widthNegTime = 0;

    for (int i = 1; i < periodData.length; i++) {
      final prev = periodData[i - 1];
      final current = periodData[i];
      final deltaTime = current.x - prev.x;

      bool crossesMid = (prev.y - midLevel) * (current.y - midLevel) < 0;

      if (crossesMid) {
        double crossX =
            prev.x +
            (current.x - prev.x) * ((midLevel - prev.y) / (current.y - prev.y));

        if (prev.y >= midLevel) {
          widthNegTime += current.x - crossX;
        } else {
          widthNegTime += crossX - prev.x;
        }
      } else {
        if (prev.y < midLevel && current.y < midLevel) {
          widthNegTime += deltaTime;
        }
      }
    }

    ch1_widthNeg = widthNegTime / 1000000.0;
    ch1_widthNeg_key.currentState?.updateData(ch1_widthNeg);
    print("WidthNeg: $ch1_widthNeg");
  }

  update_measCH1_dutyPos_data() {
    update_measCH1_widthPos_data();
    ch1_DutyPos = (ch1_widthPos / ch1_Period) * 100;
    ch1_dutyPos_key.currentState?.updateData(ch1_DutyPos);
  }

  update_measCH1_dutyNeg_data() {
    update_measCH1_widthNeg_data();
    ch1_DutyNeg = (ch1_widthNeg / ch1_Period) * 100;
    ch1_dutyNeg_key.currentState?.updateData(ch1_DutyNeg);
  }

  update_measCH1_Period() {
    measCH1_Period = !measCH1_Period;
    print('CH1 Period: $measCH1_Period');
    notifyListeners();
  }

  update_measCH1_Frequency() {
    measCH1_Frequency = !measCH1_Frequency;
    print('CH1 Frequency: $measCH1_Frequency');
    notifyListeners();
  }

  update_measCH1_widthPos() {
    measCH1_widthPos = !measCH1_widthPos;
    print('CH1 Width+: $measCH1_widthPos');
    notifyListeners();
  }

  update_measCH1_widthNeg() {
    measCH1_widthNeg = !measCH1_widthNeg;
    print('CH1 Width-: $measCH1_widthNeg');
    notifyListeners();
  }

  update_measCH1_dutyPos() {
    measCH1_DutyPos = !measCH1_DutyPos;
    print('CH1 Duty-Cycle +: $measCH1_DutyPos');
    notifyListeners();
  }

  update_measCH1_dutyNeg() {
    measCH1_DutyNeg = !measCH1_DutyNeg;
    print('CH1 Duty-Cycle -: $measCH1_DutyNeg');
    notifyListeners();
  }

  bool measCH1_Vmax = false;
  bool measCH1_Vmin = false;
  bool measCH1_Vpp = false;
  bool measCH1_Vamp = false;
  bool measCH1_Vtop = false;
  bool measCH1_Vbase = false;
  bool measCH1_Vavg = false;
  bool measCH1_Vrms = false;

  bool get CH1_MeasurementActive {
    return (measCH1_Vmax ||
        measCH1_Vmin ||
        measCH1_Vpp ||
        measCH1_Vamp ||
        measCH1_Vtop ||
        measCH1_Vbase ||
        measCH1_Vavg ||
        measCH1_Vrms ||
        measCH1_Period ||
        measCH1_Frequency ||
        measCH1_widthPos ||
        measCH1_widthNeg ||
        measCH1_DutyPos ||
        measCH1_DutyNeg);
  }

  update_measCH1_Vmax_data() {
    List<double> voltageValues = usbProvider.ch1_data.map((p) => p.y).toList();
    ch1_Vmax = (voltageValues.reduce(max) / 1000000);

    ch1_Vmax_key.currentState?.updateData(ch1_Vmax);

    notifyListeners();
  }

  update_measCH1_Vmin_data() {
    List<double> voltageValues = usbProvider.ch1_data.map((p) => p.y).toList();
    ch1_Vmin = (voltageValues.reduce(min) / 1000000);

    ch1_Vmin_key.currentState?.updateData(ch1_Vmin);
  }

  update_measCH1_Vpp_data() {
    List<double> voltageValues = usbProvider.ch1_data.map((p) => p.y).toList();
    ch1_Vpp = (voltageValues.reduce(max) - voltageValues.reduce(min)) / 1000000;

    ch1_Vpp_key.currentState?.updateData(ch1_Vpp);
  }

  update_measCH1_Vamp_data() {
    List<double> voltageValues = usbProvider.ch1_data.map((p) => p.y).toList();

    ch1_Vamp =
        (voltageValues.reduce(max) -
            (voltageValues.reduce(max) + voltageValues.reduce(min)) / 2) /
        1000000;
    ch1_Vamp_key.currentState?.updateData(ch1_Vamp);
  }

  update_measCH1_Vtop_data() {
    List<FlSpot> spots = usbProvider.ch1_data;
    if (spots.isEmpty) return;

    double minY = spots.first.y;
    double maxY = spots.first.y;

    for (var spot in spots) {
      if (spot.y < minY) minY = spot.y;
      if (spot.y > maxY) maxY = spot.y;
    }

    double vpp = maxY - minY;
    double vupper = minY + 0.9 * vpp;

    List<double> topYs = [];

    for (var spot in spots) {
      if (spot.y >= vupper) {
        topYs.add(spot.y);
      }
    }

    double ch1_Vtop =
        topYs.isNotEmpty
            ? topYs.reduce((a, b) => a + b) / (topYs.length * 1000000)
            : (maxY * 1000000);

    print("Vtop: $ch1_Vtop");
    ch1_Vtop_key.currentState?.updateData(ch1_Vtop);
  }

  update_measCH1_Vbase_data() {
    List<FlSpot> spots = usbProvider.ch1_data;
    if (spots.isEmpty) return;

    double minY = spots.first.y;
    double maxY = spots.first.y;

    for (var spot in spots) {
      if (spot.y < minY) minY = spot.y;
      if (spot.y > maxY) maxY = spot.y;
    }

    double vpp = maxY - minY;
    double vlower = minY + 0.1 * vpp;
    List<double> baseYs = [];

    for (var spot in spots) {
      if (spot.y <= vlower) {
        baseYs.add(spot.y);
      }
    }
    double ch1_Vbase =
        baseYs.isNotEmpty
            ? baseYs.reduce((a, b) => a + b) / (baseYs.length * 1000000)
            : (minY * 1000000);
    print("Vbase: $ch1_Vbase");

    ch1_Vbase_key.currentState?.updateData(ch1_Vbase);
  }

  update_measCH1_Vavg_data() {
    List<FlSpot> spots = usbProvider.ch1_data;

    if (spots.length < 2) return;

    double minY = spots.first.y;
    double maxY = spots.first.y;
    for (var spot in spots) {
      if (spot.y < minY) minY = spot.y;
      if (spot.y > maxY) maxY = spot.y;
    }

    double midLevel = (minY + maxY) / 2;

    List<double> risingCrossings = [];
    List<double> fallingCrossings = [];

    for (int i = 1; i < spots.length; i++) {
      final prev = spots[i - 1];
      final current = spots[i];

      bool crossesUp = prev.y < midLevel && current.y >= midLevel;
      bool crossesDown = prev.y > midLevel && current.y <= midLevel;

      if (crossesUp || crossesDown) {
        double crossTime =
            prev.x +
            (current.x - prev.x) * ((midLevel - prev.y) / (current.y - prev.y));

        if (crossesUp) {
          risingCrossings.add(crossTime);
        } else {
          fallingCrossings.add(crossTime);
        }
      }
    }
    double periodStart = 0;
    double periodEnd = 0;

    if (risingCrossings.length >= 2) {
      ch1_Period = (risingCrossings[1] - risingCrossings[0]) / 1000000.0;
      periodStart = risingCrossings[0];
      periodEnd = risingCrossings[1];
      ch1_Period_key.currentState?.updateData(ch1_Period);
      print("Periode_rising $ch1_Period");
    } else if (fallingCrossings.length >= 2) {
      ch1_Period = (fallingCrossings[1] - fallingCrossings[0]) / 1000000.0;
      periodStart = fallingCrossings[0];
      periodEnd = fallingCrossings[1];
      ch1_Period_key.currentState?.updateData(ch1_Period);
      print("Periode_falling $ch1_Period");
    } else {
      print("no period found");
    }

    List<FlSpot> periodData =
        spots.where((e) => e.x >= periodStart && e.x <= periodEnd).toList();
    double summe = 0;

    for (var spot in periodData) {
      summe += spot.y;
    }

    ch1_Vavg = summe / (1000000 * periodData.length);
    ch1_Vavg_key.currentState?.updateData(ch1_Vavg);
  }

  update_measCH1_Vrms_data() {
    List<FlSpot> spots = usbProvider.ch1_data;

    if (spots.length < 2) return;

    double minY = spots.first.y;
    double maxY = spots.first.y;
    for (var spot in spots) {
      if (spot.y < minY) minY = spot.y;
      if (spot.y > maxY) maxY = spot.y;
    }

    double midLevel = (minY + maxY) / 2;

    List<double> risingCrossings = [];
    List<double> fallingCrossings = [];

    for (int i = 1; i < spots.length; i++) {
      final prev = spots[i - 1];
      final current = spots[i];

      bool crossesUp = prev.y < midLevel && current.y >= midLevel;
      bool crossesDown = prev.y > midLevel && current.y <= midLevel;

      if (crossesUp || crossesDown) {
        double crossTime =
            prev.x +
            (current.x - prev.x) * ((midLevel - prev.y) / (current.y - prev.y));

        if (crossesUp) {
          risingCrossings.add(crossTime);
        } else {
          fallingCrossings.add(crossTime);
        }
      }
    }
    double periodStart = 0;
    double periodEnd = 0;

    if (risingCrossings.length >= 2) {
      ch1_Period = (risingCrossings[1] - risingCrossings[0]) / 1000000.0;
      periodStart = risingCrossings[0];
      periodEnd = risingCrossings[1];
      ch1_Period_key.currentState?.updateData(ch1_Period);
      print("Periode_rising $ch1_Period");
    } else if (fallingCrossings.length >= 2) {
      ch1_Period = (fallingCrossings[1] - fallingCrossings[0]) / 1000000.0;
      periodStart = fallingCrossings[0];
      periodEnd = fallingCrossings[1];
      ch1_Period_key.currentState?.updateData(ch1_Period);
      print("Periode_falling $ch1_Period");
    } else {
      print("no period found");
    }

    List<FlSpot> periodData =
        spots.where((e) => e.x >= periodStart && e.x <= periodEnd).toList();

    double sumWeightedSquares = 0.0;
    double totalTime = periodData.last.x - periodData.first.x;

    for (int i = 0; i < periodData.length - 1; i++) {
      double dt = periodData[i + 1].x - periodData[i].x;
      double ySquared = periodData[i].y * periodData[i].y;
      sumWeightedSquares += (ySquared * dt) / 1000000000000;
    }

    ch1_Vrms = sqrt(sumWeightedSquares / (totalTime));
    ch1_Vrms_key.currentState?.updateData(ch1_Vrms);
  }

  update_measCH1_Vmax() {
    measCH1_Vmax = !measCH1_Vmax;
    print('CH1 Vmax: $measCH1_Vmax');
    notifyListeners();
  }

  update_measCH1_Vmin() {
    measCH1_Vmin = !measCH1_Vmin;
    print('CH1 Vmin: $measCH1_Vmin');
    notifyListeners();
  }

  update_measCH1_Vpp() {
    measCH1_Vpp = !measCH1_Vpp;
    print('CH1 Vpp: $measCH1_Vpp');
    ch2_Vpp_key.currentState?.updateData(10.0);
    notifyListeners();
  }

  update_measCH1_Vamp() {
    measCH1_Vamp = !measCH1_Vamp;
    print('CH1 Vamp: $measCH1_Vamp');
    notifyListeners();
  }

  update_measCH1_Vtop() {
    measCH1_Vtop = !measCH1_Vtop;
    print('CH1 Vtop: $measCH1_Vtop');
    notifyListeners();
  }

  update_measCH1_Vbase() {
    measCH1_Vbase = !measCH1_Vbase;
    print('CH1 Vbase: $measCH1_Vbase');
    notifyListeners();
  }

  update_measCH1_Vavg() {
    measCH1_Vavg = !measCH1_Vavg;
    print('CH1 Vavg: $measCH1_Vavg');
    notifyListeners();
  }

  update_measCH1_Vrms() {
    measCH1_Vrms = !measCH1_Vrms;
    print('CH1 Vrms: $measCH1_Vrms');
    notifyListeners();
  }

  bool measCH2_Period = false;
  bool measCH2_Frequency = false;
  bool measCH2_widthPos = false;
  bool measCH2_widthNeg = false;
  bool measCH2_DutyPos = false;
  bool measCH2_DutyNeg = false;

  update_measCH2_Period_data() {
    List<FlSpot> spots = usbProvider.ch2_data;

    if (spots.length < 2) return;

    double minY = spots.first.y;
    double maxY = spots.first.y;
    for (var spot in spots) {
      if (spot.y < minY) minY = spot.y;
      if (spot.y > maxY) maxY = spot.y;
    }

    double midLevel = (minY + maxY) / 2;

    List<double> crossings = [];

    for (int i = 1; i < spots.length; i++) {
      final prev = spots[i - 1];
      final current = spots[i];

      if (prev.y < midLevel && current.y >= midLevel) {
        double zeroCrossTime =
            prev.x +
            (current.x - prev.x) * ((midLevel - prev.y) / (current.y - prev.y));
        crossings.add(zeroCrossTime);
      }
    }

    if (crossings.length >= 2) {
      ch2_Period = (crossings[1] - crossings[0]) / 1000000.0;
      ch2_Period_key.currentState?.updateData(ch2_Period);
      print("Periode $ch2_Period");
    } else {
      print("no period found");
    }
  }

  update_measCH2_Frequency_data() {
    if (ch2_Period != 0) {
      ch2_Frequency = 1 / ch2_Period;
    } else {
      ch2_Frequency = 0;
    }
    ch2_Frequency_key.currentState?.updateData(ch2_Frequency);
  }

  update_measCH2_widthPos_data() {}
  update_measCH2_widthNeg_data() {}

  update_measCH2_dutyPos_data() {
    ch2_DutyPos = ch2_widthPos / ch2_Period;
    ch2_dutyPos_key.currentState?.updateData(ch2_DutyPos);
  }

  update_measCH2_dutyNeg_data() {
    ch2_DutyNeg = ch2_widthNeg / ch2_Period;
    ch2_dutyNeg_key.currentState?.updateData(ch2_DutyNeg);
  }

  update_measCH2_Period() {
    measCH2_Period = !measCH2_Period;
    print('CH2 Period: $measCH2_Period');
    notifyListeners();
  }

  update_measCH2_Frequency() {
    measCH2_Frequency = !measCH2_Frequency;
    print('CH2 Frequency: $measCH2_Frequency');
    notifyListeners();
  }

  update_measCH2_widthPos() {
    measCH2_widthPos = !measCH2_widthPos;
    print('CH2 Width+: $measCH2_widthPos');
    notifyListeners();
  }

  update_measCH2_widthNeg() {
    measCH2_widthNeg = !measCH2_widthNeg;
    print('CH2 Width-: $measCH2_widthNeg');
    notifyListeners();
  }

  update_measCH2_dutyPos() {
    measCH2_DutyPos = !measCH2_DutyPos;
    print('CH2 Duty-Cycle +: $measCH2_DutyPos');
    notifyListeners();
  }

  update_measCH2_dutyNeg() {
    measCH2_DutyNeg = !measCH2_DutyNeg;
    print('CH2 Duty-Cycle -: $measCH2_DutyNeg');
    notifyListeners();
  }

  bool measCH2_Vmax = false;
  bool measCH2_Vmin = false;
  bool measCH2_Vpp = false;
  bool measCH2_Vamp = false;
  bool measCH2_Vtop = false;
  bool measCH2_Vbase = false;
  bool measCH2_Vavg = false;
  bool measCH2_Vrms = false;

  bool get CH2_MeasurementActive {
    return (measCH2_Vmax ||
        measCH2_Vmin ||
        measCH2_Vpp ||
        measCH2_Vamp ||
        measCH2_Vtop ||
        measCH2_Vbase ||
        measCH2_Vavg ||
        measCH2_Vrms ||
        measCH2_Period ||
        measCH2_Frequency ||
        measCH2_widthPos ||
        measCH2_widthNeg ||
        measCH2_DutyPos ||
        measCH2_DutyNeg);
  }

  update_measCH2_Vmax_data() {
    List<double> voltageValues = usbProvider.ch2_data.map((p) => p.y).toList();
    ch2_Vmax = (voltageValues.reduce(max) / 1000000);

    ch2_Vmax_key.currentState?.updateData(ch2_Vmax);

    notifyListeners();
  }

  update_measCH2_Vmin_data() {
    List<double> voltageValues = usbProvider.ch2_data.map((p) => p.y).toList();
    ch2_Vmin = (voltageValues.reduce(min) / 1000000);

    ch2_Vmin_key.currentState?.updateData(ch2_Vmin);
  }

  update_measCH2_Vpp_data() {
    List<double> voltageValues = usbProvider.ch2_data.map((p) => p.y).toList();
    ch2_Vpp = (voltageValues.reduce(max) - voltageValues.reduce(min)) / 1000000;

    ch2_Vpp_key.currentState?.updateData(ch2_Vpp);
  }

  update_measCH2_Vamp_data() {
    List<double> voltageValues = usbProvider.ch2_data.map((p) => p.y).toList();

    ch2_Vamp =
        (voltageValues.reduce(max) -
            (voltageValues.reduce(max) + voltageValues.reduce(min)) / 2) /
        1000000;
    ch2_Vamp_key.currentState?.updateData(ch2_Vamp);
  }

  update_measCH2_Vtop_data() {}
  update_measCH2_Vbase_data() {}
  update_measCH2_Vavg_data() {
    List<FlSpot> spots = usbProvider.ch2_data;

    double yTolerance = 0.005;
    int minOffset = 5;

    for (
      int startIndex = 1;
      startIndex < spots.length - minOffset;
      startIndex++
    ) {
      final start = spots[startIndex];
      final prevStart = spots[startIndex - 1];
      final startSteigung = start.y - prevStart.y;

      for (
        int endIndex = startIndex + minOffset;
        endIndex < spots.length;
        endIndex++
      ) {
        final end = spots[endIndex];
        final prevEnd = spots[endIndex - 1];
        final endSteigung = end.y - prevEnd.y;

        bool yIsSimilar = (end.y - start.y).abs() < yTolerance;
        bool gleicheRichtung = (startSteigung * endSteigung) > 0;

        if (yIsSimilar && gleicheRichtung) {
          // Period found !!!
          double summe = 0;

          for (int i = startIndex; i < endIndex; i++) {
            summe += spots[i].y;
          }
          ch2_Vavg = (summe / (endIndex - startIndex)) / 1000000;

          ch2_Vavg_key.currentState?.updateData(ch2_Vavg);
          return;
        }
      }
    }
    ch2_Vavg = 0;
    print("no period found for avg");
    ch2_Vavg_key.currentState?.updateData(ch2_Vavg);
  }

  update_measCH2_Vrms_data() {}

  update_measCH2_Vmax() {
    measCH2_Vmax = !measCH2_Vmax;
    print('CH2 Vmax: $measCH2_Vmax');
    notifyListeners();
  }

  update_measCH2_Vmin() {
    measCH2_Vmin = !measCH2_Vmin;
    print('CH2 Vmin: $measCH2_Vmin');
    notifyListeners();
  }

  update_measCH2_Vpp() {
    measCH2_Vpp = !measCH2_Vpp;
    print('CH2 Vpp: $measCH2_Vpp');
    notifyListeners();
  }

  update_measCH2_Vamp() {
    measCH2_Vamp = !measCH2_Vamp;
    print('CH2 Vamp: $measCH2_Vamp');
    notifyListeners();
  }

  update_measCH2_Vtop() {
    measCH2_Vtop = !measCH2_Vtop;
    print('CH2 Vtop: $measCH2_Vtop');
    notifyListeners();
  }

  update_measCH2_Vbase() {
    measCH2_Vbase = !measCH2_Vbase;
    print('CH2 Vbase: $measCH2_Vbase');
    notifyListeners();
  }

  update_measCH2_Vavg() {
    measCH2_Vavg = !measCH2_Vavg;
    print('CH2 Vavg: $measCH2_Vavg');
    notifyListeners();
  }

  update_measCH2_Vrms() {
    measCH2_Vrms = !measCH2_Vrms;
    print('CH2 Vrms: $measCH2_Vrms');
    notifyListeners();
  }

  updateCH1Data() {
    // Time
    if (measCH1_Period ||
        measCH1_Frequency ||
        measCH1_widthPos ||
        measCH1_widthNeg ||
        measCH1_DutyPos ||
        measCH1_DutyNeg) {
      update_measCH1_Period_data();
    }

    if (measCH1_Frequency) {
      update_measCH1_Frequency_data();
    }
    if (measCH1_widthPos) {
      update_measCH1_Period_data();
      update_measCH1_widthPos_data();
    }
    if (measCH1_widthNeg) {
      update_measCH1_Period_data();
      update_measCH1_widthNeg_data();
    }
    if (measCH1_DutyPos) {
      update_measCH1_dutyPos_data();
    }
    if (measCH1_DutyNeg) {
      update_measCH1_Period_data();
      update_measCH1_dutyNeg_data();
    }

    // Voltage
    if (measCH1_Vmax) {
      update_measCH1_Vmax_data();
    }
    if (measCH1_Vmin) {
      update_measCH1_Vmin_data();
    }
    if (measCH1_Vpp) {
      update_measCH1_Vpp_data();
    }
    if (measCH1_Vamp) {
      update_measCH1_Vamp_data();
    }
    if (measCH1_Vtop) {
      update_measCH1_Vtop_data();
    }
    if (measCH1_Vbase) {
      update_measCH1_Vbase_data();
    }
    if (measCH1_Vavg) {
      update_measCH1_Vavg_data();
    }
    if (measCH1_Vrms) {
      update_measCH1_Vrms_data();
    }
  }

  updateCH2Data() {
    // Time
    if (measCH2_Period) {
      update_measCH2_Period_data();
    }

    if (measCH2_Frequency) {
      update_measCH2_Period_data();
      update_measCH2_Frequency_data();
    }
    if (measCH2_widthPos) {
      update_measCH2_Period_data();
      update_measCH2_widthPos_data();
    }
    if (measCH2_widthNeg) {
      update_measCH2_Period_data();
      update_measCH2_widthNeg_data();
    }
    if (measCH2_DutyPos) {
      update_measCH2_Period_data();
      update_measCH2_dutyPos_data();
    }
    if (measCH2_DutyNeg) {
      update_measCH2_Period_data();
      update_measCH2_dutyNeg_data();
    }

    // Voltage
    if (measCH2_Vmax) {
      update_measCH2_Vmax_data();
    }
    if (measCH2_Vmin) {
      update_measCH2_Vmin_data();
    }
    if (measCH2_Vpp) {
      update_measCH2_Vpp_data();
    }
    if (measCH2_Vamp) {
      update_measCH2_Vamp_data();
    }
    if (measCH2_Vtop) {
      update_measCH2_Vtop_data();
    }
    if (measCH2_Vbase) {
      update_measCH2_Vbase_data();
    }
    if (measCH2_Vavg) {
      update_measCH2_Vavg_data();
    }
    if (measCH2_Vrms) {
      update_measCH2_Vrms_data();
    }
  }

  updateMeasurementData() {
    updateCH1Data();
    updateCH2Data();
  }
}
