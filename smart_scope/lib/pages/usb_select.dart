import 'package:flutter/material.dart';
import 'package:serial_port_win32/serial_port_win32.dart';
// import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'home_page.dart';
import 'dart:async';
import 'settings_pages/settings_widgets/definitions.dart';

class USB_Select extends StatefulWidget {
  const USB_Select({super.key});

  @override
  State<USB_Select> createState() => _USB_SelectState();
}

class _USB_SelectState extends State<USB_Select> {
  List<String> availablePorts = [];
  Timer? updatePortsTimer;

  @override
  void initState() {
    super.initState();
    updatePorts();
  }

  void updatePorts() {
    updatePortsTimer = Timer.periodic(Duration(milliseconds: 250), (timer) {
      setState(() {
        availablePorts = SerialPort.getAvailablePorts();
        // availablePorts = SerialPort.availablePorts;
        print("Aktualisierte Ports: $availablePorts");
      });
    });
  }

  void switchToMonitorPage() {
    updatePortsTimer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void pressedPortSelector(currentPort) {
    print('${currentPort} selected');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        toolbarHeight: 120,
        centerTitle: false,
        title: Text(
          'SmartScope',
          style: TextStyle(
            fontFamily: 'PrimaryFont',
            fontWeight: FontWeight.bold,
            fontSize: 80,
          ),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Available Ports",
                        style: TextStyle(
                          fontFamily: 'PrimaryFont',
                          fontSize: 50,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 500,
                        width: 400,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppBarBackroundColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: MonitorBackroundColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                availablePorts
                                    .map(
                                      (currentPort) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onDoubleTap: () {
                                                switchToMonitorPage();
                                              },
                                              child: TextButton(
                                                onPressed: () {
                                                  pressedPortSelector(
                                                    currentPort,
                                                  );
                                                },
                                                child: Text(
                                                  '${currentPort}',
                                                  style: TextStyle(
                                                    fontSize: 40,
                                                    fontFamily: 'PrimaryFont',
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 30,
                            width: 100,
                            child: FloatingActionButton(
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                  fontFamily: 'PrimaryFont',
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: 1,
                                ),
                              ),
                              onPressed: () {
                                switchToMonitorPage();
                              },
                              backgroundColor: Colors.grey[400],
                              hoverColor: Colors.grey[450],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
