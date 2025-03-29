import 'package:flutter/material.dart';
import 'definitions.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TriggerModeSelector extends StatefulWidget {
  const TriggerModeSelector({super.key});

  @override
  State<TriggerModeSelector> createState() => _TriggerModeSelectorState();
}

class _TriggerModeSelectorState extends State<TriggerModeSelector> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height:
          5 +
          ActivateChannelFont_Size +
          CH_Enable_sizedBoxHeight +
          CH_Enable_height +
          CH_Enable_sizedBoxHeight +
          CH_Enable_height +
          5 +
          15,
      child: Card(
        color: ChannelEnableBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate((triggerMode.length / 2).floor(), (
                index,
              ) {
                int actualIndex = index;
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(
                      90,
                      (5 +
                              ActivateChannelFont_Size +
                              CH_Enable_sizedBoxHeight +
                              CH_Enable_height +
                              CH_Enable_sizedBoxHeight +
                              CH_Enable_height +
                              5 +
                              15 -
                              30) /
                          2,
                    ),
                    backgroundColor:
                        (actualIndex == selecetTriggerModeIndex)
                            ? selectedTriggerModeBackgroundColor
                            : clear,
                  ),
                  child: AutoSizeText(
                    triggerMode[actualIndex],
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'PrimaryFont',
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                      color:
                          (actualIndex == selecetTriggerModeIndex)
                              ? ChannelEnableBackgroundColor
                              : selectedTriggerModeBackgroundColor,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selecetTriggerModeIndex = actualIndex;
                      print(triggerMode[actualIndex]);
                    });
                  },
                );
              }),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate((triggerMode.length / 2).floor(), (
                index,
              ) {
                int actualIndex = index + (triggerMode.length / 2).floor();
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(
                      90,
                      (5 +
                              ActivateChannelFont_Size +
                              CH_Enable_sizedBoxHeight +
                              CH_Enable_height +
                              CH_Enable_sizedBoxHeight +
                              CH_Enable_height +
                              5 +
                              15 -
                              30) /
                          2,
                    ),
                    backgroundColor:
                        (actualIndex == selecetTriggerModeIndex)
                            ? selectedTriggerModeBackgroundColor
                            : clear,
                  ),
                  child: AutoSizeText(
                    triggerMode[actualIndex],
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'PrimaryFont',
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                      color:
                          (actualIndex == selecetTriggerModeIndex)
                              ? ChannelEnableBackgroundColor
                              : selectedTriggerModeBackgroundColor,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selecetTriggerModeIndex = actualIndex;
                      print(triggerMode[actualIndex]);
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
