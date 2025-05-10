import 'dart:async';
import 'package:flutter/material.dart';
import 'package:serial_port_win32/serial_port_win32.dart';
import 'settings_pages/settings_widgets/definitions.dart';
import 'package:smart_scope/usb_reader.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

class USB_Select extends StatefulWidget {
  const USB_Select({super.key});

  @override
  State<USB_Select> createState() => _USB_SelectState();
}

class _USB_SelectState extends State<USB_Select> {
  List<String> availablePorts = [];
  Timer? updatePortsTimer;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    updatePorts();
  }

  void updatePorts() {
    updatePortsTimer = Timer.periodic(Duration(milliseconds: 250), (timer) {
      setState(() {
        availablePorts = SerialPort.getAvailablePorts();
        print("Available Ports: $availablePorts");
      });
    });
  }

  void switchToMonitorPage() {
    updatePortsTimer?.cancel();
    Navigator.pushReplacementNamed(context, '/HomePage');
  }

  void pressedPortSelector(String currentPort) {
    print('$currentPort selected');

    selectedPort = SerialPort(
      currentPort,
      openNow: false,
      ByteSize: 8,
      BaudRate: 9600,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final usb = Provider.of<UsbProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        toolbarHeight: 125,
        centerTitle: false,
        title: Text(
          'SmartScope',
          style: TextStyle(
            fontFamily: 'PrimaryFont',
            fontWeight: FontWeight.bold,
            fontSize: 80,
          ),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Row(
                  children: [
                    SizedBox(width: 100),
                    AutoSizeText(
                      "IDPA 2025 TBM GBC",
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'PrimaryFont',
                        fontWeight: FontWeight.normal,
                        fontSize: screenHeight * 0.021987,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(width: 100),
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'images/logo_pmod.png',
                        height: screenHeight * 0.03518,
                      ),
                      AutoSizeText(
                        "Hardware:",
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'PrimaryFont',
                          fontWeight: FontWeight.normal,
                          fontSize: screenHeight * 0.01319,
                          color: Colors.black,
                        ),
                      ),
                      AutoSizeText(
                        "Karim El Sammra",
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'PrimaryFont',
                          fontWeight: FontWeight.normal,
                          fontSize: screenHeight * 0.01319,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'images/logo_trumpf.png',
                        height: screenHeight * 0.039578,
                      ),
                      AutoSizeText(
                        "Firmware:",
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'PrimaryFont',
                          fontWeight: FontWeight.normal,
                          fontSize: screenHeight * 0.01319,
                          color: Colors.black,
                        ),
                      ),
                      AutoSizeText(
                        "Milan Davitkov",
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'PrimaryFont',
                          fontWeight: FontWeight.normal,
                          fontSize: screenHeight * 0.01319,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Image.asset(
                        'images/logo_viega.jpg',
                        height: screenHeight * 0.039578,
                      ),
                      AutoSizeText(
                        "Software:",
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'PrimaryFont',
                          fontWeight: FontWeight.normal,
                          fontSize: screenHeight * 0.01319,
                          color: Colors.black,
                        ),
                      ),
                      AutoSizeText(
                        "Dominic Knöpfel",
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'PrimaryFont',
                          fontWeight: FontWeight.normal,
                          fontSize: screenHeight * 0.01319,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidth * 0.20833333, // 400,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            AutoSizeText(
                              "Available Ports",
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'PrimaryFont',
                                fontSize: 50,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.439753, // 500,
                              width: screenWidth * 0.20833333, // 400,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: AppBarBackroundColor,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: MonitorBackroundColor,
                                    width: 2,
                                  ),
                                ),
                                child: Scrollbar(
                                  controller: _scrollController,
                                  scrollbarOrientation:
                                      ScrollbarOrientation.right,
                                  thumbVisibility: true,
                                  thickness: 15.0,
                                  trackVisibility: false,
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount: availablePorts.length,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onDoubleTap: () {
                                                pressedPortSelector(
                                                  availablePorts[index],
                                                );
                                                usb.openPort(availablePorts[index]);
                                                switchToMonitorPage();
                                              },
                                              child: TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStatePropertyAll(
                                                        selectedPort?.portName ==
                                                                availablePorts[index]
                                                            ? MonitorBackroundColor
                                                            : Colors
                                                                .transparent,
                                                      ),
                                                  animationDuration:
                                                      Duration.zero,
                                                  splashFactory:
                                                      NoSplash.splashFactory,
                                                ),
                                                onPressed: () {
                                                  pressedPortSelector(
                                                    availablePorts[index],
                                                  );
                                                },
                                                child: Text(
                                                  availablePorts[index],
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
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: selectedPort != null ? 30 : 0,
                                  width: selectedPort != null ? 100 : 0,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      usb.openPort(selectedPort!.portName);
                                      switchToMonitorPage();
                                    },
                                    backgroundColor: Colors.grey[400],
                                    hoverColor: Colors.grey[450],
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
          ),
        ],
      ),
    );
  }
}
