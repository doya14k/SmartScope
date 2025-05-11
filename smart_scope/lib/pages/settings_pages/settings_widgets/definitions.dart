import 'package:flutter/material.dart';
import 'package:serial_port_win32/serial_port_win32.dart';
import 'package:smart_scope/usb_reader.dart';

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

// Trigger Color
Color triggerColor = Colors.deepOrange;

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
  uVperDiv: 500000,
  data: [],
  is1to1: true,
  isDC: true,
);

// CH2
Channel channel2 = Channel(
  color: Colors.blue.shade300,
  index: 2,
  name: 'CH2',
  uVperDiv: 500000,
  data: [],
  is1to1: true,
  isDC: true,
);

List<Channel> channels = [channel1, channel2];

String selectedTestChannel = 'Select Channel';

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

double max_uVLevelOffset = max_uVperDivision * NOF_yGrids / 2;
double min_uVLevelOffset = -max_uVLevelOffset;

// Trigger Offset Horizontal
double max_TriggerHorizontalOffset = max_uSperDivision * NOF_xGrids / 2;
double min_TriggerHorizontalOffset = -max_TriggerHorizontalOffset;

// Trigger Offset vertical
double max_TriggerVerticalOffset = max_uVperDivision * NOF_yGrids / 2;
double min_TriggerVerticalOffset = -max_TriggerVerticalOffset;

class AppState extends ChangeNotifier {
  late UsbProvider usbProvider;

  void setUsbProvider(UsbProvider newAppState) {
    usbProvider = newAppState;
  }

  double _ch1_uVoltageValue = channel1.uVperDivision; // 2000.0;
  double _ch2_uVoltageValue = channel2.uVperDivision; //2000.0;
  double timeValue = 2.0;

  double triggerHorizontalOffset = 0.0;
  double triggerVerticalOffset = 1500000.0;

  double ch1_uVoltageLevelOffset = 0.0;
  double ch2_uVoltageLevelOffset = 0.0;

  double maxGraphTimeValue = 2.0 * (NOF_xGrids / 2);
  double minGraphTimeValue = -2.0 * (NOF_xGrids / 2);

  double maxGraphVoltageValueCH1 = channel1.uVperDivision * (NOF_yGrids / 2);
  double minGraphVoltageValueCH1 = -channel1.uVperDivision * (NOF_yGrids / 2);

  double maxGraphVoltageValueCH2 = channel2.uVperDivision * (NOF_yGrids / 2);
  double minGraphVoltageValueCH2 = -channel2.uVperDivision * (NOF_yGrids / 2);

  bool get channel1IsTriggered =>
      ((channel1.channelIsActive) && selectedTriggerChannel == channels[0]);
  bool get channel2IsTriggered =>
      ((channel2.channelIsActive) && selectedTriggerChannel == channels[1]);

  updateTriggeredChannel(var newTriggerChannel) {
    selectedTriggerChannel = newTriggerChannel;
    notifyListeners();
  }

  updateGraphTimeValue(double timeOffsetValue) {
    maxGraphTimeValue = (timeValue * (NOF_xGrids / 2) + timeOffsetValue);
    minGraphTimeValue = (-timeValue * (NOF_xGrids / 2) + timeOffsetValue);
    notifyListeners();
  }

