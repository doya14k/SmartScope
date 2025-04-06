import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'definitions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

class HorizontalScaler extends StatefulWidget {
  const HorizontalScaler({super.key});

  @override
  State<HorizontalScaler> createState() => _HorizontalScalerState();
}

class _HorizontalScalerState extends State<HorizontalScaler> {
  void updateSlider(double delta, BuildContext context) {
    setState(() {
      final appState = Provider.of<AppState>(context, listen: false);
      channel1.uVperDivision =
          (appState.ch1_uVoltageValue - delta) / max_uVperDivision;
      appState.updateSliderValue_ch1(
        (appState.ch1_uVoltageValue - delta) / max_uVperDivision,
      );
    });
  }

  void updateTime(double delta, BuildContext context) {
    setState(() {
      final appState = Provider.of<AppState>(context, listen: false);
      appState.incrementTimeValue(delta / 100);
      print('Delta ${delta / 100}');
      print('appState.timeValue ${appState.timeValue}');
      appState.updateGraphTimeValue(appState.triggerHorizontalOffset);
    });
  }

  double logTransform(double value, double min, double max) {
    return (log(value) - log(min)) / (log(max) - log(min));
  }

  double inverseLogTransform(double value, double min, double max) {
    return exp(log(min) + value * (log(max) - log(min)));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth * 0.177,
      height: screenHeight * 0.119,
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
                  'Horizontal',
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontSize: screenHeight * 0.01759,
                    color: Colors.black,
                  ),
                ),
                Spacer(flex: 5),
                SizedBox(
                  height: screenHeight * 0.044,
                  width: screenWidth * 0.0625,
                  child: TextField(
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text:
                            Provider.of<AppState>(
                              context,
                              listen: false,
                            ).timeValue2Text,
                      ),
                    ),
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Time/Div',
                    ),
                    onSubmitted: (inputText) {
                      setState(() {
                        Provider.of<AppState>(
                          context,
                          listen: false,
                        ).convertTimeText2Value(inputText);
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
                IconButton(
                  style: IconButton.styleFrom(
                    fixedSize: Size(
                      screenWidth * 0.005208,
                      screenHeight * 0.01759,
                    ),
                    shape: CircleBorder(),
                  ),
                  onPressed: () {
                    setState(() {
                      Provider.of<AppState>(
                        context,
                        listen: false,
                      ).incrementTimeValueFine(-1);
                    });
                  },
                  icon: Icon(Icons.arrow_back),
                  iconSize: screenHeight * 0.01759,
                ),
                Expanded(
                  child: Listener(
                    onPointerSignal: (event) {
                      if (event is PointerScrollEvent) {
                        updateTime(event.scrollDelta.dy, context);
                        print(
                          Provider.of<AppState>(
                            context,
                            listen: false,
                          ).timeValue,
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
                          Provider.of<AppState>(context).timeValue,
                          min_uSperDivision,
                          max_uSperDivision,
                        ),
                        min: 0,
                        max: 1,
                        divisions:
                            (max_uSperDivision / min_uSperDivision).toInt(),
                        onChanged: (double value) {
                          double transformedValue = inverseLogTransform(
                            value,
                            min_uSperDivision,
                            max_uSperDivision,
                          );
                          Provider.of<AppState>(
                            context,
                            listen: false,
                          ).updateTimeValue(transformedValue);
                        },
                      ),
                    ),
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    fixedSize: Size(
                      screenWidth * 0.005208,
                      screenHeight * 0.01759,
                    ),
                    shape: CircleBorder(),
                  ),
                  onPressed: () {
                    setState(() {
                      Provider.of<AppState>(
                        context,
                        listen: false,
                      ).incrementTimeValueFine(1);
                    });
                  },
                  icon: Icon(Icons.arrow_forward),
                  iconSize: screenHeight * 0.01759,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
