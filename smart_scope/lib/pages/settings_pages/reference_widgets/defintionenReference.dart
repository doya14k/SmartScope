import 'package:flutter/material.dart';

Color clear3 = Colors.transparent;
Color referenceSelectedBackground = Colors.grey.shade400;
Color referencenotSelectedText = Colors.grey.shade50;

Color cardBackgroundColor = Colors.grey.shade100;

Color ref1GraphColor = Colors.green;
Color ref2GraphColor = Colors.red;
Color ref3GraphColor = Colors.purpleAccent;

int selectedReference1Graph = 1;
int selectedReference2Graph = 1;
int selectedReference3Graph = 1;

double max_uV_RefLevelOffset = 100000000;
double min_uV_RefLevelOffset = -max_uV_RefLevelOffset;

double min_uV_RefperDivision = 1.0;
double max_uV_RefperDivision = 100000000.0;

class ReferenceChanges extends ChangeNotifier {
  bool ref1GraphisActive = false;
  bool ref2GraphisActive = false;
  bool ref3GraphisActive = false;

  double Ref1Offset = 0;
  double Ref2Offset = 0;
  double Ref3Offset = 0;

  double Ref1uVperDivision = 2000;
  double Ref2uVperDivision = 2000;
  double Ref3uVperDivision = 2000;

  double maxGraphVoltageValueRef1 = 2000 * (8 / 2);
  double minGraphVoltageValueRef1 = -2000 * (8 / 2);

  double maxGraphVoltageValueRef2 = 2000 * (8 / 2);
  double minGraphVoltageValueRef2 = -2000 * (8 / 2);

  double maxGraphVoltageValueRef3 = 2000 * (8 / 2);
  double minGraphVoltageValueRef3 = -2000 * (8 / 2);

  updateRef1IsAcitve(bool newState) {
    ref1GraphisActive = newState;
    notifyListeners();
  }

  updateRef2IsAcitve(bool newState) {
    ref2GraphisActive = newState;
    notifyListeners();
  }

  updateRef3IsAcitve(bool newState) {
    ref3GraphisActive = newState;
    notifyListeners();
  }

  bool get Ref1IsActive {
    return ref1GraphisActive;
  }

  bool get Ref2IsActive {
    return ref2GraphisActive;
  }

  bool get Ref3IsActive {
    return ref3GraphisActive;
  }

  updateGraphVoltageValue() {
    maxGraphVoltageValueRef1 = (Ref1uVperDivision * (8 / 2)) - Ref1Offset;
    minGraphVoltageValueRef1 = -(Ref1uVperDivision * (8 / 2)) - Ref1Offset;

    print('Max: ${maxGraphVoltageValueRef1}');

    maxGraphVoltageValueRef2 = (Ref2uVperDivision * (8 / 2)) - Ref2Offset;
    minGraphVoltageValueRef2 = -(Ref2uVperDivision * (8 / 2)) - Ref2Offset;

    maxGraphVoltageValueRef3 = (Ref3uVperDivision * (8 / 2)) - Ref3Offset;
    minGraphVoltageValueRef3 = -(Ref3uVperDivision * (8 / 2)) - Ref3Offset;
    notifyListeners();
  }

  void incrementRef1VerticalOffset(double delta) {
    double referenceUvperdivision = Ref1uVperDivision;

    Ref1Offset += ((referenceUvperdivision / 20) * delta);
    if (Ref1Offset > max_uV_RefLevelOffset) {
      Ref1Offset = max_uV_RefLevelOffset;
    } else if (Ref1Offset <= min_uV_RefLevelOffset) {
      Ref1Offset = min_uV_RefLevelOffset;
    }
    updateGraphVoltageValue();
    notifyListeners();
  }

  void updateRef1Offset(double newValue) {
    Ref1Offset = newValue;
    if (Ref1Offset > (max_uV_RefLevelOffset)) {
      Ref1Offset = max_uV_RefLevelOffset;
    } else if (Ref1Offset <= min_uV_RefLevelOffset) {
      Ref1Offset = min_uV_RefLevelOffset;
    }
    updateGraphVoltageValue();
    notifyListeners();
  }

