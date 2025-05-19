import 'package:flutter/material.dart';

Color cursorColor = Colors.purple;
Color cursorLabelColor = Colors.grey.shade200;

Color cardBackgroundColorCursor = Colors.grey.shade100;

Color ch1_Color = Colors.amber;
Color ch2_Color = Colors.blue.shade300;

Color ch1_trackColor = Colors.amber.shade100;

double max_uV_Cursor = 100000000;
double min_uV_Cursor = -max_uV_Cursor;

double max_XOffset = 10000000 * 12 / 2;
double min_XOffset = -max_XOffset;

double max_YOffset = 100000000 * 8 / 2;
double min_YOffset = -max_YOffset;

class CursorChanges extends ChangeNotifier {
  bool cursorIsEnabled = false;

  bool cursorIsOnCH2 = false;

  double cursorX1uS_Value = -100000.0;
  double cursorX2uS_Value = 100000.0;
  double cursorY1uV_Value = 100000.0;
  double cursorY2uV_Value = -100000.0;

  void toggleCursorEnabled() {
    cursorIsEnabled = !cursorIsEnabled;
    notifyListeners();
  }

  void toggleCursorChannel() {
    cursorIsOnCH2 = !cursorIsOnCH2;
    notifyListeners();
  }

  updateX1Value(double newValue) {
    cursorX1uS_Value = newValue;
    if (cursorX1uS_Value > max_XOffset) {
      cursorX1uS_Value = max_XOffset;
    } else if (cursorX1uS_Value <= min_XOffset) {
      cursorX1uS_Value = min_XOffset;
    }
    notifyListeners();
  }

  updateX2Value(double newValue) {
    cursorX2uS_Value = newValue;
    if (cursorX2uS_Value > max_XOffset) {
      cursorX2uS_Value = max_XOffset;
    } else if (cursorX2uS_Value <= min_XOffset) {
      cursorX2uS_Value = min_XOffset;
    }
    notifyListeners();
  }

  updateY1Value(double newValue) {
    cursorY1uV_Value = newValue;
    if (cursorY1uV_Value > max_YOffset) {
      cursorY1uV_Value = max_YOffset;
    } else if (cursorY1uV_Value <= min_YOffset) {
      cursorY1uV_Value = min_YOffset;
    }
    notifyListeners();
  }

  updateY2Value(double newValue) {
    cursorY2uV_Value = newValue;
    if (cursorY2uV_Value > max_YOffset) {
      cursorY2uV_Value = max_YOffset;
    } else if (cursorY2uV_Value <= min_YOffset) {
      cursorY2uV_Value = min_YOffset;
    }
    notifyListeners();
  }

  String get Value2Text_X1 {
    if ((cursorX1uS_Value.abs() < 1000) && (cursorX1uS_Value.abs() >= 0.0)) {
      return '${(cursorX1uS_Value).toStringAsFixed(2)} µs';
    } else if ((cursorX1uS_Value.abs() >= 1000) &&
        (cursorX1uS_Value.abs() < 1000000)) {
      return '${(cursorX1uS_Value / 1000).toStringAsFixed(2)} ms';
    } else {
      return '${(cursorX1uS_Value / 1000000).toStringAsFixed(2)} s';
    }
  }

  String get Value2Text_X2 {
    if ((cursorX2uS_Value.abs() < 1000) && (cursorX2uS_Value.abs() >= 0.0)) {
      return '${(cursorX2uS_Value).toStringAsFixed(2)} µs';
    } else if ((cursorX2uS_Value.abs() >= 1000) &&
        (cursorX2uS_Value.abs() < 1000000)) {
      return '${(cursorX2uS_Value / 1000).toStringAsFixed(2)} ms';
    } else {
      return '${(cursorX2uS_Value / 1000000).toStringAsFixed(2)} s';
    }
  }

  String get Value2Text_deltaX {
    double deltaX = cursorX2uS_Value - cursorX1uS_Value;

    if ((deltaX.abs() < 1000) && (deltaX.abs() >= 0.0)) {
      return '${(deltaX).toStringAsFixed(2)} µs';
    } else if ((deltaX.abs() >= 1000) && (deltaX.abs() < 1000000)) {
      return '${(deltaX / 1000).toStringAsFixed(2)} ms';
    } else {
      return '${(deltaX / 1000000).toStringAsFixed(2)} s';
    }
  }

