import 'package:flutter/material.dart';
import 'package:serial_port_win32/serial_port_win32.dart';

// Interface Layout
Color AppBarBackroundColor = Colors.grey.shade300;
Color MonitorBackroundColor = Colors.grey.shade400;
Color BottomNavigationBarBackgroundColor = Colors.grey.shade400;
Color BodyBackgroundColor = Colors.white;

// Bottom Navigation Bar
Color SelectedItemColor = Colors.deepPurple.shade700;
Color UnselectedItemColor = Colors.grey.shade700;

// Clear
Color clear = Color.fromRGBO(0, 0, 0, 0);

// Channel Class
class Channel {
  Color? channelColor;
  int? channelIndex;
  String? channelName;
  List<double>? channelData = [];
  double? uVperDivision;

  Channel({
    Color? color,
    int? index,
    String? name,
    List<double>? data,
    double? uVperDiv,
  }) {
    channelColor = color;
    channelIndex = index;
    channelName = name;
    channelData = data;
    uVperDivision = uVperDiv;
  }
}

// CH1
Channel channel1 = Channel(
  color: Colors.amber,
  index: 1,
  name: 'CH1',
  uVperDiv: 50,
  data: [],
);

// CH2
Channel channel2 = Channel(
  color: Colors.blue.shade300,
  index: 2,
  name: 'CH2',
  uVperDiv: 50,
  data: [],
);

List<Channel> channels = [channel1, channel2];

String selectedTestChannel = 'Select Channel';

// Channel Parameters
// Color ch1Color = Colors.amber;
// Color ch2Color = Colors.blue.shade300;

// Acitvate Channel Widget
double ActivateChannelFontSize = 35.0;
Color ChannelEnableBackgroundColor = Colors.grey.shade100;
Color ChannelSelected_fontColor = ChannelEnableBackgroundColor; // Colors.black;
double CH_Enable_width = 120;
double CH_Enable_height = 50;
double CH_Enable_sizedBoxHeight = 10.0;
double ActivateChannelFont_Size = 15;

int MonitorSizePercentage = 70;

// Monitoring Chart Widget Parameters
Color ChartBackgroundColor = Colors.black;

// Grid Values
double NOF_xGrids = 12;
double NOF_yGrids = 8;
Color BaseLineColor = Color.fromRGBO(255, 255, 255, 0.75);
Color GridLineColor = Color.fromRGBO(255, 255, 255, 0.35);

// ChangeNotifiere Class

double min_uVperDivision = 1.0;
double max_uVperDivision = 100.0;

double min_uSperDivision = 0.001;
double max_uSperDivision = 10000000.0; // 1000 uS * 1000 mS * 10s

double increment_uSperDivision = 1.0;

class AppState extends ChangeNotifier {
  double _currentsliderValue = 6;
  double timeValue = 10.0;

  double get currentsliderValue => _currentsliderValue;

  String timeValueText = 'test';

  String get timeValue2Text {
    // Time is in ns range
    if (timeValue < 1) {
      timeValueText = '${(timeValue * 1000).toStringAsFixed(3)} ns';
      return timeValueText;
    } else if ((timeValue > 1000) && (timeValue < 1000000)) {
      timeValueText = '${(timeValue / 1000).toStringAsFixed(3)} ms';
      return timeValueText;
    } else if (timeValue > 1000000) {
      timeValueText = '${(timeValue / 1000000).toStringAsFixed(3)} s';
      return timeValueText;
    } else {
      timeValueText = '${(timeValue).toStringAsFixed(3)} µs';
      return timeValueText;
    }
  }

  convertTimeText2Value(String timeText) {
    String timeTextNumbersOnly;

    for (int i = 0; i < timeText.length; i++) {
      if ((timeText[i] == ' ')) {
        timeTextNumbersOnly = timeText.replaceRange(i, timeText.length, '');
        timeValue = double.parse(timeTextNumbersOnly);
        if (timeText[i + 1] == 'n') {
          timeValue *= 0.001;
        } else if ((timeText[i + 1] == 'u') || (timeText[i + 1] == 'µ')) {
          timeValue *= 1;
        } else if (timeText[i + 1] == 'm') {
          timeValue *= 1000;
        } else if (timeText[i + 1] == 's') {
          timeValue *= 1000000;
        }
        print('Data: $timeValue');
        notifyListeners();
        return;
      } else if ((timeText[i] == 'n') ||
          (timeText[i] == 'u') ||
          (timeText[i] == 'm') ||
          (timeText[i] == 's')) {
        timeTextNumbersOnly = timeText.replaceRange(i, timeText.length, '');
        timeValue = double.parse(timeTextNumbersOnly);
        if (timeText[i] == 'n') {
          timeValue *= 0.001;
        } else if ((timeText[i] == 'u') || (timeText[i] == 'µ')) {
          timeValue *= 1;
        } else if (timeText[i] == 'm') {
          timeValue *= 1000;
        } else if (timeText[i] == 's') {
          timeValue *= 1000000;
        }
        print('Data: $timeValue');
        notifyListeners();
        return;
      }
    }
  }

  void updateSliderValue_ch1() {
    _currentsliderValue = channel1.uVperDivision!.clamp(
      min_uVperDivision,
      max_uVperDivision,
    );
    notifyListeners();
  }

  void updateTimeValue(double newValue) {
    timeValue = newValue.clamp(min_uSperDivision, max_uSperDivision);
    notifyListeners();
  }

  void incrementTimeValue(double delta) {
    if (timeValue < 1) {
      timeValue = (timeValue + (delta * 0.001));
      print('ns');
    } else if ((timeValue >= 1) && (timeValue < 1000)) {
      timeValue = (timeValue + (delta * 1)).roundToDouble();
      print('us');
    } else if ((timeValue >= 1000) && (timeValue < 1000000)) {
      timeValue = (timeValue + (delta * 1000)).roundToDouble();
      print('ms');
    } else if ((timeValue >= 1000000)) {
      timeValue = (timeValue + (delta * 1000000)).roundToDouble();
      print('s');
    }
    if (timeValue > max_uSperDivision) {
      timeValue = max_uSperDivision;
    } else if (timeValue < min_uSperDivision) {
      timeValue = min_uSperDivision;
    }
    notifyListeners();
  }

  void incrementTimeValueFine(double delta) {
    if (timeValue < 1) {
      timeValue = (timeValue + (delta * 0.01));
      print('ns');
    } else if ((timeValue >= 1) && (timeValue < 1000)) {
      timeValue = (timeValue + (delta * 0.1));
      print('us');
    } else if ((timeValue >= 1000) && (timeValue < 1000000)) {
      timeValue = (timeValue + (delta * 100));
      print('ms');
    } else if ((timeValue >= 1000000)) {
      timeValue = (timeValue + (delta * 100000));
      print('s');
    }
    if (timeValue > max_uSperDivision) {
      timeValue = max_uSperDivision;
    } else if (timeValue < min_uSperDivision) {
      timeValue = min_uSperDivision;
    }
    notifyListeners();
  }
}

SerialPort? selectedPort;

// Trigger Modes
List<String> triggerMode = ['Auto', 'Single', 'Normal', 'Roll'];
int selecetTriggerModeIndex = 2;

Color selectedTriggerModeBackgroundColor = Colors.grey.shade500;

// Trigger Channel
Channel selectedTriggerChannel = channels[0];

bool fallingTriggerSelected = true;

Color triggerSwitchBackgroundColor = Colors.grey.shade400;
