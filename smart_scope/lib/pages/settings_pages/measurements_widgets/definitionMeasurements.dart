import 'package:flutter/material.dart';

// Channel Parameters
Color channel1_lightBackgroundColor = Colors.amber.shade200;
Color channel2_lightBackgroundColor = Colors.blue.shade100;
int selectedMeasurementSettingsChannel = 0;

Color clear2 = Colors.transparent;
Color measurementSelectedBackground = Colors.grey.shade400;
Color measurementnotSelectedBackground = Colors.grey.shade50;

double outlinedButtonWidth = 150;
double outlinedButtonHeight = 60;

class MeasurementsChanges extends ChangeNotifier {
  bool measCH1_Period = false;
  bool measCH1_Frequency = false;
  bool measCH1_widthPos = false;
  bool measCH1_widthNeg = false;
  bool measCH1_DutyPos = false;
  bool measCH1_DutyNeg = false;

  update_measCH1_Period() {
    measCH1_Period = !measCH1_Period;
    print('CH1 Period: ${measCH1_Period}');
    notifyListeners();
  }

  update_measCH1_Frequency() {
    measCH1_Frequency = !measCH1_Frequency;
    print('CH1 Frequency: ${measCH1_Frequency}');
    notifyListeners();
  }

  update_measCH1_widthPos() {
    measCH1_widthPos = !measCH1_widthPos;
    print('CH1 Width+: ${measCH1_widthPos}');
    notifyListeners();
  }

  update_measCH1_widthNeg() {
    measCH1_widthNeg = !measCH1_widthNeg;
    print('CH1 Width-: ${measCH1_widthNeg}');
    notifyListeners();
  }

  update_measCH1_dutyPos() {
    measCH1_DutyPos = !measCH1_DutyPos;
    print('CH1 Duty-Cycle +: ${measCH1_DutyPos}');
    notifyListeners();
  }

  update_measCH1_dutyNeg() {
    measCH1_DutyNeg = !measCH1_DutyNeg;
    print('CH1 Duty-Cycle -: ${measCH1_DutyNeg}');
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

  update_measCH1_Vmax() {
    measCH1_Vmax = !measCH1_Vmax;
    print('CH1 Vmax: ${measCH1_Vmax}');
    notifyListeners();
  }

  update_measCH1_Vmin() {
    measCH1_Vmin = !measCH1_Vmin;
    print('CH1 Vmin: ${measCH1_Vmin}');
    notifyListeners();
  }

  update_measCH1_Vpp() {
    measCH1_Vpp = !measCH1_Vpp;
    print('CH1 Vpp: ${measCH1_Vpp}');
    notifyListeners();
  }

  update_measCH1_Vamp() {
    measCH1_Vamp = !measCH1_Vamp;
    print('CH1 Vamp: ${measCH1_Vamp}');
    notifyListeners();
  }

  update_measCH1_Vtop() {
    measCH1_Vtop = !measCH1_Vtop;
    print('CH1 Vtop: ${measCH1_Vtop}');
    notifyListeners();
  }

  update_measCH1_Vbase() {
    measCH1_Vbase = !measCH1_Vbase;
    print('CH1 Vbase: ${measCH1_Vbase}');
    notifyListeners();
  }

  update_measCH1_Vavg() {
    measCH1_Vavg = !measCH1_Vavg;
    print('CH1 Vavg: ${measCH1_Vavg}');
    notifyListeners();
  }

  update_measCH1_Vrms() {
    measCH1_Vrms = !measCH1_Vrms;
    print('CH1 Vrms: ${measCH1_Vrms}');
    notifyListeners();
  }

  bool measCH2_Period = false;
  bool measCH2_Frequency = false;
  bool measCH2_widthPos = false;
  bool measCH2_widthNeg = false;
  bool measCH2_DutyPos = false;
  bool measCH2_DutyNeg = false;

  update_measCH2_Period() {
    measCH2_Period = !measCH2_Period;
    print('CH2 Period: ${measCH2_Period}');
    notifyListeners();
  }

  update_measCH2_Frequency() {
    measCH2_Frequency = !measCH2_Frequency;
    print('CH2 Frequency: ${measCH2_Frequency}');
    notifyListeners();
  }

  update_measCH2_widthPos() {
    measCH2_widthPos = !measCH2_widthPos;
    print('CH2 Width+: ${measCH2_widthPos}');
    notifyListeners();
  }

  update_measCH2_widthNeg() {
    measCH2_widthNeg = !measCH2_widthNeg;
    print('CH2 Width-: ${measCH2_widthNeg}');
    notifyListeners();
  }

  update_measCH2_dutyPos() {
    measCH2_DutyPos = !measCH2_DutyPos;
    print('CH2 Duty-Cycle +: ${measCH2_DutyPos}');
    notifyListeners();
  }

  update_measCH2_dutyNeg() {
    measCH2_DutyNeg = !measCH2_DutyNeg;
    print('CH2 Duty-Cycle -: ${measCH2_DutyNeg}');
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

  update_measCH2_Vmax() {
    measCH2_Vmax = !measCH2_Vmax;
    print('CH2 Vmax: ${measCH2_Vmax}');
    notifyListeners();
  }

  update_measCH2_Vmin() {
    measCH2_Vmin = !measCH2_Vmin;
    print('CH2 Vmin: ${measCH2_Vmin}');
    notifyListeners();
  }

  update_measCH2_Vpp() {
    measCH2_Vpp = !measCH2_Vpp;
    print('CH2 Vpp: ${measCH2_Vpp}');
    notifyListeners();
  }

  update_measCH2_Vamp() {
    measCH2_Vamp = !measCH2_Vamp;
    print('CH2 Vamp: ${measCH2_Vamp}');
    notifyListeners();
  }

  update_measCH2_Vtop() {
    measCH2_Vtop = !measCH2_Vtop;
    print('CH2 Vtop: ${measCH2_Vtop}');
    notifyListeners();
  }

  update_measCH2_Vbase() {
    measCH2_Vbase = !measCH2_Vbase;
    print('CH2 Vbase: ${measCH2_Vbase}');
    notifyListeners();
  }

  update_measCH2_Vavg() {
    measCH2_Vavg = !measCH2_Vavg;
    print('CH2 Vavg: ${measCH2_Vavg}');
    notifyListeners();
  }

  update_measCH2_Vrms() {
    measCH2_Vrms = !measCH2_Vrms;
    print('CH2 Vrms: ${measCH2_Vrms}');
    notifyListeners();
  }
}
