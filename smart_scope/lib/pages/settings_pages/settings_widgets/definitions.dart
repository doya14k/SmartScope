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
  Color channelColor = Colors.grey;
  int? channelIndex;
  String? channelName;
  List<double>? channelData = [];
  double uVperDivision = 2000.0;
  bool ChannelIs1to1 = true;
  bool channelIsDC = true;
  bool channelIsActive = true;

  Channel({
    Color color = Colors.grey,
    int? index,
    String? name,
    List<double>? data,
    double uVperDiv = 2000.0,
    bool is1to1 = true,
    bool isDC = true,
    bool isActive = true,
  }) {
    channelColor = color;
    channelIndex = index;
    channelName = name;
    channelData = data;
    uVperDivision = uVperDiv;
    ChannelIs1to1 = is1to1;
    channelIsDC = isDC;
    channelIsActive = isActive;
  }
}

// CH1
Channel channel1 = Channel(
  color: Colors.amber,
  index: 1,
  name: 'CH1',
  uVperDiv: 2000,
  data: [],
  is1to1: true,
  isDC: true,
);

// CH2
Channel channel2 = Channel(
  color: Colors.blue.shade300,
  index: 2,
  name: 'CH2',
  uVperDiv: 2000,
  data: [],
  is1to1: true,
  isDC: true,
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
double max_uVperDivision = 100000000.0;

double min_uSperDivision = 0.001;
double max_uSperDivision = 10000000.0; // 1000 uS * 1000 mS * 10s

double increment_uSperDivision = 1.0;

double max_uVLevelOffset = 100000000;
double min_uVLevelOffset = -max_uVLevelOffset;

class AppState extends ChangeNotifier {
  double _ch1_uVoltageValue = channel1.uVperDivision; // 2000.0;
  double _ch2_uVoltageValue = channel2.uVperDivision; //2000.0;
  double timeValue = 2.0;

  double ch1_uVoltageLevelOffset = 0.0;
  double ch2_uVoltageLevelOffset = 0.0;

  double get ch1_uVoltageValue {
    return _ch1_uVoltageValue;
  }

  double get ch2_uVoltageValue {
    return _ch2_uVoltageValue;
  }

  String timeValueText = '';

  String get timeValue2Text {
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

  String get voltageValueTextCH1 {
    if (_ch1_uVoltageValue < 1000) {
      return '${(_ch1_uVoltageValue).toStringAsFixed(2)} µV';
    } else if ((_ch1_uVoltageValue < 1000000) &&
        (_ch1_uVoltageValue < 1000000)) {
      return '${(_ch1_uVoltageValue / 1000).toStringAsFixed(2)} mV';
    } else if (_ch1_uVoltageValue >= 1000000) {
      return '${(_ch1_uVoltageValue / 1000000).toStringAsFixed(2)} V';
    } else {
      return '${(_ch1_uVoltageValue / 1000000).toStringAsFixed(2)} V';
    }
  }

  String get voltageValueTextCH2 {
    if (_ch2_uVoltageValue < 1000) {
      return '${(_ch2_uVoltageValue).toStringAsFixed(2)} µV';
    } else if ((_ch2_uVoltageValue < 1000000) &&
        (_ch2_uVoltageValue < 1000000)) {
      return '${(_ch2_uVoltageValue / 1000).toStringAsFixed(2)} mV';
    } else if (_ch2_uVoltageValue >= 1000000) {
      return '${(_ch2_uVoltageValue / 1000000).toStringAsFixed(2)} V';
    } else {
      return '${(_ch2_uVoltageValue / 1000000).toStringAsFixed(2)} V';
    }
  }

  convertVoltageText2ValueCH1(String voltagText) {
    String voltageTextNumbersOnly;

    for (int i = 0; i < voltagText.length; i++) {
      if ((voltagText[i] == ' ')) {
        voltageTextNumbersOnly = voltagText.replaceRange(
          i,
          voltagText.length,
          '',
        );
        _ch1_uVoltageValue = double.parse(voltageTextNumbersOnly);
        if ((voltagText[i + 1] == 'u') || (voltagText[i + 1] == 'µ')) {
          _ch1_uVoltageValue *= 1;
        } else if (voltagText[i + 1] == 'm') {
          _ch1_uVoltageValue *= 1000;
        } else if ((voltagText[i + 1] == 'v') || (voltagText[i + 1] == 'V')) {
          _ch1_uVoltageValue *= 1000000;
        }
        print('Data: $_ch1_uVoltageValue');
        notifyListeners();
        return;
      } else if ((voltagText[i] == 'u') ||
          (voltagText[i] == 'm') ||
          (voltagText[i] == 'v') ||
          (voltagText[i] == 'V')) {
        voltageTextNumbersOnly = voltagText.replaceRange(
          i,
          voltagText.length,
          '',
        );
        _ch1_uVoltageValue = double.parse(voltageTextNumbersOnly);
        if ((voltagText[i] == 'u') || (voltagText[i] == 'µ')) {
          _ch1_uVoltageValue *= 1;
        } else if (voltagText[i] == 'm') {
          _ch1_uVoltageValue *= 1000;
        } else if ((voltagText[i] == 'v') || (voltagText[i] == 'V')) {
          _ch1_uVoltageValue *= 1000000;
        }
        print('Data: $_ch1_uVoltageValue');
        notifyListeners();
        return;
      }
    }
  }

  convertVoltageText2ValueCH2(String voltagText) {
    String voltageTextNumbersOnly;

    for (int i = 0; i < voltagText.length; i++) {
      if ((voltagText[i] == ' ')) {
        voltageTextNumbersOnly = voltagText.replaceRange(
          i,
          voltagText.length,
          '',
        );
        _ch2_uVoltageValue = double.parse(voltageTextNumbersOnly);
        if ((voltagText[i + 1] == 'u') || (voltagText[i + 1] == 'µ')) {
          _ch2_uVoltageValue *= 1;
        } else if (voltagText[i + 1] == 'm') {
          _ch2_uVoltageValue *= 1000;
        } else if ((voltagText[i + 1] == 'v') || (voltagText[i + 1] == 'V')) {
          _ch2_uVoltageValue *= 1000000;
        }
        print('Data: $_ch2_uVoltageValue');
        notifyListeners();
        return;
      } else if ((voltagText[i] == 'u') ||
          (voltagText[i] == 'm') ||
          (voltagText[i] == 'v') ||
          (voltagText[i] == 'V')) {
        voltageTextNumbersOnly = voltagText.replaceRange(
          i,
          voltagText.length,
          '',
        );
        _ch2_uVoltageValue = double.parse(voltageTextNumbersOnly);
        if ((voltagText[i] == 'u') || (voltagText[i] == 'µ')) {
          _ch2_uVoltageValue *= 1;
        } else if (voltagText[i] == 'm') {
          _ch2_uVoltageValue *= 1000;
        } else if ((voltagText[i] == 'v') || (voltagText[i] == 'V')) {
          _ch2_uVoltageValue *= 1000000;
        }
        print('Data: $_ch2_uVoltageValue');
        notifyListeners();
        return;
      }
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

  void updateSliderValue_ch1(double newValue) {
    channel1.uVperDivision = newValue;
    _ch1_uVoltageValue = channel1.uVperDivision!.clamp(
      min_uVperDivision,
      max_uVperDivision,
    );
    notifyListeners();
  }

  void updateSliderValue_ch2(double newValue) {
    channel2.uVperDivision = newValue;
    _ch2_uVoltageValue = channel2.uVperDivision!.clamp(
      min_uVperDivision,
      max_uVperDivision,
    );
    notifyListeners();
  }

  void incrementVoltageValueCH1(double delta) {
    if (_ch1_uVoltageValue < 1000) {
      _ch1_uVoltageValue = _ch1_uVoltageValue + (delta * 1);
    } else if (_ch1_uVoltageValue < 1000000) {
      _ch1_uVoltageValue = _ch1_uVoltageValue + (delta * 1000);
    } else if (_ch1_uVoltageValue >= 1000000) {
      _ch1_uVoltageValue = _ch1_uVoltageValue + (delta * 1000000);
    }

    if (_ch1_uVoltageValue > max_uVperDivision) {
      _ch1_uVoltageValue = max_uVperDivision;
    } else if (_ch1_uVoltageValue < min_uVperDivision) {
      _ch1_uVoltageValue = min_uVperDivision;
    }
    notifyListeners();
  }

  void incrementVoltageValueCH2(double delta) {
    if (_ch2_uVoltageValue < 1000) {
      _ch2_uVoltageValue = _ch2_uVoltageValue + (delta * 1);
    } else if (_ch2_uVoltageValue < 1000000) {
      _ch2_uVoltageValue = _ch2_uVoltageValue + (delta * 1000);
    } else if (_ch2_uVoltageValue >= 1000000) {
      _ch2_uVoltageValue = _ch2_uVoltageValue + (delta * 1000000);
    }

    if (_ch2_uVoltageValue > max_uVperDivision) {
      _ch2_uVoltageValue = max_uVperDivision;
    } else if (_ch2_uVoltageValue < min_uVperDivision) {
      _ch2_uVoltageValue = min_uVperDivision;
    }
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

  bool get isCH1Active {
    return channel1.channelIsActive;
  }

  bool get isCH2Active {
    return channel2.channelIsActive;
  }

  void updateListeners() {
    notifyListeners();
  }

  void ch1_pressed() {
    if (channel1.channelIsActive) {
      channel1.channelIsActive = false;
      print("CH1_Disabled");
    } else {
      channel1.channelIsActive = true;
      print("CH1_Activated");
    }
    notifyListeners();
  }

  void ch2_pressed() {
    if (channel2.channelIsActive) {
      channel2.channelIsActive = false;
      print("CH2_Disabled");
    } else {
      channel2.channelIsActive = true;
      print("CH2_Activated");
    }
    notifyListeners();
  }

  void updatedCH1_LevelOffset(double newValue) {
    ch1_uVoltageLevelOffset = newValue;
    if (ch1_uVoltageLevelOffset > max_uVLevelOffset) {
      ch1_uVoltageLevelOffset = max_uVLevelOffset;
    } else if (ch1_uVoltageLevelOffset <= min_uVLevelOffset) {
      ch1_uVoltageLevelOffset = min_uVLevelOffset;
    }
    notifyListeners();
  }

  void updatedCH2_LevelOffset(double newValue) {
    ch2_uVoltageLevelOffset = newValue;
    if (ch2_uVoltageLevelOffset > (max_uVLevelOffset)) {
      ch2_uVoltageLevelOffset = max_uVLevelOffset;
    } else if (ch2_uVoltageLevelOffset <= min_uVLevelOffset) {
      ch2_uVoltageLevelOffset = min_uVLevelOffset;
    }
    notifyListeners();
  }

  void incrementCH1_LevelOffset(double delta) {
    ch1_uVoltageLevelOffset += ((channel1.uVperDivision / 20) * delta);
    if (ch1_uVoltageLevelOffset > max_uVLevelOffset) {
      ch1_uVoltageLevelOffset = max_uVLevelOffset;
    } else if (ch1_uVoltageLevelOffset <= min_uVLevelOffset) {
      ch1_uVoltageLevelOffset = min_uVLevelOffset;
    }
    notifyListeners();
  }

  void incrementCH2_LevelOffset(double delta) {
    ch2_uVoltageLevelOffset += ((channel2.uVperDivision / 20) * delta);
    if (ch2_uVoltageLevelOffset > (max_uVLevelOffset)) {
      ch2_uVoltageLevelOffset = (max_uVLevelOffset);
    } else if (ch2_uVoltageLevelOffset <= min_uVLevelOffset) {
      ch2_uVoltageLevelOffset = min_uVLevelOffset;
    }
    notifyListeners();
  }

  convertCH2OffsetText2Value(String offsetText) {
    String offsetTextNumbersOnly;
    double sign = 1;

    if (offsetText[0] == '-') {
      sign = -1;
      offsetText = offsetText.replaceRange(0, 1, '');
    }

    for (int i = 0; i < offsetText.length; i++) {
      if ((offsetText[i] == ' ')) {
        offsetTextNumbersOnly = offsetText.replaceRange(
          i,
          offsetText.length,
          '',
        );
        ch2_uVoltageLevelOffset = sign * double.parse(offsetTextNumbersOnly);
        if (offsetText[i + 1] == 'n') {
          ch2_uVoltageLevelOffset *= 0.001;
        } else if ((offsetText[i + 1] == 'u') || (offsetText[i + 1] == 'µ')) {
          ch2_uVoltageLevelOffset *= 1;
        } else if (offsetText[i + 1] == 'm') {
          ch2_uVoltageLevelOffset *= 1000;
        } else if (offsetText[i + 1] == 's') {
          ch2_uVoltageLevelOffset *= 1000000;
        }
        print('Data: $ch2_uVoltageLevelOffset');
        notifyListeners();
        return;
      } else if ((offsetText[i] == 'n') ||
          (offsetText[i] == 'u') ||
          (offsetText[i] == 'm') ||
          (offsetText[i] == 's')) {
        offsetTextNumbersOnly = offsetText.replaceRange(
          i,
          offsetText.length,
          '',
        );
        ch2_uVoltageLevelOffset = sign * double.parse(offsetTextNumbersOnly);
        if (offsetText[i] == 'n') {
          ch2_uVoltageLevelOffset *= 0.001;
        } else if ((offsetText[i] == 'u') || (offsetText[i] == 'µ')) {
          ch2_uVoltageLevelOffset *= 1;
        } else if (offsetText[i] == 'm') {
          ch2_uVoltageLevelOffset *= 1000;
        } else if (offsetText[i] == 's') {
          ch2_uVoltageLevelOffset *= 1000000;
        }
        print('Data: $ch2_uVoltageLevelOffset');
        notifyListeners();
        return;
      }
    }
  }

  convertCH1OffsetText2Value(String offsetText) {
    String offsetTextNumbersOnly;
    double sign = 1;

    if (offsetText[0] == '-') {
      sign = -1;
      offsetText = offsetText.replaceRange(0, 1, '');
    }

    for (int i = 0; i < offsetText.length; i++) {
      if ((offsetText[i] == ' ')) {
        offsetTextNumbersOnly = offsetText.replaceRange(
          i,
          offsetText.length,
          '',
        );
        ch1_uVoltageLevelOffset = sign * double.parse(offsetTextNumbersOnly);
        if (offsetText[i + 1] == 'n') {
          ch1_uVoltageLevelOffset *= 0.001;
        } else if ((offsetText[i + 1] == 'u') || (offsetText[i + 1] == 'µ')) {
          ch1_uVoltageLevelOffset *= 1;
        } else if (offsetText[i + 1] == 'm') {
          ch1_uVoltageLevelOffset *= 1000;
        } else if (offsetText[i + 1] == 's') {
          ch1_uVoltageLevelOffset *= 1000000;
        }
        print('Data: $ch1_uVoltageLevelOffset');
        notifyListeners();
        return;
      } else if ((offsetText[i] == 'n') ||
          (offsetText[i] == 'u') ||
          (offsetText[i] == 'm') ||
          (offsetText[i] == 's')) {
        offsetTextNumbersOnly = offsetText.replaceRange(
          i,
          offsetText.length,
          '',
        );
        ch1_uVoltageLevelOffset = sign * double.parse(offsetTextNumbersOnly);
        if (offsetText[i] == 'n') {
          ch1_uVoltageLevelOffset *= 0.001;
        } else if ((offsetText[i] == 'u') || (offsetText[i] == 'µ')) {
          ch1_uVoltageLevelOffset *= 1;
        } else if (offsetText[i] == 'm') {
          ch1_uVoltageLevelOffset *= 1000;
        } else if (offsetText[i] == 's') {
          ch1_uVoltageLevelOffset *= 1000000;
        }
        print('Data: $ch1_uVoltageLevelOffset');
        notifyListeners();
        return;
      }
    }
  }

  String get offsetValueTextCH1 {
    if ((ch1_uVoltageLevelOffset.abs() < 1000) &&
        (ch1_uVoltageLevelOffset.abs() >= 0.0)) {
      return '${(ch1_uVoltageLevelOffset).toStringAsFixed(2)} µV';
    } else if ((ch1_uVoltageLevelOffset.abs() >= 1000) &&
        (ch1_uVoltageLevelOffset.abs() < 1000000)) {
      return '${(ch1_uVoltageLevelOffset / 1000).toStringAsFixed(2)} mV';
    } else {
      return '${(ch1_uVoltageLevelOffset / 1000000).toStringAsFixed(2)} V';
    }
  }

  String get offsetValueTextCH2 {
    if ((ch2_uVoltageLevelOffset.abs() < 1000) &&
        (ch2_uVoltageLevelOffset.abs() >= 0.0)) {
      return '${(ch2_uVoltageLevelOffset).toStringAsFixed(2)} µV';
    } else if ((ch2_uVoltageLevelOffset.abs() >= 1000) &&
        (ch2_uVoltageLevelOffset.abs() < 1000000)) {
      return '${(ch2_uVoltageLevelOffset / 1000).toStringAsFixed(2)} mV';
    } else {
      return '${(ch2_uVoltageLevelOffset / 1000000).toStringAsFixed(2)} V';
    }
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

// Vertical scaler settings
// Tastkopf settings
Color VerticalScalerBackgroundColor = Colors.grey.shade100;

List<String> tastkopfModes = ['1:1', '10:1'];

// DC/AC Coupling setttings
List<String> couplingModes = ['DC', 'AC'];

// Horizontal scaler
Color HorizontalScalerBackgroundColor = Colors.grey.shade100;
