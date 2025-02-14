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
    return Container(
      height:
          (5 +
              ActivateChannelFont_Size +
              CH_Enable_sizedBoxHeight +
              CH_Enable_height +
              CH_Enable_sizedBoxHeight +
              CH_Enable_height +
              5 +
              15),
      child: Card(
        color: ChannelEnableBackgroundColor,
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
                  fontSize: ActivateChannelFont_Size,
                ),
              ),
              SizedBox(height: CH_Enable_sizedBoxHeight),
              // .-----------------.
              // |  ____ _   _   _ |
              // | / ___| | | | / ||
              // || |   | |_| | | ||
              // || |___|  _  | | ||
              // | \____|_| |_| |_||
              // '-----------------'
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(CH_Enable_width, CH_Enable_height),
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
                    fontSize: ActivateChannelFontSize,
                    color:
                        isCH1_activated ? ChannelSelected_fontColor : ch1Color,
                  ),
                ),
              ),
              SizedBox(height: CH_Enable_sizedBoxHeight),
              // .---------------------.
              // |  ____ _   _   ____  |
              // | / ___| | | | |___ \ |
              // || |   | |_| |   __) ||
              // || |___|  _  |  / __/ |
              // | \____|_| |_| |_____||
              // '---------------------'
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(CH_Enable_width, CH_Enable_height),
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
                    fontSize: ActivateChannelFontSize,
                    color:
                        isCH2_activated ? ChannelSelected_fontColor : ch2Color,
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