  String get Value2Text_Y1 {
    if ((cursorY1uV_Value.abs() < 1000) && (cursorY1uV_Value.abs() >= 0.0)) {
      return '${(cursorY1uV_Value).toStringAsFixed(2)} µV';
    } else if ((cursorY1uV_Value.abs() >= 1000) &&
        (cursorY1uV_Value.abs() < 1000000)) {
      return '${(cursorY1uV_Value / 1000).toStringAsFixed(2)} mV';
    } else {
      return '${(cursorY1uV_Value / 1000000).toStringAsFixed(2)} V';
    }
  }

  String get Value2Text_Y2 {
    if ((cursorY2uV_Value.abs() < 1000) && (cursorY2uV_Value.abs() >= 0.0)) {
      return '${(cursorY2uV_Value).toStringAsFixed(2)} µV';
    } else if ((cursorY2uV_Value.abs() >= 1000) &&
        (cursorY2uV_Value.abs() < 1000000)) {
      return '${(cursorY2uV_Value / 1000).toStringAsFixed(2)} mV';
    } else {
      return '${(cursorY2uV_Value / 1000000).toStringAsFixed(2)} V';
    }
  }

  String get Value2Text_deltaY {
    double deltaY = cursorY2uV_Value - cursorY1uV_Value;

    if ((deltaY.abs() < 1000) && (deltaY.abs() >= 0.0)) {
      return '${(deltaY).toStringAsFixed(2)} µV';
    } else if ((deltaY.abs() >= 1000) && (deltaY.abs() < 1000000)) {
      return '${(deltaY / 1000).toStringAsFixed(2)} mV';
    } else {
      return '${(deltaY / 1000000).toStringAsFixed(2)} V';
    }
  }

  String get Value2Text_deltaX_frequency {
    double deltaX = cursorX2uS_Value - cursorX1uS_Value;
    deltaX = (deltaX.abs() / 1000000);
    if (deltaX == 0) {
      return 'false input';
    }

    double frequency_Hz = 1 / deltaX;

    if (frequency_Hz < 1) {
      return '${(frequency_Hz * 1000).toStringAsFixed(2)} mHz';
    } else if ((frequency_Hz <= 1) && (frequency_Hz < 1000)) {
      return '${(frequency_Hz * 1).toStringAsFixed(2)} Hz';
    } else if ((frequency_Hz <= 1000) && (frequency_Hz < 1000000)) {
      return '${(frequency_Hz / 1000).toStringAsFixed(2)} kHz';
    } else if ((frequency_Hz <= 1000000) && (frequency_Hz < 1000000000)) {
      return '${(frequency_Hz / 1000000).toStringAsFixed(2)} MHz';
    } else {
      return '${(frequency_Hz / 1000000000).toStringAsFixed(2)} GHz';
    }
  }

