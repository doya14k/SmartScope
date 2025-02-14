import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final int MonitorSizePercentage = 62;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: MonitorSizePercentage,
            child: Container(
              color: Colors.grey[400],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'images/oscilloscope_signal.jpg',
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: (100 - MonitorSizePercentage),
            child: Container(
              color: Colors.grey[300],
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: SettingsMenu(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Test1",
      style: TextStyle(fontFamily: 'PrimaryFont', color: Colors.black),
    );
  }
}
