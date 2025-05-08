import 'dart:async';
import 'dart:typed_data';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:serial_port_win32/serial_port_win32.dart';
import 'pages/settings_pages/settings_widgets/definitions.dart';
import 'pages/monitoring_page.dart';
import 'package:provider/provider.dart';

StreamController<String> dataController = StreamController<String>.broadcast();
Timer? readTimer;
String receivedData = "";
var stopwatch;

void openPort(String portName) {
  if (selectedPort != null && selectedPort!.isOpened) {
    return;
  }

  selectedPort = SerialPort(portName, openNow: true, BaudRate: 9600);
  selectedPort?.open();

  dataController = StreamController<String>.broadcast();
  dataController.stream.listen((data) {
    receivedData = data; // UI aktualisieren, wenn neue Daten kommen
  });

  if (selectedPort!.isOpened) {
    print("Port $portName erfolgreich geöffnet!");
    stopwatch = Stopwatch()..start();
    startReading();
  } else {
    print("Fehler beim Öffnen des Ports $portName");
  }
}

void startReading() {
  if (selectedPort == null || !selectedPort!.isOpened) {
    return;
  }

  print("is acitve");
  readTimer = Timer.periodic(Duration(microseconds: 1), (timer) async {
    Uint8List? data = await selectedPort!.readBytes(
      64,
      timeout: Duration(microseconds: 1),
    );

    if (data.isNotEmpty) {
      String receivedString = String.fromCharCodes(data).trim();
      int? adcValue = 0;
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
              (adcValue.toDouble() * 2 * (1.5 * 1000000) / 4096.0) - (1.5 * 1000000);

          print("CH${channel + 1} ADC: ${voltageValue_uV}");

          // Daten zum Graphen hinzufügen
          dataChannel_lists[channel].add(
            FlSpot(
              (stopwatch.elapsedMicroseconds.toDouble()),
              (voltageValue_uV),
            ),
          );

          adcLowBits = null;
          adcHighBits = null;
        }

        if (!dataController.isClosed) {
          dataController.add(receivedString);
        } else {
          print("Controller closed");
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
    } else {}
    selectedPort = null;
  }

  if (!dataController.isClosed) {
    dataController.close();
  }
}