  convertText2Value_X1(String timeText) {
    String timeTextNumbersOnly;

    for (int i = 0; i < timeText.length; i++) {
      if ((timeText[i] == ' ')) {
        timeTextNumbersOnly = timeText.replaceRange(i, timeText.length, '');
        if (timeTextNumbersOnly.length == 0) {
          return;
        }
        for (int i = 0; i < timeTextNumbersOnly.length; i++) {
          if ((timeTextNumbersOnly[i] != '0') &&
              (timeTextNumbersOnly[i] != '1') &&
              (timeTextNumbersOnly[i] != '2') &&
              (timeTextNumbersOnly[i] != '3') &&
              (timeTextNumbersOnly[i] != '4') &&
              (timeTextNumbersOnly[i] != '5') &&
              (timeTextNumbersOnly[i] != '6') &&
              (timeTextNumbersOnly[i] != '7') &&
              (timeTextNumbersOnly[i] != '8') &&
              (timeTextNumbersOnly[i] != '9') &&
              (timeTextNumbersOnly[i] != '.')) {
            return;
          }
        }
        cursorX1uS_Value = double.parse(timeTextNumbersOnly);
        if (timeText[i + 1] == 'n') {
          cursorX1uS_Value *= 0.001;
        } else if ((timeText[i + 1] == 'u') || (timeText[i + 1] == 'µ')) {
          cursorX1uS_Value *= 1;
        } else if (timeText[i + 1] == 'm') {
          cursorX1uS_Value *= 1000;
        } else if (timeText[i + 1] == 's') {
          cursorX1uS_Value *= 1000000;
        }
        print('Data: $cursorX1uS_Value');
        notifyListeners();
        return;
      } else if ((timeText[i] == 'n') ||
          (timeText[i] == 'u') ||
          (timeText[i] == 'm') ||
          (timeText[i] == 's')) {
        timeTextNumbersOnly = timeText.replaceRange(i, timeText.length, '');
        if (timeTextNumbersOnly.length == 0) {
          return;
        }
        for (int i = 0; i < timeTextNumbersOnly.length; i++) {
          if ((timeTextNumbersOnly[i] != '0') &&
              (timeTextNumbersOnly[i] != '1') &&
              (timeTextNumbersOnly[i] != '2') &&
              (timeTextNumbersOnly[i] != '3') &&
              (timeTextNumbersOnly[i] != '4') &&
              (timeTextNumbersOnly[i] != '5') &&
              (timeTextNumbersOnly[i] != '6') &&
              (timeTextNumbersOnly[i] != '7') &&
              (timeTextNumbersOnly[i] != '8') &&
              (timeTextNumbersOnly[i] != '9') &&
              (timeTextNumbersOnly[i] != '.')) {
            return;
          }
        }
        cursorX1uS_Value = double.parse(timeTextNumbersOnly);
        if (timeText[i] == 'n') {
          cursorX1uS_Value *= 0.001;
        } else if ((timeText[i] == 'u') || (timeText[i] == 'µ')) {
          cursorX1uS_Value *= 1;
        } else if (timeText[i] == 'm') {
          cursorX1uS_Value *= 1000;
        } else if (timeText[i] == 's') {
          cursorX1uS_Value *= 1000000;
        }
        print('Data: $cursorX1uS_Value');
        notifyListeners();
        return;
      }
    }
  }

  convertText2Value_X2(String timeText) {
    String timeTextNumbersOnly;

    for (int i = 0; i < timeText.length; i++) {
      if ((timeText[i] == ' ')) {
        timeTextNumbersOnly = timeText.replaceRange(i, timeText.length, '');

        if (timeTextNumbersOnly.length == 0) {
          return;
        }
        for (int i = 0; i < timeTextNumbersOnly.length; i++) {
          if ((timeTextNumbersOnly[i] != '0') &&
              (timeTextNumbersOnly[i] != '1') &&
              (timeTextNumbersOnly[i] != '2') &&
              (timeTextNumbersOnly[i] != '3') &&
              (timeTextNumbersOnly[i] != '4') &&
              (timeTextNumbersOnly[i] != '5') &&
              (timeTextNumbersOnly[i] != '6') &&
              (timeTextNumbersOnly[i] != '7') &&
              (timeTextNumbersOnly[i] != '8') &&
              (timeTextNumbersOnly[i] != '9') &&
              (timeTextNumbersOnly[i] != '.')) {
            return;
          }
        }
        cursorX2uS_Value = double.parse(timeTextNumbersOnly);
        if (timeText[i + 1] == 'n') {
          cursorX2uS_Value *= 0.001;
        } else if ((timeText[i + 1] == 'u') || (timeText[i + 1] == 'µ')) {
          cursorX2uS_Value *= 1;
        } else if (timeText[i + 1] == 'm') {
          cursorX2uS_Value *= 1000;
        } else if (timeText[i + 1] == 's') {
          cursorX2uS_Value *= 1000000;
        }
        print('Data: $cursorX2uS_Value');
        notifyListeners();
        return;
      } else if ((timeText[i] == 'n') ||
          (timeText[i] == 'u') ||
          (timeText[i] == 'm') ||
          (timeText[i] == 's')) {
        timeTextNumbersOnly = timeText.replaceRange(i, timeText.length, '');

        if (timeTextNumbersOnly.length == 0) {
          return;
        }
        for (int i = 0; i < timeTextNumbersOnly.length; i++) {
          if ((timeTextNumbersOnly[i] != '0') &&
              (timeTextNumbersOnly[i] != '1') &&
              (timeTextNumbersOnly[i] != '2') &&
              (timeTextNumbersOnly[i] != '3') &&
              (timeTextNumbersOnly[i] != '4') &&
              (timeTextNumbersOnly[i] != '5') &&
              (timeTextNumbersOnly[i] != '6') &&
              (timeTextNumbersOnly[i] != '7') &&
              (timeTextNumbersOnly[i] != '8') &&
              (timeTextNumbersOnly[i] != '9') &&
              (timeTextNumbersOnly[i] != '.')) {
            return;
          }
        }
        cursorX2uS_Value = double.parse(timeTextNumbersOnly);
        if (timeText[i] == 'n') {
          cursorX2uS_Value *= 0.001;
        } else if ((timeText[i] == 'u') || (timeText[i] == 'µ')) {
          cursorX2uS_Value *= 1;
        } else if (timeText[i] == 'm') {
          cursorX2uS_Value *= 1000;
        } else if (timeText[i] == 's') {
          cursorX2uS_Value *= 1000000;
        }
        print('Data: $cursorX2uS_Value');
        notifyListeners();
        return;
      }
    }
  }

