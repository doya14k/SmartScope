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
          (appState.currentsliderValue - delta) / max_uVperDivision;
      appState.updateSliderValue_ch1();
    });
  }

  void updateTime(double delta, BuildContext context) {
    setState(() {
      final appState = Provider.of<AppState>(context, listen: false);
      appState.incrementTimeValue(delta / 100);
      print('Delta ${delta / 100}');
      print('appState.timeValue ${appState.timeValue}');
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
    return SizedBox(
      width: 300,
      height: 120,
      child: Card(
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
                            '${Provider.of<AppState>(context, listen: false).timeValue2Text}',
                      ),
                    ),
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'time/div',
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
                    fixedSize: Size(10, 20),
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
                  iconSize: 20,
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
                    fixedSize: Size(10, 20),
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
                  iconSize: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
