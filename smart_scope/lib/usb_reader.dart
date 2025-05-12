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
  List<double> lastSample = [0, 0];
  double triggeredTime = 0;
  double cutoff = 0;
  List<double> voltageValue_uV_fromChannel = [0, 0];

  static const double samplesPerDivision = 1000;

  int selectedMessbereichIndex = 0;
  final List<int> messbereiche = [50, 25, 10, 5, 1];
  bool singleTrigger = false;

  void triggeringSignal(int channel) {
    if (singleTrigger == false) {
      if (channels[channel] == selectedTriggerChannel) {
        if (risingTriggerSelected) {
          if ((last_dataFromChannel[channel] <=
                  appState.triggerVerticalOffset) &&
              (appState.triggerVerticalOffset <
                  voltageValue_uV_fromChannel[channel])) {
            triggeredTime = (currentTime + last_timeFromChannel[channel]) / 2;
            print("Trigger pos");
            print("TrHor: ${appState.triggerHorizontalOffset}");
            appState.updateGraphTimeValue(
              triggeredTime - appState.triggerHorizontalOffset,
            );
            if (selecetTriggerModeIndex == 1) {
              // selecetTriggerStateIndex = 1;
              singleTrigger = true;
              print('singleTrigger');
            }
          }
        } else if (!risingTriggerSelected) {
          if ((last_dataFromChannel[channel] >
                  appState.triggerVerticalOffset) &&
              (appState.triggerVerticalOffset >=
                  voltageValue_uV_fromChannel[channel])) {
            triggeredTime = (currentTime + last_timeFromChannel[channel]) / 2;
            print("Trigger neg");
            print("TrHor: ${appState.triggerHorizontalOffset}");
            appState.updateGraphTimeValue(
              triggeredTime - appState.triggerHorizontalOffset,
            );
            if (selecetTriggerModeIndex == 1) {
              singleTrigger = true;
              print('singleTrigger');
            }
          }
        }
      }
    }
    if (singleTrigger == true) {
      if (currentTime > appState.maxGraphTimeValue) {
        singleTrigger == false;
        selecetTriggerStateIndex = 1;
      }
    }
  }

  void clearPlot() {
    stopwatch.reset();
    lastSample[0] = 0;
    lastSample[1] = 0;
    stopwatch.start();
    ch1_data = [FlSpot(0, 0)];
    ch2_data = [FlSpot(0, 0)];
    singleTrigger = false;
    appState.updateGraphTimeValue(appState.timeValue * (NOF_xGrids / 2));

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
      lastSample[0] = 0;
      lastSample[1] = 0;
      stopwatch.start();
      startReading();
    } else {
      print("Fehler beim Öffnen des Ports $portName");
    }
  }

  void startReading() {
    if (selectedPort == null || !selectedPort!.isOpened) return;
    singleTrigger = false;

    readTimer = Timer.periodic(Duration(microseconds: 1), (timer) async {
      Uint8List? data = await selectedPort!.readBytes(
        64,
        timeout: Duration(microseconds: 1),
      );

      if (data.isNotEmpty) {
        // String receivedString = String.fromCharCodes(data).trim();
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
          currentTime = stopwatch.elapsedMicroseconds.toDouble();
          double sampleInterval =
              (appState.timeValue / samplesPerDivision); //10;

          if (adcLowBits != null && adcHighBits != null) {
            adcValue = (adcHighBits << 6) | adcLowBits;

            if ((lastSample[channel] <= (currentTime - sampleInterval))) {
              //   print(
              //     "CurrentTime: $currentTime, lastSample $lastSample, SampleInterval: $sampleInterval, Channel $channel",
              //   );
              // print("NewSample");
              lastSample[channel] = currentTime;

              // Spannungswert wird hier berechnet
              voltageValue_uV_fromChannel[channel] =
                  (adcValue.toDouble() *
                      2 *
                      (1.5 * 1000000) /
                      4096.0); // adcValue * (2 * Messbereich in uV) / 0xFFF

              if (selecetTriggerStateIndex == 0) {
                dataChannelLists[channel].add(
                  FlSpot(currentTime, voltageValue_uV_fromChannel[channel]),
                );
                if (selecetTriggerModeIndex == 3) {
                  // cutoff calculated for Roll Mode
                  cutoff =
                      currentTime - (appState.timeValue * (NOF_xGrids + 1));
                  // Roll Mode
                  // Graph Range is being adjusted in monitoring_page
                } else if (selecetTriggerModeIndex == 2) {
                  // Normal Trigger
                  triggeringSignal(channel);
                } else if (selecetTriggerModeIndex == 1) {
                  // Single_trigger
                  triggeringSignal(channel);
                } else if (selecetTriggerModeIndex == 0) {
                  // Auto Trigger
                }

                // cutoff for Trigger Modes
                cutoff =
                    (triggeredTime - appState.triggerHorizontalOffset) -
                    (appState.timeValue * ((NOF_xGrids / 2) + 1));
              } else if (selecetTriggerStateIndex == 1) {
                stopwatch.reset();
                lastSample[0] = 0;
                lastSample[1] = 0;
              }
            }

            // Cutoff of old data
            dataChannelLists[0].removeWhere((point) => point.x < cutoff);
            dataChannelLists[1].removeWhere((point) => point.x < cutoff);

            // Remove the first dummy point
            if (dataChannelLists[0].length >= 2) {
              dataChannelLists[0].removeWhere((point) => point.x == 0);
            }
            if (dataChannelLists[1].length >= 2) {
              dataChannelLists[1].removeWhere((point) => point.x == 0);
            }
            last_dataFromChannel[channel] =
                voltageValue_uV_fromChannel[channel];
            last_timeFromChannel[channel] = currentTime;

            // print(
            //   'minX ${appState.minGraphTimeValue}, maxX ${appState.maxGraphTimeValue}, minY ${appState.minGraphVoltageValueCH1}, maxY ${appState.maxGraphVoltageValueCH1}',
            // );

            adcLowBits = null;
            adcHighBits = null;
            notifyListeners();
          }
        }
      }
    });
  }

  void closePort() async {
    ch1_data = [FlSpot(0, 0)];
    ch2_data = [FlSpot(0, 0)];

    ref1_data = [FlSpot(0, 0)];
    ref2_data = [FlSpot(0, 0)];
    ref3_data = [FlSpot(0, 0)];
    stopwatch.reset();
    lastSample[0] = 0;
    lastSample[1] = 0;

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

    notifyListeners();
  }
}
