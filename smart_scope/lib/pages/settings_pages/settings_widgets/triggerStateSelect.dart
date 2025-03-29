import 'package:flutter/material.dart';
import 'definitions.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TriggerStateSelector extends StatefulWidget {
  const TriggerStateSelector({super.key});

  @override
  State<TriggerStateSelector> createState() => _TriggerStateSelectorState();
}

class _TriggerStateSelectorState extends State<TriggerStateSelector> {
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
              children: List.generate((triggerStates.length).floor(), (index) {
                int actualIndex = index;
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(
                      180,
                      (5 +
                              ActivateChannelFont_Size +
                              CH_Enable_sizedBoxHeight +
                              CH_Enable_height +
                              CH_Enable_sizedBoxHeight +
                              CH_Enable_height +
                              5 +
                              15 -
                              30) /
                          3,
                    ),
                    backgroundColor:
                        (actualIndex != selecetTriggerStateIndex)
                            ? clear
                            : (actualIndex == 0)
                            ? selectedRunBackgroundColor
                            : (actualIndex == 1)
                            ? selectedStopBackgroundColor
                            : selectedTriggerStateBackgroundColor,
                  ),
                  child: AutoSizeText(
                    triggerStates[actualIndex],
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'PrimaryFont',
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                      color:
                          (actualIndex == selecetTriggerStateIndex)
                              ? ChannelEnableBackgroundColor
                              : selectedTriggerStateBackgroundColor,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selecetTriggerStateIndex = actualIndex;
                      if (actualIndex == 2) {
                        // Clear function hierhin
                        selecetTriggerStateIndex = 1;
                      }
                      print(triggerStates[actualIndex]);
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
