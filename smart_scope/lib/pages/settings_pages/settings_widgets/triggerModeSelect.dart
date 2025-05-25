import 'package:flutter/material.dart';
import 'package:smart_scope/usb_reader.dart';
import 'definitions.dart';
import 'package:provider/provider.dart';

class TriggerModeSelector extends StatefulWidget {
  const TriggerModeSelector({super.key});

  @override
  State<TriggerModeSelector> createState() => _TriggerModeSelectorState();
}

class _TriggerModeSelectorState extends State<TriggerModeSelector> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final usbProvider = Provider.of<UsbProvider>(context, listen: false);

    return SizedBox(
      width: screenWidth * 0.1042,
      height: screenHeight * 0.143,
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
                      screenWidth * 0.04687,
                      ((screenHeight * 0.1401) - 10) / 2,
                    ),
                    backgroundColor:
                        (actualIndex == selecetTriggerModeIndex)
                            ? selectedTriggerModeBackgroundColor
                            : clear,
                  ),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      triggerMode[actualIndex],
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
                  ),
                  onPressed: () {
                    setState(() {
                      selecetTriggerModeIndex = actualIndex;
                      print(triggerMode[actualIndex]);
                      if (selecetTriggerModeIndex == 0) {
                        usbProvider.restartAutoTrigger();
                      }
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
                      screenWidth * 0.04687,
                      ((screenHeight * 0.1401) - 10) / 2,
                    ),
                    backgroundColor:
                        (actualIndex == selecetTriggerModeIndex)
                            ? selectedTriggerModeBackgroundColor
                            : clear,
                  ),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      triggerMode[actualIndex],
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