  convertText2Value_Y1(String voltagText) {
    String voltageTextNumbersOnly;

    for (int i = 0; i < voltagText.length; i++) {
      if ((voltagText[i] == ' ')) {
        voltageTextNumbersOnly = voltagText.replaceRange(
          i,
          voltagText.length,
          '',
        );

        if (voltageTextNumbersOnly.length == 0) {
          return;
        }
        for (int i = 0; i < voltageTextNumbersOnly.length; i++) {
          if ((voltageTextNumbersOnly[i] != '0') &&
              (voltageTextNumbersOnly[i] != '1') &&
              (voltageTextNumbersOnly[i] != '2') &&
              (voltageTextNumbersOnly[i] != '3') &&
              (voltageTextNumbersOnly[i] != '4') &&
              (voltageTextNumbersOnly[i] != '5') &&
              (voltageTextNumbersOnly[i] != '6') &&
              (voltageTextNumbersOnly[i] != '7') &&
              (voltageTextNumbersOnly[i] != '8') &&
              (voltageTextNumbersOnly[i] != '9') &&
              (voltageTextNumbersOnly[i] != '.')) {
            return;
          }
        }
        cursorY1uV_Value = double.parse(voltageTextNumbersOnly);
        if ((voltagText[i + 1] == 'u') || (voltagText[i + 1] == 'µ')) {
          cursorY1uV_Value *= 1;
        } else if (voltagText[i + 1] == 'm') {
          cursorY1uV_Value *= 1000;
        } else if ((voltagText[i + 1] == 'v') || (voltagText[i + 1] == 'V')) {
          cursorY1uV_Value *= 1000000;
        }
        print('Data: $cursorY2uV_Value');
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
        if (voltageTextNumbersOnly.length == 0) {
          return;
        }
        for (int i = 0; i < voltageTextNumbersOnly.length; i++) {
          if ((voltageTextNumbersOnly[i] != '0') &&
              (voltageTextNumbersOnly[i] != '1') &&
              (voltageTextNumbersOnly[i] != '2') &&
              (voltageTextNumbersOnly[i] != '3') &&
              (voltageTextNumbersOnly[i] != '4') &&
              (voltageTextNumbersOnly[i] != '5') &&
              (voltageTextNumbersOnly[i] != '6') &&
              (voltageTextNumbersOnly[i] != '7') &&
              (voltageTextNumbersOnly[i] != '8') &&
              (voltageTextNumbersOnly[i] != '9') &&
              (voltageTextNumbersOnly[i] != '.')) {
            return;
          }
        }
        cursorY1uV_Value = double.parse(voltageTextNumbersOnly);
        if ((voltagText[i] == 'u') || (voltagText[i] == 'µ')) {
          cursorY1uV_Value *= 1;
        } else if (voltagText[i] == 'm') {
          cursorY1uV_Value *= 1000;
        } else if ((voltagText[i] == 'v') || (voltagText[i] == 'V')) {
          cursorY1uV_Value *= 1000000;
        }
        print('Data: $cursorY1uV_Value');
        notifyListeners();
        return;
      }
    }
  }

