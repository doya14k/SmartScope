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
    return SizedBox(
      width: 200,
      height: 240,
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
                    fontSize: 25,
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
                    fixedSize: Size(80, 60),
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
                    style: TextStyle(
                      fontFamily: 'PrimaryFont',
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
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
                    fixedSize: Size(80, 60),
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
                    style: TextStyle(
                      fontFamily: 'PrimaryFont',
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
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
                  width: 30,
                  height: 30,
                  opacity:
                      (fallingTriggerSelected)
                          ? AlwaysStoppedAnimation(1)
                          : AlwaysStoppedAnimation(0.25),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: SizedBox(
                    width: 80,
                    height: 60,
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
                            (fallingTriggerSelected)
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

                        value: fallingTriggerSelected,
                        onChanged: (newSelect) {
                          setState(() {
                            fallingTriggerSelected = newSelect;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'images/falling_edge.png',
                  width: 30,
                  height: 30,
                  opacity:
                      (!fallingTriggerSelected)
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
