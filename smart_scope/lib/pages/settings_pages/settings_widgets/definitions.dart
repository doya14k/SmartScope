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
  List<double>? channelData;
  double? uVperDivision;

  Channel({
    Color? color,
    int? index,
    String? name,
    List<double>? data,
    double? uVperDiv,
  }) {
    this.channelColor = color;
    this.channelIndex = index;
    this.channelName = name;
    this.channelData = data;
    this.uVperDivision = uVperDiv;
  }
}

// CH1
Channel channel1 = Channel(
  color: Colors.amber,
  index: 1,
  name: 'CH1',
  uVperDiv: 50,
);

// CH2
Channel channel2 = Channel(
  color: Colors.blue.shade300,
  index: 2,
  name: 'CH2',
  uVperDiv: 50,
);

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
Color CharBackgroundColor = Colors.black;

// Grid Values
double NOF_xGrids = 12;
double NOF_yGrids = 8;
Color BaseLineColor = Color.fromRGBO(255, 255, 255, 0.75);
Color GridLineColor = Color.fromRGBO(255, 255, 255, 0.35);

// ChangeNotifiere Class

double min_uVperDivision = 1.0;
double max_uVperDivision = 100.0;
double min_uSperDivision = 0.0001;
double max_uSperDivision = 100.0;

class AppState extends ChangeNotifier {
  double _currentsliderValue = 6;
  double timeValue = 10;

  double get currentsliderValue => _currentsliderValue;

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
}

SerialPort? selectedPort;
