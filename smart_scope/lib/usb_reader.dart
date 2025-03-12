import 'dart:async';
import 'dart:typed_data';
import 'package:serial_port_win32/serial_port_win32.dart';
import 'pages/settings_pages/settings_widgets/definitions.dart';

StreamController<String> dataController = StreamController<String>.broadcast();
Timer? readTimer;
String receivedData = "";

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
      print("Empfangene Daten: $receivedString");
      if (!dataController.isClosed) {
        dataController.add(receivedString);
      } else {
        print("Controller closed");
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
