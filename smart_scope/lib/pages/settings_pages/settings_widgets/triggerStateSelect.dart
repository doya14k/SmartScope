import 'package:flutter/material.dart';
import 'definitions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:smart_scope/usb_reader.dart';

class TriggerStateSelector extends StatefulWidget {
  const TriggerStateSelector({super.key});

  @override
  State<TriggerStateSelector> createState() => _TriggerStateSelectorState();
}

class _TriggerStateSelectorState extends State<TriggerStateSelector> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final usb = Provider.of<UsbProvider>(context, listen: true);
    return SizedBox(
      width: screenWidth * 0.1041,
      height: screenHeight * 0.143,
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
                      screenWidth * 0.09375,
                      (screenHeight * 0.143 - 30) / 3,
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
                        usb.clearPlot();
                        selecetTriggerStateIndex = 1;
                      }
                      else if (actualIndex == 0){
                        usb.clearPlot();
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
