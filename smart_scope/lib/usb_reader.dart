import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:serial_port_win32/serial_port_win32.dart';
import 'pages/settings_pages/settings_widgets/definitions.dart';
import 'package:provider/provider.dart';
import 'pages/settings_pages/measurements_widgets/definitionMeasurements.dart';

class UsbProvider extends ChangeNotifier {
  late AppState appState;

  void setAppState(AppState newAppState) {
    appState = newAppState;
  }

  late MeasurementsChanges measurementState;

  void setMeasurementState(MeasurementsChanges newMeasurementState) {
    measurementState = newMeasurementState;
  }

  SerialPort? selectedPort;
  StreamController<String> dataController =
      StreamController<String>.broadcast();
  Timer? readTimer;
  String receivedData = "";
  final Stopwatch stopwatch = Stopwatch();

  List<FlSpot> ch1_data = [FlSpot(0, 0)];
  List<FlSpot> ch2_data = [FlSpot(0, 0)];

  List<double> last_dataFromChannel = [0, 0];
  List<double> last_timeFromChannel = [0, 0];

  List<List<FlSpot>> get dataChannelLists => [ch1_data, ch2_data];

  double currentTime = 0;
  List<double> lastSample = [0, 0];
  double triggeredTime = 0;
  double cutoff = 0;
  List<double> voltageValue_uV_fromChannel = [0, 0];

  double minStoppedRoleTime = -1;
  double maxStoppedRoleTime = 0;

  static const double samplesPerDivision = 500;

  List<int> selectedMessbereichIndex = [0,0];
  final List<int> messbereiche = [50, 25, 10, 5, 1];
  bool singleTrigger = false;
  bool initiateMeasurement = true;

  List<double> averageVoltage = [0, 0];
  List<bool> initiateOffsetCalculation = [false, false];

  List<int> autoTriggerAnalyzed = [0, 0];
  List<double> LastTriggerTime = [0, 0];
  List<bool> autoTriggerRangeGenerator = [false, false];

  restartAutoTrigger() {
    autoTriggerRangeGenerator[0] = false;
    autoTriggerRangeGenerator[1] = false;
    autoTriggerAnalyzed[0] = 0;
    autoTriggerAnalyzed[1] = 0;
  }

  set_DC_offset(int channel, double dcoffsetUv) {
    if (channels[channel] == selectedTriggerChannel) {
      if (!channels[channel].channelIsDC) {
        appState.updateTriggerVerticalOffset(
          appState.triggerVerticalOffset - dcoffsetUv,
        );
      } else {
        appState.updateTriggerVerticalOffset(
          appState.triggerVerticalOffset + averageVoltage[channel],
        );
      }
    }
    averageVoltage[channel] = dcoffsetUv;
  }

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
            initiateMeasurement = true;
            // print("TrHor: ${appState.triggerHorizontalOffset}");
            // print("TrVer: ${voltageValue_uV_fromChannel[channel]}");
            appState.updateGraphTimeValue(
              triggeredTime - appState.triggerHorizontalOffset,
            );

