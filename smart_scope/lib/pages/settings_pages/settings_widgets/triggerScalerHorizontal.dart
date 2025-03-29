import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'definitions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

class HorizontalTriggerScaler extends StatefulWidget {
  const HorizontalTriggerScaler({super.key});

  @override
  State<HorizontalTriggerScaler> createState() =>
      _HorizontalTriggerScalerState();
}

class _HorizontalTriggerScalerState extends State<HorizontalTriggerScaler> {
  void updateSlider(double delta, BuildContext context) {
    setState(() {
      final appState = Provider.of<AppState>(context, listen: false);
      channel1.uVperDivision =
          (appState.ch1_uVoltageValue - delta) / max_uVperDivision;
      appState.updateTriggerHorizontalOffset(
        (appState.ch1_uVoltageValue - delta) / max_uVperDivision,
      );
    });
  }

  void updateTime(double delta, BuildContext context) {
    setState(() {
      final appState = Provider.of<AppState>(context, listen: false);
      appState.incrementTriggerHorizontalOffset(delta / 100);
      print('Delta ${delta / 100}');
      print('appState.timeValue ${appState.triggerHorizontalOffset}');
      appState.updateGraphTimeValue(appState.triggerHorizontalOffset);
    });
  }

  double logTransform(double value, double max) {
    if (value == 0) return 0.5;

    double sign = 1.0;
    if (value < 0.0) {
      sign = -1.0;
    }

    return 0.5 + sign * (log((sign * value) + 1) / log(max + 1)) * 0.5;
  }

  double inverseLogTransform(double value, double max) {
    if (value == 0.5) return 0;

    double sign = 1.0;
    if (value < 0.5) {
      sign = -1.0;
    }
    double Value = exp((value - 0.5) * 2 * log(max + 1));

    if (sign == 1.0) {
      return Value + 1;
    } else if (sign == -1.0) {
      return -(1 / Value) - 1;
    }

    // error?
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 120,
      child: Card(
        color: HorizontalScalerBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(flex: 1),
                AutoSizeText(
                  'Trigger Horizontal',
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Spacer(flex: 5),
                SizedBox(
                  height: 50,
                  width: 120,
                  child: TextField(
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text:
                            Provider.of<AppState>(
                              context,
                              listen: false,
                            ).triggerHorizontalOffsetValue2Text,
                      ),
                    ),
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Time-offset',
                    ),
                    onSubmitted: (inputText) {
                      setState(() {
                        Provider.of<AppState>(
                          context,
                          listen: false,
                        ).convertTriggerHorizontalOffsetText2Value(inputText);
                      });
                    },
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Listener(
                    onPointerSignal: (event) {
                      if (event is PointerScrollEvent) {
                        updateTime(event.scrollDelta.dy, context);
                        print(
                          Provider.of<AppState>(
                            context,
                            listen: false,
                          ).triggerHorizontalOffset,
                        );
                      }
                    },
                    child: SliderTheme(
                      data: SliderThemeData(
                        trackShape: RectangularSliderTrackShape(),
                        trackHeight: 5.0,
                        activeTrackColor: Colors.grey,
                        inactiveTrackColor: Colors.grey,
                        thumbColor: Colors.black,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 10,
                        ),
                      ),
                      child: Slider(
                        value: logTransform(
                          Provider.of<AppState>(
                            context,
                          ).triggerHorizontalOffset,
                          max_TriggerHorizontalOffset,
                        ),
                        min: 0,
                        max: 1,
                        divisions:
                            (max_TriggerHorizontalOffset -
                                    min_TriggerHorizontalOffset)
                                .toInt(),
                        onChanged: (double value) {
                          double transformedValue = inverseLogTransform(
                            value,
                            max_TriggerHorizontalOffset,
                          );
                          Provider.of<AppState>(
                            context,
                            listen: false,
                          ).updateTriggerHorizontalOffset(transformedValue);
                          print(
                            '${Provider.of<AppState>(context, listen: false).triggerHorizontalOffset}',
                          );
                        },
                      ),
                    ),
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    fixedSize: Size(10, 20),
                    shape: CircleBorder(),
                  ),
                  onPressed: () {
                    setState(() {
                      Provider.of<AppState>(
                        context,
                        listen: false,
                      ).updateTriggerHorizontalOffset(0);
                      print(
                        '${Provider.of<AppState>(context, listen: false).triggerHorizontalOffset}',
                      );
                    });
                  },
                  icon: Icon(Icons.exposure_zero),
                  iconSize: 25,
                  alignment: Alignment.center,
                ),
                SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
