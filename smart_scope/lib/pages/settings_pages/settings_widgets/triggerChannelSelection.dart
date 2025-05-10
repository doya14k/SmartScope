import 'package:flutter/material.dart';
import 'definitions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

class TriggerChannelSelection extends StatefulWidget {
  const TriggerChannelSelection({super.key});

  @override
  State<TriggerChannelSelection> createState() =>
      _TriggerChannelSelectionState();
}

class _TriggerChannelSelectionState extends State<TriggerChannelSelection> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth * 0.104,
      height: screenHeight * 0.242,
      child: Card(
        color: ChannelEnableBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(),
                AutoSizeText(
                  "Trigger",
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.01759,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                  maxLines: 1,
                ),
                Spacer(flex: 7),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(
                      screenWidth * 0.04167,
                      screenHeight * 0.05277,
                    ),
                    backgroundColor:
                        (selectedTriggerChannel == channels[0])
                            ? channel1.channelColor
                            : clear,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedTriggerChannel = channels[0];
                      Provider.of<AppState>(
                        context,
                        listen: false,
                      ).updateTriggeredChannel(channels[0]);
                    });
                  },
                  child: AutoSizeText(
                    "CH1",
                    minFontSize: 1,
                    style: TextStyle(
                      fontFamily: 'PrimaryFont',
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.044,
                      color:
                          (selectedTriggerChannel == channels[0])
                              ? ChannelSelected_fontColor
                              : channel1.channelColor,
                    ),
                    maxLines: 1,
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(
                      screenWidth * 0.04167,
                      screenHeight * 0.05277,
                    ),
                    backgroundColor:
                        (selectedTriggerChannel == channels[1])
                            ? channel2.channelColor
                            : clear,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedTriggerChannel = channels[1];
                      Provider.of<AppState>(
                        context,
                        listen: false,
                      ).updateTriggeredChannel(channels[1]);
                    });
                  },
                  child: AutoSizeText(
                    "CH2",
                    minFontSize: 1,
                    style: TextStyle(
                      fontFamily: 'PrimaryFont',
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.044,
                      color:
                          (selectedTriggerChannel == channels[1])
                              ? ChannelSelected_fontColor
                              : channel2.channelColor,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/rising_edge.png',
                  width: screenWidth * 0.0156,
                  height: screenHeight * 0.02638,
                  opacity:
                      (risingTriggerSelected)
                          ? AlwaysStoppedAnimation(1)
                          : AlwaysStoppedAnimation(0.25),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: SizedBox(
                    width: screenWidth * 0.04167,
                    height: screenHeight * 0.05277,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Switch(
                        focusColor: clear,
                        hoverColor: clear,
                        activeColor: triggerSwitchBackgroundColor,
                        inactiveTrackColor: triggerSwitchBackgroundColor,
                        trackOutlineColor: WidgetStatePropertyAll(Colors.black),
                        inactiveThumbColor: Colors.black,
                        thumbColor: WidgetStatePropertyAll(Colors.black),
                        thumbIcon:
                            (risingTriggerSelected)
                                ? WidgetStatePropertyAll(
                                  Icon(
                                    Icons.arrow_forward,
                                    color: triggerSwitchBackgroundColor,
                                  ),
                                )
                                : WidgetStatePropertyAll(
                                  Icon(
                                    Icons.arrow_back,
                                    color: triggerSwitchBackgroundColor,
                                  ),
                                ),

                        value: risingTriggerSelected,
                        onChanged: (newSelect) {
                          setState(() {
                            risingTriggerSelected = newSelect;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'images/falling_edge.png',
                  width: screenWidth * 0.0156,
                  height: screenHeight * 0.02638,
                  opacity:
                      (!risingTriggerSelected)
                          ? AlwaysStoppedAnimation(1)
                          : AlwaysStoppedAnimation(0.25),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
