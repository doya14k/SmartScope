import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:serial_port_win32/serial_port_win32.dart';
import 'pages/settings_pages/settings_widgets/definitions.dart';
import 'package:provider/provider.dart';

class UsbProvider extends ChangeNotifier {
  late AppState appState;

  void setAppState(AppState newAppState) {
    appState = newAppState;
  }

  SerialPort? selectedPort;
  StreamController<String> dataController =
      StreamController<String>.broadcast();
  Timer? readTimer;
  String receivedData = "";
  final Stopwatch stopwatch = Stopwatch();

  List<FlSpot> ch1_data = [FlSpot(0, 0)];
  List<FlSpot> ch2_data = [FlSpot(0, 0)];

  List<FlSpot> ref1_data = [FlSpot(0, 0)];
  List<FlSpot> ref2_data = [FlSpot(0, 0)];
  List<FlSpot> ref3_data = [FlSpot(0, 0)];

  List<double> last_dataFromChannel = [0, 0];
  List<double> last_timeFromChannel = [0, 0];

  List<List<FlSpot>> get dataChannelLists => [ch1_data, ch2_data];
  List<List<FlSpot>> get dataReferenceLists => [
    ref1_data,
    ref2_data,
    ref3_data,
  ];
  double currentTime = 0;
  double triggeredTime = 0;

  int selectedMessbereichIndex = 0;
  final List<int> messbereiche = [50, 25, 10, 5, 1];

  void clearPlot() {
    stopwatch.reset();
    stopwatch.start();

    ch1_data = [FlSpot(0, 0)];
    ch2_data = [FlSpot(0, 0)];

    notifyListeners();
  }

  double get stopwatch_elapsedMicroseconds =>
      stopwatch.elapsedMicroseconds.toDouble();

  void openPort(String portName) {
    if (selectedPort != null && selectedPort!.isOpened) return;

    selectedPort = SerialPort(portName, openNow: true, BaudRate: 9600);
    selectedPort?.open();

    dataController = StreamController<String>.broadcast();
    dataController.stream.listen((data) {
      receivedData = data;
      notifyListeners();
    });

    if (selectedPort!.isOpened) {
      print("Port $portName erfolgreich geöffnet!");
      stopwatch.reset();
      stopwatch.start();
      startReading();
    } else {
      print("Fehler beim Öffnen des Ports $portName");
    }
  }

  void startReading() {
    if (selectedPort == null || !selectedPort!.isOpened) return;

    readTimer = Timer.periodic(Duration(microseconds: 1), (timer) async {
      Uint8List? data = await selectedPort!.readBytes(
        64,
        timeout: Duration(microseconds: 1),
      );

      if (data.isNotEmpty) {
        String receivedString = String.fromCharCodes(data).trim();
        int? adcValue;
        int? adcLowBits;
        int? adcHighBits;

        for (int byte in data) {
          int half = (byte & 0x80) >> 7;
          int dataBits = byte & 0x3F;
          int channel = (byte & 0x40) >> 6;

          if (half == 0) {
            adcLowBits = dataBits;
          } else {
            adcHighBits = dataBits;
          }

          if (adcLowBits != null && adcHighBits != null) {
            adcValue = (adcHighBits! << 6) | adcLowBits!;
            double voltageValue_uV =
                (adcValue.toDouble() * 2 * (1.5 * 1000000) / 4096.0) - 1.5;

            currentTime = stopwatch.elapsedMicroseconds.toDouble();
            dataChannelLists[channel].add(FlSpot(currentTime, voltageValue_uV));

            if (selecetTriggerModeIndex == 3) {
              double cutoff = currentTime - (200 * 1000000);
              dataChannelLists[channel].removeWhere(
                (point) => point.x < cutoff,
              );
            }
            // if (last_dataFromChannel[channel] != []) {
            else if (selecetTriggerModeIndex == 2) {
              // Normal Trigger
              if (risingTriggerSelected) {
                if ((last_dataFromChannel[channel] <=
                        appState.triggerVerticalOffset) &&
                    (appState.triggerVerticalOffset < voltageValue_uV)) {
                  triggeredTime =
                      (currentTime + last_timeFromChannel[channel]) / 2;
                  print("Trigger pos");
                  print("TrHor: ${appState.triggerHorizontalOffset}");
                  appState.updateGraphTimeValue(
                    triggeredTime - appState.triggerHorizontalOffset,
                  );
                }
              } else if (!risingTriggerSelected) {
                if ((last_dataFromChannel[channel] >
                        appState.triggerVerticalOffset) &&
                    (appState.triggerVerticalOffset >= voltageValue_uV)) {
                  print("Trigger neg");
                }
              }
            } else if (selecetTriggerModeIndex == 1) {
              // Single_trigger
            }
            // }

            last_dataFromChannel[channel] = voltageValue_uV;
            last_timeFromChannel[channel] = currentTime;

            adcLowBits = null;
            adcHighBits = null;
            notifyListeners();
          }
        }
      }
    });
  }

  void closePort() async {
    if (readTimer != null) {
      readTimer!.cancel();
      readTimer = null;
    }

    if (selectedPort != null) {
      if (selectedPort!.isOpened) {
        print("Schliesse Port ${selectedPort!.portName}...");
        await Future.delayed(Duration(milliseconds: 100));
        selectedPort!.close();
      }
      selectedPort = null;
    }

    if (!dataController.isClosed) {
      dataController.close();
    }
    ch1_data = [FlSpot(0, 0)];
    ch2_data = [FlSpot(0, 0)];

    ref1_data = [FlSpot(0, 0)];
    ref2_data = [FlSpot(0, 0)];
    ref3_data = [FlSpot(0, 0)];
    stopwatch.reset();

    notifyListeners();
  }
}
