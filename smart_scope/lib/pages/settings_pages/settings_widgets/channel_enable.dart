import 'package:flutter/material.dart';
import 'definitions.dart';
import 'package:provider/provider.dart';

class ChannelEnable extends StatefulWidget {
  const ChannelEnable({super.key});

  @override
  State<ChannelEnable> createState() => _ChannelEnableState();
}

class _ChannelEnableState extends State<ChannelEnable> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  backgroundColor:
                      channel1.channelIsActive ? channel1.channelColor : clear,
                ),
                onPressed: () {
                  setState(() {
                    Provider.of<AppState>(context, listen: false).ch1_pressed();
                  });
                },
                child: Text(
                  "CH1",
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: ActivateChannelFontSize,
                    color:
                        channel1.channelIsActive
                            ? ChannelSelected_fontColor
                            : channel1.channelColor,
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
                  backgroundColor:
                      channel2.channelIsActive ? channel2.channelColor : clear,
                ),
                onPressed: () {
                  setState(() {
                    Provider.of<AppState>(context, listen: false).ch2_pressed();
                  });
                },
                child: Text(
                  "CH2",
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: ActivateChannelFontSize,
                    color:
                        channel2.channelIsActive
                            ? ChannelSelected_fontColor
                            : channel2.channelColor,
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
