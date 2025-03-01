import 'package:flutter/material.dart';
import 'package:serial_port_win32/serial_port_win32.dart';
import 'home_page.dart';
import 'dart:async';

class USB_Select extends StatefulWidget {
  const USB_Select({super.key});

  @override
  State<USB_Select> createState() => _USB_SelectState();
}

class _USB_SelectState extends State<USB_Select> {
  List<String> ports = [];

  @override
  void initState() {
    super.initState();
    updatePorts(); 
  }

  void updatePorts() {
    Timer.periodic(Duration(milliseconds: 250), (timer) {
      setState(() {
      ports = SerialPort.getAvailablePorts();
      print("Aktualisierte Ports: $ports");
      }
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: FloatingActionButton(
              child: Text("Switch"),

              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ),

          Center(
            child: Column(
              children: [
                Text(
                  'Available Ports:',
                  style: TextStyle(fontFamily: 'PrimaryFont', fontSize: 40.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${ports.join("\n")}',
                      style: TextStyle(
                        fontFamily: 'PrimaryFont',
                        fontSize: 40.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