            // Neue Berechnungen der Messdaten
            // measurementState.updateMeasurementData();
            if (selecetTriggerModeIndex == 1) {
              singleTrigger = true;
              initiateMeasurement = true;
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
            initiateMeasurement = true;
            // print("TrHor: ${appState.triggerHorizontalOffset}");
            appState.updateGraphTimeValue(
              triggeredTime - appState.triggerHorizontalOffset,
            );
            // Neue Berechnungen der Messdaten
            // measurementState.updateMeasurementData();
            if (selecetTriggerModeIndex == 1) {
              singleTrigger = true;
              print('singleTrigger');
            }
          }
        }
      }
    } else if (singleTrigger == true) {
      if (currentTime > appState.maxGraphTimeValue) {
        singleTrigger == false;
        selecetTriggerStateIndex = 1;
        // Neue Berechnungen der Messdaten
        print("updateMeasurementData_single");
        measurementState.updateMeasurementData();
      }
    }
    if ((currentTime >=
        ((triggeredTime - appState.triggerHorizontalOffset) +
            (appState.timeValue * 6)))) {
      if (initiateMeasurement) {
        // Neue Berechnungen der Messdaten
        // print("updateMeasurementData_normal");
        measurementState.update_measCH1_offset();
        measurementState.update_measCH2_offset();
        measurementState.updateMeasurementData();
        initiateMeasurement = false;
      }
    }
  }

  void clearPlot() {
    stopwatch.reset();
    currentTime = 0;
    triggeredTime = 0;
    lastSample[0] = 0;
    lastSample[1] = 0;
    stopwatch.start();
    ch1_data = [FlSpot(0, 0)];
    ch2_data = [FlSpot(0, 0)];
    minStoppedRoleTime = -1;
    maxStoppedRoleTime = 0;
    measurementState.updateCH1Data();

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

      minStoppedRoleTime = -1;
      maxStoppedRoleTime = 0;

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
          if (adcLowBits != null && adcHighBits != null) {
            adcValue = (adcHighBits << 6) | adcLowBits;

            if ((currentTime - lastSample[channel]) >=
                (appState.timeValue / samplesPerDivision)) {
              // print("NewSample");
              lastSample[channel] = currentTime;

              // Spannungswert wird hier berechnet
              // voltageValue_uV_fromChannel[channel] =
              //     (adcValue.toDouble() *
              //         2 *
              //         (1.5 * 1000000) /
              //         4096.0); // adcValue * (2 * Messbereich in uV) / 0xFFF
              if (selectedMessbereichIndex[channel] == 5) {
                if (channels[channel].channelIsDC) {
                  voltageValue_uV_fromChannel[channel] =
                      (adcValue.toDouble() *
                          (messbereiche[selectedMessbereichIndex[channel]] * 1000000) /
                          4096.0);
                } else {
                  print("ac_only");
                  voltageValue_uV_fromChannel[channel] =
                      ((adcValue.toDouble() *
                              (messbereiche[selectedMessbereichIndex[channel]] *
                                  1000000) /
                              4096.0) -
                          (averageVoltage[channel]));
                }
              } else {
                // Spannungswert wird hier berechnet
                if (channels[channel].channelIsDC) {
                  voltageValue_uV_fromChannel[channel] =
                      ((adcValue.toDouble() *
                              2 *
                              (messbereiche[selectedMessbereichIndex[channel]] *
                                  1000000) /
                              4096.0) -
                          (messbereiche[selectedMessbereichIndex[channel]] * 1000000));
                } else {
                  voltageValue_uV_fromChannel[channel] =
                      (((adcValue.toDouble() *
                                  2 *
                                  (messbereiche[selectedMessbereichIndex[channel]] *
                                      1000000) /
                                  4096.0) -
                              (messbereiche[selectedMessbereichIndex[channel]] *
                                  1000000)) -
                          (averageVoltage[channel]));
                }
              }

              if (!((selecetTriggerModeIndex == 3) &&
                  (selecetTriggerStateIndex == 1))) {
                if (channel == 0) {
                  if (channel1.ChannelIs1to1) {
                    dataChannelLists[0].add(
                      FlSpot(currentTime, voltageValue_uV_fromChannel[0]),
                    );
                  } else {
                    voltageValue_uV_fromChannel[0] =
                        voltageValue_uV_fromChannel[0] * 10;
                    dataChannelLists[0].add(
                      FlSpot(currentTime, (voltageValue_uV_fromChannel[0])),
                    );
                  }
                } else if (channel == 1) {
                  if (channel2.ChannelIs1to1) {
                    dataChannelLists[1].add(
                      FlSpot(currentTime, voltageValue_uV_fromChannel[1]),
                    );
                  } else {
                    voltageValue_uV_fromChannel[1] =
                        voltageValue_uV_fromChannel[1] * 10;
                    dataChannelLists[1].add(
                      FlSpot(currentTime, (voltageValue_uV_fromChannel[1])),
                    );
                  }
                }
              }

              if (selecetTriggerStateIndex == 0) {
                if (selecetTriggerModeIndex == 3) {
                  // Roll Mode
                  // Graph Range is being adjusted in monitoring_page

                  // cutoff calculated for Roll Mode
                  cutoff =
                      currentTime - (appState.timeValue * ((NOF_xGrids + 1)));

                  dataChannelLists[channel].removeWhere(
                    (point) => point.x < (cutoff),
                  );
                } else {
                  // Trigger Event
                  if (selecetTriggerModeIndex == 2) {
                    // Normal Trigger
                    triggeringSignal(channel);
                  } else if (selecetTriggerModeIndex == 1) {
                    // Single_trigger
                    triggeringSignal(channel);
                  } else if (selecetTriggerModeIndex == 0) {
                    // Auto Trigger
                    bool triggerDetected = false;
                    if (channels[channel] == selectedTriggerChannel) {
                      if (channels[channel] == selectedTriggerChannel) {
                        if (risingTriggerSelected) {
                          if ((last_dataFromChannel[channel] <=
                                  appState.triggerVerticalOffset) &&
                              (appState.triggerVerticalOffset <
                                  voltageValue_uV_fromChannel[channel])) {
                            print("autoTriggerd_rising");
                            triggerDetected = true;
                          }
                        } else {
                          if ((last_dataFromChannel[channel] >
                                  appState.triggerVerticalOffset) &&
                              (appState.triggerVerticalOffset >=
                                  voltageValue_uV_fromChannel[channel])) {
                            print("autoTriggerd_falling");
                            triggerDetected = true;
                          }
                        }

                        if (triggerDetected) {
                          triggeredTime =
                              (currentTime + last_timeFromChannel[channel]) / 2;
                          initiateMeasurement = true;
                          appState.updateGraphTimeValue(
                            triggeredTime - appState.triggerHorizontalOffset,
                          );
                          if (autoTriggerAnalyzed[channel] < 3) {
                            print("trigger++");
                            autoTriggerAnalyzed[channel]++;
                          }
                        } else {
                          if ((currentTime - triggeredTime) >
                              (appState.timeValue * 13)) {
                            triggeredTime = currentTime;
                            appState.updateGraphTimeValue(
                              triggeredTime - appState.triggerHorizontalOffset,
                            );
                            print("Auto-Trigger ausgelöst");
                            autoTriggerAnalyzed[channel]++;
                          }
                        }
                        if (!autoTriggerRangeGenerator[channel]) {
                          // second autoTrigger
                          if (autoTriggerAnalyzed[channel] == 2) {
                            LastTriggerTime[channel] = triggeredTime;
                          }
                          // third autoTrigger
                          else if (autoTriggerAnalyzed[channel] >= 3) {
                            if (dataChannelLists[channel].isNotEmpty) {
                              double minY1 = dataChannelLists[0]
                                  .map((p) => p.y)
                                  .reduce((a, b) => a < b ? a : b);
                              double maxY1 = dataChannelLists[0]
                                  .map((p) => p.y)
                                  .reduce((a, b) => a > b ? a : b);

                              double minY2 = dataChannelLists[1]
                                  .map((p) => p.y)
                                  .reduce((a, b) => a < b ? a : b);
                              double maxY2 = dataChannelLists[1]
                                  .map((p) => p.y)
                                  .reduce((a, b) => a > b ? a : b);

                              print("Kanal 1 - MinY: $minY1, MaxY: $maxY1");
                              print("Kanal 2 - MinY: $minY2, MaxY: $maxY2");
                              print(
                                'time/div ${(triggeredTime - LastTriggerTime[channel]) / 5}',
                              );

                              appState.updateSliderValue_ch1(
                                (maxY1 - minY1) / 6,
                              );
                              appState.updateSliderValue_ch2(
                                (maxY2 - minY2) / 6,
                              );
                              appState.updatedCH1_LevelOffset(
                                -(((maxY1 - minY1) / 2) + minY1),
                              );
                              appState.updatedCH2_LevelOffset(
                                -(((maxY2 - minY2) / 2) + minY2),
                              );

                              appState.updateTimeValue(
                                (triggeredTime - LastTriggerTime[channel]) / 5,
                              );

                              autoTriggerRangeGenerator[channel] = true;
                            }
                          }
                        }
                      }
                    }
                  }
                }
              } else if (selecetTriggerStateIndex == 2) {
                stopwatch.reset();
                currentTime = 0;
                triggeredTime = 0;
                lastSample[0] = 0;
                lastSample[1] = 0;
                minStoppedRoleTime = -1;
                maxStoppedRoleTime = 0;
              }
            }

            if (selecetTriggerModeIndex != 3) {
              // cutoff for Trigger Modes
              cutoff =
                  (triggeredTime - appState.triggerHorizontalOffset) -
                  (appState.timeValue * ((NOF_xGrids / 2) + 1));

              // // Cutoff of old data
              dataChannelLists[channel].removeWhere(
                (point) => point.x < (cutoff),
              );

              // cutoff new data when triggering which out of range
              dataChannelLists[channel].removeWhere(
                (point) =>
                    ((point.x > appState.maxGraphTimeValue) &&
                        (point.x <
                            ((currentTime - appState.triggerHorizontalOffset) -
                                (appState.timeValue *
                                    ((NOF_xGrids / 2) + 1))))),
              );
            }
            // print('Stored Data Points ${dataChannelLists[channel].length}');

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
    measurementState.updateCH1Data();

    stopwatch.reset();
    currentTime = 0;
    triggeredTime = 0;
    lastSample[0] = 0;
    lastSample[1] = 0;

    minStoppedRoleTime = -1;
    maxStoppedRoleTime = 0;

    autoTriggerAnalyzed[0] = 0;
    autoTriggerAnalyzed[1] = 0;
    LastTriggerTime[0] = 0;
    LastTriggerTime[1] = 0;
    autoTriggerRangeGenerator[0] = false;
    autoTriggerRangeGenerator[1] = false;

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

  void stoppedInRoleMode() {
    minStoppedRoleTime = (currentTime - (NOF_xGrids * appState.timeValue));
    maxStoppedRoleTime = currentTime;
  }
}