  convertText2Value_Y2(String voltagText) {
    String voltageTextNumbersOnly;

    for (int i = 0; i < voltagText.length; i++) {
      if ((voltagText[i] == ' ')) {
        voltageTextNumbersOnly = voltagText.replaceRange(
          i,
          voltagText.length,
          '',
        );
        if (voltageTextNumbersOnly.length == 0) {
          return;
        }
        for (int i = 0; i < voltageTextNumbersOnly.length; i++) {
          if ((voltageTextNumbersOnly[i] != '0') &&
              (voltageTextNumbersOnly[i] != '1') &&
              (voltageTextNumbersOnly[i] != '2') &&
              (voltageTextNumbersOnly[i] != '3') &&
              (voltageTextNumbersOnly[i] != '4') &&
              (voltageTextNumbersOnly[i] != '5') &&
              (voltageTextNumbersOnly[i] != '6') &&
              (voltageTextNumbersOnly[i] != '7') &&
              (voltageTextNumbersOnly[i] != '8') &&
              (voltageTextNumbersOnly[i] != '9') &&
              (voltageTextNumbersOnly[i] != '.')) {
            return;
          }
        }
        cursorY2uV_Value = double.parse(voltageTextNumbersOnly);
        if ((voltagText[i + 1] == 'u') || (voltagText[i + 1] == 'µ')) {
          cursorY2uV_Value *= 1;
        } else if (voltagText[i + 1] == 'm') {
          cursorY2uV_Value *= 1000;
        } else if ((voltagText[i + 1] == 'v') || (voltagText[i + 1] == 'V')) {
          cursorY2uV_Value *= 1000000;
        }
        print('Data: $cursorY2uV_Value');
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
        if (voltageTextNumbersOnly.length == 0) {
          return;
        }
        for (int i = 0; i < voltageTextNumbersOnly.length; i++) {
          if ((voltageTextNumbersOnly[i] != '0') &&
              (voltageTextNumbersOnly[i] != '1') &&
              (voltageTextNumbersOnly[i] != '2') &&
              (voltageTextNumbersOnly[i] != '3') &&
              (voltageTextNumbersOnly[i] != '4') &&
              (voltageTextNumbersOnly[i] != '5') &&
              (voltageTextNumbersOnly[i] != '6') &&
              (voltageTextNumbersOnly[i] != '7') &&
              (voltageTextNumbersOnly[i] != '8') &&
              (voltageTextNumbersOnly[i] != '9') &&
              (voltageTextNumbersOnly[i] != '.')) {
            return;
          }
        }
        cursorY2uV_Value = double.parse(voltageTextNumbersOnly);
        if ((voltagText[i] == 'u') || (voltagText[i] == 'µ')) {
          cursorY2uV_Value *= 1;
        } else if (voltagText[i] == 'm') {
          cursorY2uV_Value *= 1000;
        } else if ((voltagText[i] == 'v') || (voltagText[i] == 'V')) {
          cursorY2uV_Value *= 1000000;
        }
        print('Data: $cursorY2uV_Value');
        notifyListeners();
        return;
      }
    }
  }

  void incrementX1_Offset(double delta, double referenceUsperdivision) {
    cursorX1uS_Value += ((referenceUsperdivision / 50) * delta);
    if (cursorX1uS_Value > max_XOffset) {
      cursorX1uS_Value = max_XOffset;
    } else if (cursorX1uS_Value <= min_XOffset) {
      cursorX1uS_Value = min_XOffset;
    }
    notifyListeners();
  }

  void incrementX2_Offset(double delta, double referenceUsperdivision) {
    cursorX2uS_Value += ((referenceUsperdivision / 50) * delta);
    if (cursorX2uS_Value > max_XOffset) {
      cursorX2uS_Value = max_XOffset;
    } else if (cursorX2uS_Value <= min_XOffset) {
      cursorX2uS_Value = min_XOffset;
    }
    notifyListeners();
  }

  void incrementY1_Offset(double delta, double referenceUvperdivision) {
    cursorY1uV_Value += ((referenceUvperdivision / 50) * delta);
    if (cursorY1uV_Value > max_YOffset) {
      cursorY1uV_Value = max_YOffset;
    } else if (cursorY1uV_Value <= min_YOffset) {
      cursorY1uV_Value = min_YOffset;
    }
    notifyListeners();
  }

  void incrementY2_Offset(double delta, double referenceUsperdivision) {
    cursorY2uV_Value += ((referenceUsperdivision / 50) * delta);
    if (cursorY2uV_Value > max_YOffset) {
      cursorY2uV_Value = max_YOffset;
    } else if (cursorY2uV_Value <= min_YOffset) {
      cursorY2uV_Value = min_YOffset;
    }
    notifyListeners();
  }
}
