import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:smart_scope/usb_reader.dart';

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

  // Data Variables Time
  double ch1_Period = 0;
  double ch1_Frequency = 0;
  double ch1_widthPos = 0;
  double ch1_widthNeg = 0;
  double ch1_DutyPos = 0;
  double ch1_DutyhNeg = 0;
  double ch2_Period = 0;
  double ch2_Frequency = 0;
  double ch2_widthPos = 0;
  double ch2_widthNeg = 0;
  double ch2_DutyPos = 0;
  double ch2_DutyhNeg = 0;

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
    List<double> voltageValues = usbProvider.ch1_data.map((p) => p.y).toList();
    List<double> timeValues = usbProvider.ch1_data.map((p) => p.x).toList();

    double lastVoltageComparingValue = voltageValues[0];
    bool risingSignal = true;

    // Alle Einträge der List durchgehen
    for (
      int comparing_index = 1;
      comparing_index < voltageValues.length;
      comparing_index++
    ) {
      print('Compare ${timeValues[comparing_index]}');

      if ((voltageValues[comparing_index] - (lastVoltageComparingValue)) >= 0) {
        risingSignal = false;
      }

      for (
        int searching_index = (comparing_index);
        searching_index < voltageValues.length;
        searching_index++
      ) {
        double lastSearchingVoltage = voltageValues[searching_index - 1];
        double currentSearchingVoltage = voltageValues[searching_index];
        print('Search ${lastSearchingVoltage}');

        if (risingSignal) {
          // the comparing voltage is in between the searching voltage

          if ((currentSearchingVoltage < voltageValues[comparing_index - 1]) &&
              (lastSearchingVoltage >= voltageValues[comparing_index - 1])) {
            // oldTime index -> comparing_index - 1
            // newTime index -> searching_index - 1
            // delta Time = timeValue[searching] - timeValue[comparing]

            print('Found ${lastSearchingVoltage}');

            ch1_Period =
                ((timeValues[searching_index - 1] -
                        timeValues[comparing_index - 1]) /
                    1000000);

            ch1_Period_key.currentState?.updateData(ch1_Period);
            return;
          }
        } else {
          if ((currentSearchingVoltage >= voltageValues[comparing_index - 1]) &&
              (lastSearchingVoltage < voltageValues[comparing_index - 1])) {
            // oldTime index -> comparing_index - 1
            // newTime index -> searching_index - 1
            // delta Time = timeValue[searching] - timeValue[comparing]
            print('Found ${lastSearchingVoltage}');

            ch1_Period =
                ((timeValues[searching_index - 1] -
                        timeValues[comparing_index - 1]) /
                    1000000);

            ch1_Period_key.currentState?.updateData(ch1_Period);
            return;
          }
        }
      }

      lastVoltageComparingValue = voltageValues[comparing_index];
    }

    print("no periodic signal found");
    ch1_Period_key.currentState?.updateData(1);
  }

  update_measCH1_Frequency_data() {
    if (ch1_Period != 0) {
      ch1_Frequency = 1 / ch1_Period;
    } else {
      ch1_Frequency = 0;
    }
    ch1_Frequency_key.currentState?.updateData(ch1_Frequency);
  }

  update_measCH1_widthPos_data() {}
  update_measCH1_widthNeg_data() {}
  update_measCH1_dutyPos_data() {}
  update_measCH1_dutyNeg_data() {}

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

  update_measCH1_Vtop_data() {}
  update_measCH1_Vbase_data() {}
  update_measCH1_Vavg_data() {}
  update_measCH1_Vrms_data() {}

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

  update_measCH2_Period_data() {}

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
  update_measCH2_dutyPos_data() {}
  update_measCH2_dutyNeg_data() {}

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
  update_measCH2_Vavg_data() {}
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
    if (measCH1_Period) {
      update_measCH1_Period_data();
    }

    if (measCH1_Frequency) {
      update_measCH1_Period_data();
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
      update_measCH1_Period_data();
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
