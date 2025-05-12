import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_scope/pages/settings_pages/cursor_page/definitionenCursor.dart';
import 'package:provider/provider.dart';
import 'package:smart_scope/pages/settings_pages/measurements_widgets/definitionMeasurements.dart';
import 'dart:math';

import 'package:smart_scope/pages/settings_pages/settings_widgets/definitions.dart';

class CursorPage extends StatefulWidget {
  const CursorPage({super.key});

  @override
  State<CursorPage> createState() => _CursorPageState();
}

class _CursorPageState extends State<CursorPage> {
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
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.01759),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Row(
              children: [
                SizedBox(width: screenWidth * 0.010417),
                AutoSizeText(
                  "Hide",
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.010417,
                    color: Colors.black,
                  ),
                ),
                Switch(
                  value:
                      Provider.of<CursorChanges>(
                        context,
                        listen: false,
                      ).cursorIsEnabled,
                  onChanged: (newState) {
                    setState(() {
                      Provider.of<CursorChanges>(
                        context,
                        listen: false,
                      ).toggleCursorEnabled();
                      print(
                        Provider.of<CursorChanges>(
                          context,
                          listen: false,
                        ).cursorIsEnabled,
                      );
                    });
                  },
                ),
                AutoSizeText(
                  "Show",
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.010417,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                AutoSizeText(
                  "CH1",
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.010417,
                    color: ch1_Color,
                  ),
                ),
                Switch(
                  value:
                      Provider.of<CursorChanges>(
                        context,
                        listen: false,
                      ).cursorIsOnCH2,
                  onChanged: (newState) {
                    setState(() {
                      Provider.of<CursorChanges>(
                        context,
                        listen: false,
                      ).toggleCursorChannel();
                    });
                  },
                  activeColor: ch2_Color,
                  inactiveThumbColor: ch1_Color,
                  inactiveTrackColor: ch1_trackColor,
                  thumbIcon: WidgetStatePropertyAll(
                    Icon(
                      Icons.circle,
                      color:
                          (!Provider.of<CursorChanges>(
                                context,
                                listen: true,
                              ).cursorIsOnCH2)
                              ? ch1_Color
                              : ch2_Color,
                    ),
                  ),
                ),
                AutoSizeText(
                  "CH2",
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.010417,
                    color: ch2_Color,
                  ),
                ),
                SizedBox(width: screenWidth * 0.010417),
              ],
            ),
          ],
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.39578,
                width: screenWidth * 0.2604,
                child: Card(
                  color: cardBackgroundColorCursor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // X1
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AutoSizeText(
                                "X1",
                                maxLines: 1,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'PrimaryFont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.015625,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01759),
                              Column(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: screenHeight * 0.04397,
                                        width: screenWidth * 0.04427,
                                        child: TextField(
                                          controller:
                                              TextEditingController.fromValue(
                                                TextEditingValue(
                                                  text:
                                                      Provider.of<
                                                        CursorChanges
                                                      >(
                                                        context,
                                                        listen: false,
                                                      ).Value2Text_X1,
                                                ),
                                              ),
                                          style: TextStyle(fontSize: 14),
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(2),
                                            border: OutlineInputBorder(),
                                            labelText: '',
                                          ),
                                          onSubmitted: (inputText) {
                                            setState(() {
                                              Provider.of<CursorChanges>(
                                                context,
                                                listen: false,
                                              ).convertText2Value_X1(inputText);
                                              print(inputText);
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.2199,
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Listener(
                                            onPointerSignal: (event) {
                                              if (event is PointerScrollEvent) {
                                                setState(() {
                                                  Provider.of<CursorChanges>(
                                                    context,
                                                    listen: false,
                                                  ).incrementX1_Offset(
                                                    -event.scrollDelta.dy / 100,
                                                    Provider.of<AppState>(
                                                      context,
                                                      listen: false,
                                                    ).timeValue,
                                                  );
                                                });
                                              }
                                            },
                                            child: SliderTheme(
                                              data: SliderThemeData(
                                                trackShape:
                                                    RectangularSliderTrackShape(),
                                                trackHeight: 5.0,
                                                activeTrackColor: Colors.grey,
                                                inactiveTrackColor: Colors.grey,
                                                thumbColor: Colors.black,
                                                thumbShape:
                                                    RoundSliderThumbShape(
                                                      enabledThumbRadius: 10,
                                                    ),
                                              ),
                                              child: Slider(
                                                value: logTransform(
                                                  Provider.of<CursorChanges>(
                                                    context,
                                                    listen: false,
                                                  ).cursorX1uS_Value,
                                                  max_XOffset,
                                                ),
                                                min: 0,
                                                max: 1,
                                                divisions:
                                                    (max_XOffset - min_XOffset)
                                                        .toInt(),
                                                onChanged: (double value) {
                                                  setState(() {
                                                    Provider.of<CursorChanges>(
                                                      context,
                                                      listen: false,
                                                    ).updateX1Value(
                                                      inverseLogTransform(
                                                        value,
                                                        max_XOffset,
                                                      ),
                                                    );
                                                    print(
                                                      'Offset slide: ${(Provider.of<CursorChanges>(context, listen: false).cursorX1uS_Value)}',
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
                                          // fixedSize: Size(10, 20),
                                          shape: CircleBorder(),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            Provider.of<CursorChanges>(
                                              context,
                                              listen: false,
                                            ).updateX1Value(0);
                                            print(
                                              '${Provider.of<CursorChanges>(context, listen: false).cursorX1uS_Value}',
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
                            ],
                          ),

                          // X2
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AutoSizeText(
                                "X2",
                                maxLines: 1,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'PrimaryFont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.015625,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01759),
                              Column(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: screenHeight * 0.04397,
                                        width: screenWidth * 0.04427,
                                        child: TextField(
                                          controller:
                                              TextEditingController.fromValue(
                                                TextEditingValue(
                                                  text:
                                                      Provider.of<
                                                        CursorChanges
                                                      >(
                                                        context,
                                                        listen: false,
                                                      ).Value2Text_X2,
                                                ),
                                              ),
                                          style: TextStyle(fontSize: 14),
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(2),
                                            border: OutlineInputBorder(),
                                            labelText: '',
                                          ),
                                          onSubmitted: (inputText) {
                                            setState(() {
                                              Provider.of<CursorChanges>(
                                                context,
                                                listen: false,
                                              ).convertText2Value_X2(inputText);
                                              print(inputText);
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.2199,
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Listener(
                                            onPointerSignal: (event) {
                                              if (event is PointerScrollEvent) {
                                                setState(() {
                                                  Provider.of<CursorChanges>(
                                                    context,
                                                    listen: false,
                                                  ).incrementX2_Offset(
                                                    -event.scrollDelta.dy / 100,
                                                    Provider.of<AppState>(
                                                      context,
                                                      listen: false,
                                                    ).timeValue,
                                                  );
                                                });
                                              }
                                            },
                                            child: SliderTheme(
                                              data: SliderThemeData(
                                                trackShape:
                                                    RectangularSliderTrackShape(),
                                                trackHeight: 5.0,
                                                activeTrackColor: Colors.grey,
                                                inactiveTrackColor: Colors.grey,
                                                thumbColor: Colors.black,
                                                thumbShape:
                                                    RoundSliderThumbShape(
                                                      enabledThumbRadius: 10,
                                                    ),
                                              ),
                                              child: Slider(
                                                value: logTransform(
                                                  Provider.of<CursorChanges>(
                                                    context,
                                                    listen: false,
                                                  ).cursorX2uS_Value,
                                                  max_XOffset,
                                                ),
                                                min: 0,
                                                max: 1,
                                                divisions:
                                                    (max_XOffset - min_XOffset)
                                                        .toInt(),
                                                onChanged: (double value) {
                                                  setState(() {
                                                    Provider.of<CursorChanges>(
                                                      context,
                                                      listen: false,
                                                    ).updateX2Value(
                                                      inverseLogTransform(
                                                        value,
                                                        max_XOffset,
                                                      ),
                                                    );
                                                    print(
                                                      'Offset slide: ${(Provider.of<CursorChanges>(context, listen: false).cursorX2uS_Value)}',
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
                                          // fixedSize: Size(10, 20),
                                          shape: CircleBorder(),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            Provider.of<CursorChanges>(
                                              context,
                                              listen: false,
                                            ).updateX2Value(0);
                                            print(
                                              '${Provider.of<CursorChanges>(context, listen: false).cursorX2uS_Value}',
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
                            ],
                          ),

                          // Y1
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AutoSizeText(
                                "Y1",
                                maxLines: 1,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'PrimaryFont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.015625,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01759),
                              Column(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: screenHeight * 0.04397,
                                        width: screenWidth * 0.04427,
                                        child: TextField(
                                          controller:
                                              TextEditingController.fromValue(
                                                TextEditingValue(
                                                  text:
                                                      Provider.of<
                                                        CursorChanges
                                                      >(
                                                        context,
                                                        listen: false,
                                                      ).Value2Text_Y1,
                                                ),
                                              ),
                                          style: TextStyle(fontSize: 14),
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(2),
                                            border: OutlineInputBorder(),
                                            labelText: '',
                                          ),
                                          onSubmitted: (inputText) {
                                            setState(() {
                                              Provider.of<CursorChanges>(
                                                context,
                                                listen: false,
                                              ).convertText2Value_Y1(inputText);
                                              print(inputText);
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.2199,
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Listener(
                                            onPointerSignal: (event) {
                                              if (event is PointerScrollEvent) {
                                                setState(() {
                                                  Provider.of<CursorChanges>(
                                                    context,
                                                    listen: false,
                                                  ).incrementY1_Offset(
                                                    -event.scrollDelta.dy / 100,
                                                    Provider.of<AppState>(
                                                      context,
                                                      listen: false,
                                                    ).timeValue,
                                                  );
                                                });
                                              }
                                            },
                                            child: SliderTheme(
                                              data: SliderThemeData(
                                                trackShape:
                                                    RectangularSliderTrackShape(),
                                                trackHeight: 5.0,
                                                activeTrackColor: Colors.grey,
                                                inactiveTrackColor: Colors.grey,
                                                thumbColor: Colors.black,
                                                thumbShape:
                                                    RoundSliderThumbShape(
                                                      enabledThumbRadius: 10,
                                                    ),
                                              ),
                                              child: Slider(
                                                value: logTransform(
                                                  Provider.of<CursorChanges>(
                                                    context,
                                                    listen: false,
                                                  ).cursorY1uV_Value,
                                                  max_YOffset,
                                                ),
                                                min: 0,
                                                max: 1,
                                                divisions:
                                                    (max_YOffset - min_YOffset)
                                                        .toInt(),
                                                onChanged: (double value) {
                                                  setState(() {
                                                    Provider.of<CursorChanges>(
                                                      context,
                                                      listen: false,
                                                    ).updateY1Value(
                                                      inverseLogTransform(
                                                        value,
                                                        max_YOffset,
                                                      ),
                                                    );
                                                    print(
                                                      'Offset slide: ${(Provider.of<CursorChanges>(context, listen: false).cursorY1uV_Value)}',
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
                                          // fixedSize: Size(10, 20),
                                          shape: CircleBorder(),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            Provider.of<CursorChanges>(
                                              context,
                                              listen: false,
                                            ).updateY1Value(0);
                                            print(
                                              '${Provider.of<CursorChanges>(context, listen: false).cursorY1uV_Value}',
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
                            ],
                          ),

                          // Y2
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AutoSizeText(
                                "Y2",
                                maxLines: 1,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'PrimaryFont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.015625,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01759),
                              Column(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: screenHeight * 0.04397,
                                        width: screenWidth * 0.04427,
                                        child: TextField(
                                          controller:
                                              TextEditingController.fromValue(
                                                TextEditingValue(
                                                  text:
                                                      Provider.of<
                                                        CursorChanges
                                                      >(
                                                        context,
                                                        listen: false,
                                                      ).Value2Text_Y2,
                                                ),
                                              ),
                                          style: TextStyle(fontSize: 14),
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(2),
                                            border: OutlineInputBorder(),
                                            labelText: '',
                                          ),
                                          onSubmitted: (inputText) {
                                            setState(() {
                                              Provider.of<CursorChanges>(
                                                context,
                                                listen: false,
                                              ).convertText2Value_Y2(inputText);
                                              print(inputText);
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.2199,
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Listener(
                                            onPointerSignal: (event) {
                                              if (event is PointerScrollEvent) {
                                                setState(() {
                                                  Provider.of<CursorChanges>(
                                                    context,
                                                    listen: false,
                                                  ).incrementY2_Offset(
                                                    -event.scrollDelta.dy / 100,
                                                    Provider.of<AppState>(
                                                      context,
                                                      listen: false,
                                                    ).timeValue,
                                                  );
                                                });
                                              }
                                            },
                                            child: SliderTheme(
                                              data: SliderThemeData(
                                                trackShape:
                                                    RectangularSliderTrackShape(),
                                                trackHeight: 5.0,
                                                activeTrackColor: Colors.grey,
                                                inactiveTrackColor: Colors.grey,
                                                thumbColor: Colors.black,
                                                thumbShape:
                                                    RoundSliderThumbShape(
                                                      enabledThumbRadius: 10,
                                                    ),
                                              ),
                                              child: Slider(
                                                value: logTransform(
                                                  Provider.of<CursorChanges>(
                                                    context,
                                                    listen: false,
                                                  ).cursorY2uV_Value,
                                                  max_YOffset,
                                                ),
                                                min: 0,
                                                max: 1,
                                                divisions:
                                                    (max_YOffset - min_YOffset)
                                                        .toInt(),
                                                onChanged: (double value) {
                                                  setState(() {
                                                    Provider.of<CursorChanges>(
                                                      context,
                                                      listen: false,
                                                    ).updateY2Value(
                                                      inverseLogTransform(
                                                        value,
                                                        max_YOffset,
                                                      ),
                                                    );
                                                    print(
                                                      'Offset slide: ${(Provider.of<CursorChanges>(context, listen: false).cursorY2uV_Value)}',
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
                                          // fixedSize: Size(10, 20),
                                          shape: CircleBorder(),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            Provider.of<CursorChanges>(
                                              context,
                                              listen: false,
                                            ).updateY2Value(0);
                                            print(
                                              '${Provider.of<CursorChanges>(context, listen: false).cursorY2uV_Value}',
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
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.3518,
                width: screenWidth * 0.15625,
                child: Card(
                  color:
                      (!Provider.of<CursorChanges>(
                            context,
                            listen: true,
                          ).cursorIsOnCH2)
                          ? channel1_lightBackgroundColor
                          : channel2_lightBackgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        (!Provider.of<CursorChanges>(
                              context,
                              listen: true,
                            ).cursorIsOnCH2)
                            ? "Measurements for CH1"
                            : "Measurements for CH2",
                        maxLines: 1,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: 'PrimaryFont',
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight * 0.0219877,
                          color: Colors.black,
                        ),
                      ),
                      Divider(height: 1, color: Colors.black),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AutoSizeText(
                            "X1",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: screenHeight * 0.01759,
                              color: Colors.black,
                            ),
                          ),
                          AutoSizeText(
                            "= ${Provider.of<CursorChanges>(context, listen: false).Value2Text_X1}",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: screenHeight * 0.01759,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 1, color: Colors.black),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AutoSizeText(
                            "X2",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: screenHeight * 0.01759,
                              color: Colors.black,
                            ),
                          ),
                          AutoSizeText(
                            "= ${Provider.of<CursorChanges>(context, listen: false).Value2Text_X2}",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: screenHeight * 0.01759,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 1, color: Colors.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AutoSizeText(
                            "Y1",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: screenHeight * 0.01759,
                              color: Colors.black,
                            ),
                          ),
                          AutoSizeText(
                            "= ${Provider.of<CursorChanges>(context, listen: false).Value2Text_Y1}",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: screenHeight * 0.01759,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 1, color: Colors.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AutoSizeText(
                            "Y2",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: screenHeight * 0.01759,
                              color: Colors.black,
                            ),
                          ),
                          AutoSizeText(
                            "= ${Provider.of<CursorChanges>(context, listen: false).Value2Text_Y2}",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: screenHeight * 0.01759,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 1, color: Colors.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AutoSizeText(
                            "X2 - X1",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: screenHeight * 0.01759,
                              color: Colors.black,
                            ),
                          ),
                          AutoSizeText(
                            "= ${Provider.of<CursorChanges>(context, listen: false).Value2Text_deltaX}",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: screenHeight * 0.01759,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 1, color: Colors.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AutoSizeText(
                            "Y2 - Y1",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: screenHeight * 0.01759,
                              color: Colors.black,
                            ),
                          ),
                          AutoSizeText(
                            "= ${Provider.of<CursorChanges>(context, listen: false).Value2Text_deltaY}",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: screenHeight * 0.01759,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 1, color: Colors.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AutoSizeText(
                            "1/|ΔX|",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: screenHeight * 0.01759,
                              color: Colors.black,
                            ),
                          ),
                          AutoSizeText(
                            "= ${Provider.of<CursorChanges>(context, listen: false).Value2Text_deltaX_frequency}",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: screenHeight * 0.01759,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
