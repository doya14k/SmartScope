import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'definitions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class LevelOffsetShifter extends StatefulWidget {
  const LevelOffsetShifter({super.key});

  @override
  State<LevelOffsetShifter> createState() => _LevelOffsetShifterState();
}

class _LevelOffsetShifterState extends State<LevelOffsetShifter> {
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
      height: 350,
      width: 225,
      child: Card(
        color: VerticalScalerBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Spacer(flex: 1),
                AutoSizeText(
                  'Level-Offset',
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
              ],
            ),
            Row(
              children: [
                Spacer(flex: 1),
                Column(
                  children: [
                    Column(
                      children: [
                        AutoSizeText(
                          'CH1',
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'PrimaryFont',
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: channel1.channelColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 50,
                          width: 85,
                          child: TextField(
                            controller: TextEditingController.fromValue(
                              TextEditingValue(
                                text:
                                    Provider.of<AppState>(
                                      context,
                                      listen: false,
                                    ).offsetValueTextCH1,
                              ),
                            ),
                            style: TextStyle(fontSize: 14),
                            obscureText: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(2),
                              border: OutlineInputBorder(),
                              labelText: 'Offset',
                            ),
                            onSubmitted: (inputText) {
                              setState(() {
                                Provider.of<AppState>(
                                  context,
                                  listen: false,
                                ).convertCH1OffsetText2Value(inputText);
                                print('$inputText');
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Listener(
                              onPointerSignal: (event) {
                                if (event is PointerScrollEvent) {
                                  Provider.of<AppState>(
                                    context,
                                    listen: false,
                                  ).incrementCH1_LevelOffset(
                                    -event.scrollDelta.dy / 100,
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
                                      listen: false,
                                    ).ch1_uVoltageLevelOffset,
                                    max_uVLevelOffset,
                                  ),
                                  min: 0,
                                  max: 1,
                                  divisions:
                                      (max_uVLevelOffset - min_uVLevelOffset)
                                          .toInt(),
                                  onChanged: (double value) {
                                    setState(() {
                                      Provider.of<AppState>(
                                        context,
                                        listen: false,
                                      ).updatedCH1_LevelOffset(
                                        inverseLogTransform(
                                          value,
                                          max_uVLevelOffset,
                                        ),
                                      );
                                      print(
                                        'Offset slide: ${(Provider.of<AppState>(context, listen: false).ch1_uVoltageLevelOffset)}',
                                      );
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(flex: 1),
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          'CH2',
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'PrimaryFont',
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: channel2.channelColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 50,
                          width: 85,
                          child: TextField(
                            controller: TextEditingController.fromValue(
                              TextEditingValue(
                                text:
                                    Provider.of<AppState>(
                                      context,
                                      listen: false,
                                    ).offsetValueTextCH2,
                              ),
                            ),
                            style: TextStyle(fontSize: 14),
                            obscureText: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(2),
                              border: OutlineInputBorder(),
                              labelText: 'Offset',
                            ),
                            onSubmitted: (inputText) {
                              setState(() {
                                Provider.of<AppState>(
                                  context,
                                  listen: false,
                                ).convertCH2OffsetText2Value(inputText);
                                print('$inputText');
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Listener(
                              onPointerSignal: (event) {
                                if (event is PointerScrollEvent) {
                                  Provider.of<AppState>(
                                    context,
                                    listen: false,
                                  ).incrementCH2_LevelOffset(
                                    -event.scrollDelta.dy / 100,
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
                                      listen: false,
                                    ).ch2_uVoltageLevelOffset,
                                    max_uVLevelOffset,
                                  ),
                                  min: 0,
                                  max: 1,
                                  divisions:
                                      (max_uVLevelOffset - min_uVLevelOffset)
                                          .toInt(),
                                  onChanged: (double value) {
                                    setState(() {
                                      Provider.of<AppState>(
                                        context,
                                        listen: false,
                                      ).updatedCH2_LevelOffset(
                                        inverseLogTransform(
                                          value,
                                          max_uVLevelOffset,
                                        ),
                                      );
                                      print(
                                        'Offset slide: ${(Provider.of<AppState>(context, listen: false).ch2_uVoltageLevelOffset)}',
                                      );
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(flex: 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
