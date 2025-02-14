import 'package:flutter/material.dart';
import 'definitions.dart';

bool isCH1_activated = false;
void ch1_pressed() {
  if (isCH1_activated) {
    isCH1_activated = false;
    print("CH1_Disabled");
  } else {
    isCH1_activated = true;
    print("CH1_Activated");
  }
}

bool isCH2_activated = false;
void ch2_pressed() {
  if (isCH2_activated) {
    isCH2_activated = false;
    print("CH2_Disabled");
  } else {
    isCH2_activated = true;
    print("CH2_Activated");
  }
}

class ChannelEnable extends StatefulWidget {
  const ChannelEnable({super.key});

  @override
  State<ChannelEnable> createState() => _ChannelEnableState();
}

class _ChannelEnableState extends State<ChannelEnable> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 115,
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Aciviate Channel",
                style: TextStyle(
                  fontFamily: 'PrimaryFont',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: isCH1_activated ? ch1Color : clear,
                ),
                onPressed: () {
                  setState(() {
                    ch1_pressed();
                  });
                },
                child: Text(
                  "CH1",
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: isCH1_activated ? Colors.black : ch1Color,
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: isCH2_activated ? ch2Color : clear,
                ),
                onPressed: () {
                  setState(() {
                    ch2_pressed();
                  });
                },
                child: Text(
                  "CH2",
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: isCH2_activated ? Colors.black : ch2Color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
