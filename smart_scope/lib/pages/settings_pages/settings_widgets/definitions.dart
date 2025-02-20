import 'package:flutter/material.dart';

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

// Channel Parameters
Color ch1Color = Colors.amber;
Color ch2Color = Colors.blue.shade300;

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
class AppState extends ChangeNotifier {
  double _currentsliderValue =
      6; // 🔹 Private Variable, um direkte Manipulation zu verhindern
  double timeValue = 10;

  double get currentsliderValue => _currentsliderValue; // Getter für den Wert

  void updateSliderValue(double newValue) {
    _currentsliderValue = newValue.clamp(
      1.0,
      100.0,
    ); // Sicherstellen, dass der Wert im Bereich bleibt
    notifyListeners(); // 🔥 Alle Listener informieren
  }

  void updateTimeValue(double newValue) {
    timeValue = newValue.clamp(
      0.0001,
      100.0,
    ); // Sicherstellen, dass der Wert im Bereich bleibt
    notifyListeners(); // 🔥 Alle Listener informieren
  }
}