  updateGraphVoltageValue() {
    channel1.uVperDivision = _ch1_uVoltageValue;
    channel2.uVperDivision = _ch2_uVoltageValue;

    maxGraphVoltageValueCH1 =
        (channel1.uVperDivision * (NOF_yGrids / 2)) - ch1_uVoltageLevelOffset;
    minGraphVoltageValueCH1 =
        -(channel1.uVperDivision * (NOF_yGrids / 2)) - ch1_uVoltageLevelOffset;

    maxGraphVoltageValueCH2 =
        (channel2.uVperDivision * (NOF_yGrids / 2)) - ch2_uVoltageLevelOffset;
    minGraphVoltageValueCH2 =
        -(channel2.uVperDivision * (NOF_yGrids / 2)) - ch2_uVoltageLevelOffset;
    notifyListeners();
  }

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
    } else if ((timeValue >= 1000) && (timeValue < 1000000)) {
      timeValueText = '${(timeValue / 1000).toStringAsFixed(3)} ms';
      return timeValueText;
    } else if (timeValue >= 1000000) {
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
        updateGraphVoltageValue();
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
        updateGraphVoltageValue();
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
        updateGraphVoltageValue();
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
        updateGraphVoltageValue();
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
        updateGraphTimeValue(
          usbProvider.triggeredTime - triggerHorizontalOffset,
        );

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
        updateGraphTimeValue(
          usbProvider.triggeredTime - triggerHorizontalOffset,
        );

        notifyListeners();
        return;
      }
    }
  }

  void updateSliderValue_ch1(double newValue) {
    channel1.uVperDivision = newValue;
    _ch1_uVoltageValue = channel1.uVperDivision.clamp(
      min_uVperDivision,
      max_uVperDivision,
    );
    channel1.uVperDivision = _ch1_uVoltageValue;
    updateGraphVoltageValue();
    notifyListeners();
  }

  void updateSliderValue_ch2(double newValue) {
    channel2.uVperDivision = newValue;
    _ch2_uVoltageValue = channel2.uVperDivision.clamp(
      min_uVperDivision,
      max_uVperDivision,
    );
    channel2.uVperDivision = _ch2_uVoltageValue;
    updateGraphVoltageValue();
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
    channel1.uVperDivision = _ch1_uVoltageValue;
    updateGraphVoltageValue();
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
    channel2.uVperDivision = _ch2_uVoltageValue;
    updateGraphVoltageValue();
    notifyListeners();
  }

  void updateTimeValue(double newValue) {
    timeValue = newValue.clamp(min_uSperDivision, max_uSperDivision);
    updateGraphTimeValue(usbProvider.triggeredTime - triggerHorizontalOffset);
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
    updateGraphTimeValue(usbProvider.triggeredTime - triggerHorizontalOffset);
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
      selectedTriggerChannel = channels[0];
      updateTriggeredChannel(selectedTriggerChannel);
      print("CH2_Disabled");
    } else {
      channel2.channelIsActive = true;
      selectedTriggerChannel = channels[1];
      updateTriggeredChannel(selectedTriggerChannel);
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
    updateGraphVoltageValue();
    notifyListeners();
  }

  void updatedCH2_LevelOffset(double newValue) {
    ch2_uVoltageLevelOffset = newValue;
    if (ch2_uVoltageLevelOffset > (max_uVLevelOffset)) {
      ch2_uVoltageLevelOffset = max_uVLevelOffset;
    } else if (ch2_uVoltageLevelOffset <= min_uVLevelOffset) {
      ch2_uVoltageLevelOffset = min_uVLevelOffset;
    }
    updateGraphVoltageValue();
    notifyListeners();
  }

  void incrementCH1_LevelOffset(double delta) {
    ch1_uVoltageLevelOffset += ((channel1.uVperDivision / 20) * delta);
    if (ch1_uVoltageLevelOffset > max_uVLevelOffset) {
      ch1_uVoltageLevelOffset = max_uVLevelOffset;
    } else if (ch1_uVoltageLevelOffset <= min_uVLevelOffset) {
      ch1_uVoltageLevelOffset = min_uVLevelOffset;
    }
    updateGraphVoltageValue();
    notifyListeners();
  }

  void incrementCH2_LevelOffset(double delta) {
    ch2_uVoltageLevelOffset += ((channel2.uVperDivision / 20) * delta);
    if (ch2_uVoltageLevelOffset > (max_uVLevelOffset)) {
      ch2_uVoltageLevelOffset = (max_uVLevelOffset);
    } else if (ch2_uVoltageLevelOffset <= min_uVLevelOffset) {
      ch2_uVoltageLevelOffset = min_uVLevelOffset;
    }
    updateGraphVoltageValue();
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
        } else if ((offsetText[i + 1] == 'v') || (offsetText[i + 1] == 'V')) {
          ch2_uVoltageLevelOffset *= 1000000;
        }
        print('Data: $ch2_uVoltageLevelOffset');
        updateGraphVoltageValue();
        notifyListeners();
        return;
      } else if ((offsetText[i] == 'n') ||
          (offsetText[i] == 'u') ||
          (offsetText[i] == 'm') ||
          ((offsetText[i] == 'v') || (offsetText[i] == 'V'))) {
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
        } else if ((offsetText[i] == 'v') || (offsetText[i] == 'V')) {
          ch2_uVoltageLevelOffset *= 1000000;
        }
        print('Data: $ch2_uVoltageLevelOffset');
        updateGraphVoltageValue();
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
        } else if ((offsetText[i + 1] == 'v') || (offsetText[i + 1] == 'V')) {
          ch1_uVoltageLevelOffset *= 1000000;
        }
        print('Data: $ch1_uVoltageLevelOffset');
        updateGraphVoltageValue();
        notifyListeners();
        return;
      } else if ((offsetText[i] == 'n') ||
          (offsetText[i] == 'u') ||
          (offsetText[i] == 'm') ||
          ((offsetText[i] == 'v') || (offsetText[i] == 'V'))) {
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
        } else if ((offsetText[i] == 'v') || (offsetText[i] == 'V')) {
          ch1_uVoltageLevelOffset *= 1000000;
        }
        print('Data: $ch1_uVoltageLevelOffset');
        updateGraphVoltageValue();
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

  void updateTriggerHorizontalOffset(double newValue) {
    triggerHorizontalOffset = newValue;
    if (triggerHorizontalOffset > (max_TriggerHorizontalOffset)) {
      triggerHorizontalOffset = max_TriggerHorizontalOffset;
    } else if (triggerHorizontalOffset <= min_TriggerHorizontalOffset) {
      triggerHorizontalOffset = min_TriggerHorizontalOffset;
    }
    updateGraphTimeValue(usbProvider.triggeredTime - triggerHorizontalOffset);
    notifyListeners();
  }

  void incrementTriggerHorizontalOffset(double delta) {
    triggerHorizontalOffset += ((timeValue / 20) * delta);
    if (triggerHorizontalOffset > max_TriggerHorizontalOffset) {
      triggerHorizontalOffset = max_TriggerHorizontalOffset;
    } else if (triggerHorizontalOffset <= min_TriggerHorizontalOffset) {
      triggerHorizontalOffset = min_TriggerHorizontalOffset;
    }
    notifyListeners();
  }

  convertTriggerHorizontalOffsetText2Value(String offsetText) {
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
        triggerHorizontalOffset = sign * double.parse(offsetTextNumbersOnly);
        if (offsetText[i + 1] == 'n') {
          triggerHorizontalOffset *= 0.001;
        } else if ((offsetText[i + 1] == 'u') || (offsetText[i + 1] == 'µ')) {
          triggerHorizontalOffset *= 1;
        } else if (offsetText[i + 1] == 'm') {
          triggerHorizontalOffset *= 1000;
        } else if (offsetText[i + 1] == 's') {
          triggerHorizontalOffset *= 1000000;
        }
        print('Data1: $triggerHorizontalOffset');
        notifyListeners();
        updateGraphTimeValue(
          usbProvider.triggeredTime - triggerHorizontalOffset,
        );
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
        triggerHorizontalOffset = sign * double.parse(offsetTextNumbersOnly);
        if (offsetText[i] == 'n') {
          triggerHorizontalOffset *= 0.001;
        } else if ((offsetText[i] == 'u') || (offsetText[i] == 'µ')) {
          triggerHorizontalOffset *= 1;
        } else if (offsetText[i] == 'm') {
          triggerHorizontalOffset *= 1000;
        } else if (offsetText[i] == 's') {
          triggerHorizontalOffset *= 1000000;
        }
        print('Data: $triggerHorizontalOffset');
        notifyListeners();
        updateGraphTimeValue(
          usbProvider.triggeredTime - triggerHorizontalOffset,
        );

        return;
      }
    }
  }

  String get triggerHorizontalOffsetValue2Text {
    if ((triggerHorizontalOffset.abs() < 1000) &&
        (triggerHorizontalOffset.abs() >= 0.0)) {
      return '${(triggerHorizontalOffset).toStringAsFixed(2)} µs';
    } else if ((triggerHorizontalOffset.abs() >= 1000) &&
        (triggerHorizontalOffset.abs() < 1000000)) {
      return '${(triggerHorizontalOffset / 1000).toStringAsFixed(2)} ms';
    } else {
      return '${(triggerHorizontalOffset / 1000000).toStringAsFixed(2)} s';
    }
  }

  void updateTriggerVerticalOffset(double newValue) {
    triggerVerticalOffset = newValue;
    if (triggerVerticalOffset > (max_TriggerVerticalOffset)) {
      triggerVerticalOffset = max_TriggerVerticalOffset;
    } else if (triggerVerticalOffset <= min_TriggerVerticalOffset) {
      triggerVerticalOffset = min_TriggerVerticalOffset;
    }
    updateGraphVoltageValue();
    notifyListeners();
  }

  void incrementTriggerVerticalOffset(double delta) {
    double referenceUvperdivision = channel1.uVperDivision;

    if (!channel1.channelIsActive) {
      if (channel2.channelIsActive) {
        referenceUvperdivision = channel2.uVperDivision;
      }
    }

    triggerVerticalOffset += ((referenceUvperdivision / 20) * delta);
    if (triggerVerticalOffset > max_TriggerVerticalOffset) {
      triggerVerticalOffset = max_TriggerVerticalOffset;
    } else if (triggerVerticalOffset <= min_TriggerVerticalOffset) {
      triggerVerticalOffset = min_TriggerVerticalOffset;
    }
    notifyListeners();
  }

  String get triggerVerticalOffsetValue2Text {
    if ((triggerVerticalOffset.abs() < 1000) &&
        (triggerVerticalOffset.abs() >= 0.0)) {
      return '${(triggerVerticalOffset).toStringAsFixed(2)} µV';
    } else if ((triggerVerticalOffset.abs() >= 1000) &&
        (triggerVerticalOffset.abs() < 1000000)) {
      return '${(triggerVerticalOffset / 1000).toStringAsFixed(2)} mV';
    } else {
      return '${(triggerVerticalOffset / 1000000).toStringAsFixed(2)} V';
    }
  }

  convertTriggerVerticalOffsetText2Value(String offsetText) {
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
        triggerVerticalOffset = sign * double.parse(offsetTextNumbersOnly);
        if (offsetText[i + 1] == 'n') {
          triggerVerticalOffset *= 0.001;
        } else if ((offsetText[i + 1] == 'u') || (offsetText[i + 1] == 'µ')) {
          triggerVerticalOffset *= 1;
        } else if (offsetText[i + 1] == 'm') {
          triggerVerticalOffset *= 1000;
        } else if ((offsetText[i + 1] == 'v') || (offsetText[i + 1] == 'V')) {
          triggerVerticalOffset *= 1000000;
        }
        print('Data: $triggerVerticalOffset');
        notifyListeners();
        return;
      } else if ((offsetText[i] == 'n') ||
          (offsetText[i] == 'u') ||
          (offsetText[i] == 'm') ||
          ((offsetText[i] == 'v') || (offsetText[i] == 'V'))) {
        offsetTextNumbersOnly = offsetText.replaceRange(
          i,
          offsetText.length,
          '',
        );
        triggerVerticalOffset = sign * double.parse(offsetTextNumbersOnly);
        if (offsetText[i] == 'n') {
          triggerVerticalOffset *= 0.001;
        } else if ((offsetText[i] == 'u') || (offsetText[i] == 'µ')) {
          triggerVerticalOffset *= 1;
        } else if (offsetText[i] == 'm') {
          triggerVerticalOffset *= 1000;
        } else if ((offsetText[i] == 'v') || (offsetText[i] == 'V')) {
          triggerVerticalOffset *= 1000000;
        }
        print('Data: $triggerVerticalOffset');
        notifyListeners();
        return;
      }
    }
  }
}

SerialPort? selectedPort;

// Trigger Modes
List<String> triggerMode = ['Auto', 'Single', 'Normal', 'Roll'];
int selecetTriggerModeIndex = 2;

List<String> triggerStates = ['Run', 'Stop', 'Clear'];
int selecetTriggerStateIndex = 0;

Color selectedTriggerModeBackgroundColor = Colors.grey.shade500;
Color selectedTriggerStateBackgroundColor = Colors.grey.shade500;
Color selectedRunBackgroundColor = Colors.green;
Color selectedStopBackgroundColor = Colors.red;

// Trigger Channel
Channel selectedTriggerChannel = channels[0];

bool risingTriggerSelected = true;

Color triggerSwitchBackgroundColor = Colors.grey.shade400;

// Vertical scaler settings
// Tastkopf settings
Color VerticalScalerBackgroundColor = Colors.grey.shade100;

List<String> tastkopfModes = ['1:1', '10:1'];

// DC/AC Coupling setttings
List<String> couplingModes = ['DC', 'AC'];

// Horizontal scaler
Color HorizontalScalerBackgroundColor = Colors.grey.shade100;
