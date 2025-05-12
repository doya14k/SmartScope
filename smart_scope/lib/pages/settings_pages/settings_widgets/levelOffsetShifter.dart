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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.4045,
      width: screenWidth * 0.1614,
      child: Card(
        color: VerticalScalerBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.0088),
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
                    fontSize: screenWidth * 0.00104,
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
                            fontSize: screenWidth * 0.0156,
                            color: channel1.channelColor,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.0088),
                        SizedBox(
                          height: screenHeight * 0.04397,
                          width: screenWidth * 0.04427,
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
                                print(inputText);
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.2198,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Listener(
                              onPointerSignal: (event) {
                                if (event is PointerScrollEvent) {
                                  setState(() {
                                    Provider.of<AppState>(
                                      context,
                                      listen: false,
                                    ).incrementCH1_LevelOffset(
                                      -event.scrollDelta.dy / 100,
                                    );
                                  });
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
                              ).updatedCH1_LevelOffset(0);
                              print(
                                '${Provider.of<AppState>(context, listen: false).triggerHorizontalOffset}',
                              );
                            });
                          },
                          icon: Icon(Icons.exposure_zero),
                          iconSize: screenWidth * 0.013,
                          alignment: Alignment.center,
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
                            fontSize: screenWidth * 0.0156,
                            color: channel2.channelColor,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.0088),
                        SizedBox(
                          height: screenHeight * 0.04397,
                          width: screenWidth * 0.04427,
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
                                print(inputText);
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.2198,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Listener(
                              onPointerSignal: (event) {
                                if (event is PointerScrollEvent) {
                                  setState(() {
                                    Provider.of<AppState>(
                                      context,
                                      listen: false,
                                    ).incrementCH2_LevelOffset(
                                      -event.scrollDelta.dy / 100,
                                    );
                                  });
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
                              ).updatedCH2_LevelOffset(0);
                              print(
                                '${Provider.of<AppState>(context, listen: false).triggerHorizontalOffset}',
                              );
                            });
                          },
                          icon: Icon(Icons.exposure_zero),
                          iconSize: screenWidth * 0.013,
                          alignment: Alignment.center,
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
                        SizedBox(height: 5),
                        AutoSizeText(
                          'Trigger',
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'PrimaryFont',
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.013,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.0088),
                        SizedBox(
                          height: screenHeight * 0.04397,
                          width: screenWidth * 0.04427,
                          child: TextField(
                            controller: TextEditingController.fromValue(
                              TextEditingValue(
                                text:
                                    Provider.of<AppState>(
                                      context,
                                      listen: false,
                                    ).triggerVerticalOffsetValue2Text,
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
                                ).convertTriggerVerticalOffsetText2Value(
                                  inputText,
                                );
                                print(inputText);
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.2198,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Listener(
                              onPointerSignal: (event) {
                                if (event is PointerScrollEvent) {
                                  setState(() {
                                    Provider.of<AppState>(
                                      context,
                                      listen: false,
                                    ).incrementTriggerVerticalOffset(
                                      -event.scrollDelta.dy / 100,
                                    );
                                    print(
                                      '${Provider.of<AppState>(context, listen: false).triggerVerticalOffset}',
                                    );
                                  });
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
                                    ).triggerVerticalOffset,
                                    max_TriggerVerticalOffset,
                                  ),
                                  min: 0,
                                  max: 1,
                                  divisions:
                                      (max_TriggerVerticalOffset -
                                              min_TriggerVerticalOffset)
                                          .toInt(),
                                  onChanged: (double value) {
                                    setState(() {
                                      Provider.of<AppState>(
                                        context,
                                        listen: false,
                                      ).updateTriggerVerticalOffset(
                                        inverseLogTransform(
                                          value,
                                          max_TriggerVerticalOffset,
                                        ),
                                      );
                                      print(
                                        'Offset slide: ${(Provider.of<AppState>(context, listen: false).triggerVerticalOffset)}',
                                      );
                                    });
                                  },
                                ),
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
                              ).updateTriggerVerticalOffset(0);
                              print(
                                '${Provider.of<AppState>(context, listen: false).triggerHorizontalOffset}',
                              );
                            });
                          },
                          icon: Icon(Icons.exposure_zero),
                          iconSize: screenWidth * 0.013,
                          alignment: Alignment.center,
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