  convertTriggerVerticalOffsetText2Value_Ref1(String offsetText) {
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
        Ref1Offset = sign * double.parse(offsetTextNumbersOnly);
        if (offsetText[i + 1] == 'n') {
          Ref1Offset *= 0.001;
        } else if ((offsetText[i + 1] == 'u') || (offsetText[i + 1] == 'µ')) {
          Ref1Offset *= 1;
        } else if (offsetText[i + 1] == 'm') {
          Ref1Offset *= 1000;
        } else if ((offsetText[i + 1] == 'v') || (offsetText[i + 1] == 'V')) {
          Ref1Offset *= 1000000;
        }
        print('Data: $Ref1Offset');
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
        Ref1Offset = sign * double.parse(offsetTextNumbersOnly);
        if (offsetText[i] == 'n') {
          Ref1Offset *= 0.001;
        } else if ((offsetText[i] == 'u') || (offsetText[i] == 'µ')) {
          Ref1Offset *= 1;
        } else if (offsetText[i] == 'm') {
          Ref1Offset *= 1000;
        } else if ((offsetText[i] == 'v') || (offsetText[i] == 'V')) {
          Ref1Offset *= 1000000;
        }
        print('Data: $Ref1Offset');
        updateGraphVoltageValue();
        notifyListeners();
        return;
      }
    }
  }

  String get triggerVerticalOffsetValue2Text_Ref1 {
    if ((Ref1Offset.abs() < 1000) && (Ref1Offset.abs() >= 0.0)) {
      return '${(Ref1Offset).toStringAsFixed(2)} µV';
    } else if ((Ref1Offset.abs() >= 1000) && (Ref1Offset.abs() < 1000000)) {
      return '${(Ref1Offset / 1000).toStringAsFixed(2)} mV';
    } else {
      return '${(Ref1Offset / 1000000).toStringAsFixed(2)} V';
    }
  }

  void updateSliderValue_Ref1(double newValue) {
    Ref1uVperDivision = newValue.clamp(
      min_uV_RefperDivision,
      max_uV_RefperDivision,
    );
    updateGraphVoltageValue();
    notifyListeners();
  }

  void incrementVoltageValueperDivision_Ref1(double delta) {
    if ((Ref1uVperDivision < 1000) && (Ref1uVperDivision > 0)) {
      Ref1uVperDivision = Ref1uVperDivision + (delta * 1);
    } else if (Ref1uVperDivision < 1000000) {
      Ref1uVperDivision = Ref1uVperDivision + (delta * 1000);
    } else if (Ref1uVperDivision >= 1000000) {
      Ref1uVperDivision = Ref1uVperDivision + (delta * 1000000);
    }

    if (Ref1uVperDivision > max_uV_RefperDivision) {
      Ref1uVperDivision = max_uV_RefperDivision;
    } else if (Ref1uVperDivision < min_uV_RefperDivision) {
      Ref1uVperDivision = min_uV_RefperDivision;
    }
    updateGraphVoltageValue();
    notifyListeners();
  }

  convertVoltageText2Value_perDivision_Ref1(String voltagText) {
    String voltageTextNumbersOnly;

    for (int i = 0; i < voltagText.length; i++) {
      if ((voltagText[i] == ' ')) {
        voltageTextNumbersOnly = voltagText.replaceRange(
          i,
          voltagText.length,
          '',
        );
        Ref1uVperDivision = double.parse(voltageTextNumbersOnly);
        if ((voltagText[i + 1] == 'u') || (voltagText[i + 1] == 'µ')) {
          Ref1uVperDivision *= 1;
        } else if (voltagText[i + 1] == 'm') {
          Ref1uVperDivision *= 1000;
        } else if ((voltagText[i + 1] == 'v') || (voltagText[i + 1] == 'V')) {
          Ref1uVperDivision *= 1000000;
        }
        print('Data: $Ref1uVperDivision');
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
        Ref1uVperDivision = double.parse(voltageTextNumbersOnly);
        if ((voltagText[i] == 'u') || (voltagText[i] == 'µ')) {
          Ref1uVperDivision *= 1;
        } else if (voltagText[i] == 'm') {
          Ref1uVperDivision *= 1000;
        } else if ((voltagText[i] == 'v') || (voltagText[i] == 'V')) {
          Ref1uVperDivision *= 1000000;
        }
        print('Data: $Ref1uVperDivision');
        updateGraphVoltageValue();
        notifyListeners();
        return;
      }
    }
  }

  String get voltageValueTextperDivision_Ref1 {
    if (Ref1uVperDivision < 1000) {
      return '${(Ref1uVperDivision).toStringAsFixed(2)} µV';
    } else if ((Ref1uVperDivision < 1000000) && (Ref1uVperDivision < 1000000)) {
      return '${(Ref1uVperDivision / 1000).toStringAsFixed(2)} mV';
    } else if (Ref1uVperDivision >= 1000000) {
      return '${(Ref1uVperDivision / 1000000).toStringAsFixed(2)} V';
    } else {
      return '${(Ref1uVperDivision / 1000000).toStringAsFixed(2)} V';
    }
  }

  // Reference 2

  void incrementRef2VerticalOffset(double delta) {
    double referenceUvperdivision = Ref2uVperDivision;

    Ref2Offset += ((referenceUvperdivision / 20) * delta);
    if (Ref2Offset > max_uV_RefLevelOffset) {
      Ref2Offset = max_uV_RefLevelOffset;
    } else if (Ref2Offset <= min_uV_RefLevelOffset) {
      Ref2Offset = min_uV_RefLevelOffset;
    }
    updateGraphVoltageValue();
    notifyListeners();
  }

  void updateRef2Offset(double newValue) {
    Ref2Offset = newValue;
    if (Ref2Offset > (max_uV_RefLevelOffset)) {
      Ref2Offset = max_uV_RefLevelOffset;
    } else if (Ref2Offset <= min_uV_RefLevelOffset) {
      Ref2Offset = min_uV_RefLevelOffset;
    }
    updateGraphVoltageValue();
    notifyListeners();
  }

  convertTriggerVerticalOffsetText2Value_Ref2(String offsetText) {
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
        Ref2Offset = sign * double.parse(offsetTextNumbersOnly);
        if (offsetText[i + 1] == 'n') {
          Ref2Offset *= 0.001;
        } else if ((offsetText[i + 1] == 'u') || (offsetText[i + 1] == 'µ')) {
          Ref2Offset *= 1;
        } else if (offsetText[i + 1] == 'm') {
          Ref2Offset *= 1000;
        } else if ((offsetText[i + 1] == 'v') || (offsetText[i + 1] == 'V')) {
          Ref2Offset *= 1000000;
        }
        print('Data: $Ref2Offset');
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
        Ref2Offset = sign * double.parse(offsetTextNumbersOnly);
        if (offsetText[i] == 'n') {
          Ref2Offset *= 0.001;
        } else if ((offsetText[i] == 'u') || (offsetText[i] == 'µ')) {
          Ref2Offset *= 1;
        } else if (offsetText[i] == 'm') {
          Ref2Offset *= 1000;
        } else if ((offsetText[i] == 'v') || (offsetText[i] == 'V')) {
          Ref2Offset *= 1000000;
        }
        print('Data: $Ref2Offset');
        updateGraphVoltageValue();
        notifyListeners();
        return;
      }
    }
  }

  String get triggerVerticalOffsetValue2Text_Ref2 {
    if ((Ref2Offset.abs() < 1000) && (Ref2Offset.abs() >= 0.0)) {
      return '${(Ref2Offset).toStringAsFixed(2)} µV';
    } else if ((Ref2Offset.abs() >= 1000) && (Ref2Offset.abs() < 1000000)) {
      return '${(Ref2Offset / 1000).toStringAsFixed(2)} mV';
    } else {
      return '${(Ref2Offset / 1000000).toStringAsFixed(2)} V';
    }
  }

  void updateSliderValue_Ref2(double newValue) {
    Ref2uVperDivision = newValue.clamp(
      min_uV_RefperDivision,
      max_uV_RefperDivision,
    );
    updateGraphVoltageValue();
    notifyListeners();
  }

  void incrementVoltageValueperDivision_Ref2(double delta) {
    if ((Ref2uVperDivision < 1000) && (Ref2uVperDivision > 0)) {
      Ref2uVperDivision = Ref2uVperDivision + (delta * 1);
    } else if (Ref2uVperDivision < 1000000) {
      Ref2uVperDivision = Ref2uVperDivision + (delta * 1000);
    } else if (Ref2uVperDivision >= 1000000) {
      Ref2uVperDivision = Ref2uVperDivision + (delta * 1000000);
    }

    if (Ref2uVperDivision > max_uV_RefperDivision) {
      Ref2uVperDivision = max_uV_RefperDivision;
    } else if (Ref2uVperDivision < min_uV_RefperDivision) {
      Ref2uVperDivision = min_uV_RefperDivision;
    }
    updateGraphVoltageValue();
    notifyListeners();
  }

  convertVoltageText2Value_perDivision_Ref2(String voltagText) {
    String voltageTextNumbersOnly;

    for (int i = 0; i < voltagText.length; i++) {
      if ((voltagText[i] == ' ')) {
        voltageTextNumbersOnly = voltagText.replaceRange(
          i,
          voltagText.length,
          '',
        );
        Ref2uVperDivision = double.parse(voltageTextNumbersOnly);
        if ((voltagText[i + 1] == 'u') || (voltagText[i + 1] == 'µ')) {
          Ref2uVperDivision *= 1;
        } else if (voltagText[i + 1] == 'm') {
          Ref2uVperDivision *= 1000;
        } else if ((voltagText[i + 1] == 'v') || (voltagText[i + 1] == 'V')) {
          Ref2uVperDivision *= 1000000;
        }
        print('Data: $Ref2uVperDivision');
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
        Ref2uVperDivision = double.parse(voltageTextNumbersOnly);
        if ((voltagText[i] == 'u') || (voltagText[i] == 'µ')) {
          Ref2uVperDivision *= 1;
        } else if (voltagText[i] == 'm') {
          Ref2uVperDivision *= 1000;
        } else if ((voltagText[i] == 'v') || (voltagText[i] == 'V')) {
          Ref2uVperDivision *= 1000000;
        }
        print('Data: $Ref2uVperDivision');
        updateGraphVoltageValue();
        notifyListeners();
        return;
      }
    }
  }

  String get voltageValueTextperDivision_Ref2 {
    if (Ref2uVperDivision < 1000) {
      return '${(Ref2uVperDivision).toStringAsFixed(2)} µV';
    } else if ((Ref2uVperDivision < 1000000) && (Ref2uVperDivision < 1000000)) {
      return '${(Ref2uVperDivision / 1000).toStringAsFixed(2)} mV';
    } else if (Ref2uVperDivision >= 1000000) {
      return '${(Ref2uVperDivision / 1000000).toStringAsFixed(2)} V';
    } else {
      return '${(Ref2uVperDivision / 1000000).toStringAsFixed(2)} V';
    }
  }

  // Reference 3

  void incrementRef3VerticalOffset(double delta) {
    double referenceUvperdivision = Ref3uVperDivision;

    Ref3Offset += ((referenceUvperdivision / 20) * delta);
    if (Ref3Offset > max_uV_RefLevelOffset) {
      Ref3Offset = max_uV_RefLevelOffset;
    } else if (Ref3Offset <= min_uV_RefLevelOffset) {
      Ref3Offset = min_uV_RefLevelOffset;
    }
    updateGraphVoltageValue();
    notifyListeners();
  }

  void updateRef3Offset(double newValue) {
    Ref3Offset = newValue;
    if (Ref3Offset > (max_uV_RefLevelOffset)) {
      Ref3Offset = max_uV_RefLevelOffset;
    } else if (Ref3Offset <= min_uV_RefLevelOffset) {
      Ref3Offset = min_uV_RefLevelOffset;
    }
    updateGraphVoltageValue();
    notifyListeners();
  }

  convertTriggerVerticalOffsetText2Value_Ref3(String offsetText) {
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
        Ref3Offset = sign * double.parse(offsetTextNumbersOnly);
        if (offsetText[i + 1] == 'n') {
          Ref3Offset *= 0.001;
        } else if ((offsetText[i + 1] == 'u') || (offsetText[i + 1] == 'µ')) {
          Ref3Offset *= 1;
        } else if (offsetText[i + 1] == 'm') {
          Ref3Offset *= 1000;
        } else if ((offsetText[i + 1] == 'v') || (offsetText[i + 1] == 'V')) {
          Ref3Offset *= 1000000;
        }
        print('Data: $Ref3Offset');
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
        Ref3Offset = sign * double.parse(offsetTextNumbersOnly);
        if (offsetText[i] == 'n') {
          Ref3Offset *= 0.001;
        } else if ((offsetText[i] == 'u') || (offsetText[i] == 'µ')) {
          Ref3Offset *= 1;
        } else if (offsetText[i] == 'm') {
          Ref3Offset *= 1000;
        } else if ((offsetText[i] == 'v') || (offsetText[i] == 'V')) {
          Ref3Offset *= 1000000;
        }
        print('Data: $Ref3Offset');
        updateGraphVoltageValue();
        notifyListeners();
        return;
      }
    }
  }

  String get triggerVerticalOffsetValue2Text_Ref3 {
    if ((Ref3Offset.abs() < 1000) && (Ref3Offset.abs() >= 0.0)) {
      return '${(Ref3Offset).toStringAsFixed(2)} µV';
    } else if ((Ref3Offset.abs() >= 1000) && (Ref3Offset.abs() < 1000000)) {
      return '${(Ref3Offset / 1000).toStringAsFixed(2)} mV';
    } else {
      return '${(Ref3Offset / 1000000).toStringAsFixed(2)} V';
    }
  }

  void updateSliderValue_Ref3(double newValue) {
    Ref3uVperDivision = newValue.clamp(
      min_uV_RefperDivision,
      max_uV_RefperDivision,
    );
    updateGraphVoltageValue();
    notifyListeners();
  }

  void incrementVoltageValueperDivision_Ref3(double delta) {
    if ((Ref3uVperDivision < 1000) && (Ref3uVperDivision > 0)) {
      Ref3uVperDivision = Ref3uVperDivision + (delta * 1);
    } else if (Ref3uVperDivision < 1000000) {
      Ref3uVperDivision = Ref3uVperDivision + (delta * 1000);
    } else if (Ref3uVperDivision >= 1000000) {
      Ref3uVperDivision = Ref3uVperDivision + (delta * 1000000);
    }

    if (Ref3uVperDivision > max_uV_RefperDivision) {
      Ref3uVperDivision = max_uV_RefperDivision;
    } else if (Ref3uVperDivision < min_uV_RefperDivision) {
      Ref3uVperDivision = min_uV_RefperDivision;
    }
    updateGraphVoltageValue();
    notifyListeners();
  }

  convertVoltageText2Value_perDivision_Ref3(String voltagText) {
    String voltageTextNumbersOnly;

    for (int i = 0; i < voltagText.length; i++) {
      if ((voltagText[i] == ' ')) {
        voltageTextNumbersOnly = voltagText.replaceRange(
          i,
          voltagText.length,
          '',
        );
        Ref3uVperDivision = double.parse(voltageTextNumbersOnly);
        if ((voltagText[i + 1] == 'u') || (voltagText[i + 1] == 'µ')) {
          Ref3uVperDivision *= 1;
        } else if (voltagText[i + 1] == 'm') {
          Ref3uVperDivision *= 1000;
        } else if ((voltagText[i + 1] == 'v') || (voltagText[i + 1] == 'V')) {
          Ref3uVperDivision *= 1000000;
        }
        print('Data: $Ref3uVperDivision');
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
        Ref3uVperDivision = double.parse(voltageTextNumbersOnly);
        if ((voltagText[i] == 'u') || (voltagText[i] == 'µ')) {
          Ref3uVperDivision *= 1;
        } else if (voltagText[i] == 'm') {
          Ref3uVperDivision *= 1000;
        } else if ((voltagText[i] == 'v') || (voltagText[i] == 'V')) {
          Ref3uVperDivision *= 1000000;
        }
        print('Data: $Ref3uVperDivision');
        updateGraphVoltageValue();
        notifyListeners();
        return;
      }
    }
  }

  String get voltageValueTextperDivision_Ref3 {
    if (Ref3uVperDivision < 1000) {
      return '${(Ref3uVperDivision).toStringAsFixed(2)} µV';
    } else if ((Ref3uVperDivision < 1000000) && (Ref3uVperDivision < 1000000)) {
      return '${(Ref3uVperDivision / 1000).toStringAsFixed(2)} mV';
    } else if (Ref3uVperDivision >= 1000000) {
      return '${(Ref3uVperDivision / 1000000).toStringAsFixed(2)} V';
    } else {
      return '${(Ref3uVperDivision / 1000000).toStringAsFixed(2)} V';
    }
  }
}
