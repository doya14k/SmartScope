import 'package:auto_size_text/auto_size_text.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.143,
      child: Card(
        color: ChannelEnableBackgroundColor,
        child: Container(
          margin: EdgeInsets.all(screenHeight * 0.00439),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Aciviate Channel",
                style: TextStyle(
                  fontFamily: 'PrimaryFont',
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.0132,
                ),
              ),
              SizedBox(height: screenHeight * 0.00876),
              // .-----------------.
              // |  ____ _   _   _ |
              // | / ___| | | | / ||
              // || |   | |_| | | ||
              // || |___|  _  | | ||
              // | \____|_| |_| |_||
              // '-----------------'
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(screenWidth * 0.0625, screenHeight * 0.044),
                  backgroundColor:
                      channel1.channelIsActive ? channel1.channelColor : clear,
                ),
                onPressed: () {
                  setState(() {
                    Provider.of<AppState>(context, listen: false).ch1_pressed();
                  });
                },
                child: AutoSizeText(
                  "CH1",
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.0305,
                    color:
                        channel1.channelIsActive
                            ? ChannelSelected_fontColor
                            : channel1.channelColor,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.00876),
              // .---------------------.
              // |  ____ _   _   ____  |
              // | / ___| | | | |___ \ |
              // || |   | |_| |   __) ||
              // || |___|  _  |  / __/ |
              // | \____|_| |_| |_____||
              // '---------------------'
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(screenWidth * 0.0625, screenHeight * 0.044),
                  backgroundColor:
                      channel2.channelIsActive ? channel2.channelColor : clear,
                ),
                onPressed: () {
                  setState(() {
                    Provider.of<AppState>(context, listen: false).ch2_pressed();
                  });
                },
                child: AutoSizeText(
                  "CH2",
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.0305,
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
