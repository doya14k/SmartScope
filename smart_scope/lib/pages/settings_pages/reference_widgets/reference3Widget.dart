import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'defintionenReference.dart';
import 'dart:math';

class Reference3 extends StatefulWidget {
  const Reference3({super.key});

  @override
  State<Reference3> createState() => _Reference3State();
}

class _Reference3State extends State<Reference3> {
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

  void updateRef3_VperDiv(double delta, BuildContext context) {
    setState(() {
      final referenceChanges = Provider.of<ReferenceChanges>(
        context,
        listen: false,
      );
      referenceChanges.incrementVoltageValueperDivision_Ref3(-delta / 100);
      print('Delta ${delta / 100}');
      print('appState.ch1 ${referenceChanges.Ref3uVperDivision}');
      referenceChanges.updateGraphVoltageValue();
    });
  }

  double logTransformDivision(double value, double min, double max) {
    return (log(value) - log(min)) / (log(max) - log(min));
  }

  double inverseLogTransformDivision(double value, double min, double max) {
    return exp(log(min) + value * (log(max) - log(min)));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(flex: 2, child: SizedBox()),
            Expanded(
              flex: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PopupMenuButton(
                    tooltip: 'Reference on CHx',
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                        child: SizedBox(
                          height: screenHeight * 0.03518,
                          width: screenWidth * 0.03125,
                          child: Center(
                            child: AutoSizeText(
                              "CH$selectedReference1Graph",
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'PrimaryFont',
                                fontWeight: FontWeight.normal,
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context) {
                      return List.generate(2, (index) {
                        return PopupMenuItem(
                          value: index,
                          child: Text(
                            'CH${index + 1}',
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        );
                      });
                    },
                    onSelected: (selectedIndex) {
                      setState(() {
                        selectedIndex++;
                        print(selectedIndex);
                        selectedReference1Graph = selectedIndex;
                      });
                    },
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      // fixedSize: Size(screenWidth * 0.06, screenHeight * 0.05),
                      backgroundColor: clear3,
                    ),
                    onPressed: () {
                      Provider.of<ReferenceChanges>(
                        context,
                        listen: false,
                      ).updateRef3IsAcitve(true);
                      print(
                        Provider.of<ReferenceChanges>(
                          context,
                          listen: false,
                        ).Ref3IsActive,
                      );
                    },
                    child: AutoSizeText(
                      "Save",
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'PrimaryFont',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      // fixedSize: Size(screenWidth * 0.06, screenHeight * 0.05),
                      backgroundColor: clear3,
                    ),
                    onPressed: () {
                      Provider.of<ReferenceChanges>(
                        context,
                        listen: false,
                      ).updateRef3IsAcitve(false);
                      print(
                        Provider.of<ReferenceChanges>(
                          context,
                          listen: false,
                        ).Ref3IsActive,
                      );
                    },
                    child: AutoSizeText(
                      "Clear",
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'PrimaryFont',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex: 10, child: SizedBox()),
          ],
        ),
        Expanded(child: SizedBox()),
        Card(
          color: cardBackgroundColor,
          child: SizedBox(
            height: screenHeight * 0.39578,
            width: screenWidth * 0.15325,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AutoSizeText(
                          "Scale",
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
                        SizedBox(
                          height: screenHeight * 0.04397,
                          width: screenWidth * 0.04427,
                          child: TextField(
                            controller: TextEditingController.fromValue(
                              TextEditingValue(
                                text:
                                    Provider.of<ReferenceChanges>(
                                      context,
                                      listen: false,
                                    ).voltageValueTextperDivision_Ref3,
                              ),
                            ),
                            style: TextStyle(fontSize: 14),
                            obscureText: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(2),
                              border: OutlineInputBorder(),
                              labelText: 'V/Div',
                            ),
                            onSubmitted: (inputText) {
                              setState(() {
                                Provider.of<ReferenceChanges>(
                                  context,
                                  listen: false,
                                ).convertVoltageText2Value_perDivision_Ref3(
                                  inputText,
                                );
                                print(inputText);
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.2647,
                          child: RotatedBox(
                            quarterTurns: -1,
                            child: Listener(
                              onPointerSignal: (event) {
                                if (event is PointerScrollEvent) {
                                  setState(() {
                                    updateRef3_VperDiv(
                                      event.scrollDelta.dy,
                                      context,
                                    );
                                    print(
                                      Provider.of<ReferenceChanges>(
                                        context,
                                        listen: false,
                                      ).Ref3uVperDivision,
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
                                  value: logTransformDivision(
                                    Provider.of<ReferenceChanges>(
                                      context,
                                    ).Ref3uVperDivision,
                                    min_uV_RefperDivision,
                                    max_uV_RefperDivision,
                                  ),
                                  min: 0,
                                  max: 1,
                                  divisions:
                                      (max_uV_RefperDivision /
                                              min_uV_RefperDivision)
                                          .toInt(),
                                  onChanged: (double value) {
                                    double transformedValue =
                                        inverseLogTransformDivision(
                                          value,
                                          min_uV_RefperDivision,
                                          max_uV_RefperDivision,
                                        );
                                    Provider.of<ReferenceChanges>(
                                      context,
                                      listen: false,
                                    ).updateSliderValue_Ref3(transformedValue);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AutoSizeText(
                          "Level",
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.04397,
                                  width: screenWidth * 0.04427,
                                  child: TextField(
                                    controller: TextEditingController.fromValue(
                                      TextEditingValue(
                                        text:
                                            Provider.of<ReferenceChanges>(
                                              context,
                                              listen: false,
                                            ).triggerVerticalOffsetValue2Text_Ref3,
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
                                        Provider.of<ReferenceChanges>(
                                          context,
                                          listen: false,
                                        ).convertTriggerVerticalOffsetText2Value_Ref3(
                                          inputText,
                                        );
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
                                            Provider.of<ReferenceChanges>(
                                              context,
                                              listen: false,
                                            ).incrementRef3VerticalOffset(
                                              -event.scrollDelta.dy / 100,
                                            );
                                            print(
                                              '${Provider.of<ReferenceChanges>(context, listen: false).Ref3Offset}',
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
                                          thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 10,
                                          ),
                                        ),
                                        child: Slider(
                                          value: logTransform(
                                            Provider.of<ReferenceChanges>(
                                              context,
                                              listen: false,
                                            ).Ref3Offset,
                                            max_uV_RefLevelOffset,
                                          ),
                                          min: 0,
                                          max: 1,
                                          divisions:
                                              (max_uV_RefLevelOffset -
                                                      min_uV_RefLevelOffset)
                                                  .toInt(),
                                          onChanged: (double value) {
                                            setState(() {
                                              Provider.of<ReferenceChanges>(
                                                context,
                                                listen: false,
                                              ).updateRef3Offset(
                                                inverseLogTransform(
                                                  value,
                                                  max_uV_RefLevelOffset,
                                                ),
                                              );
                                              print(
                                                'Offset slide: ${(Provider.of<ReferenceChanges>(context, listen: false).Ref3Offset)}',
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
                                      Provider.of<ReferenceChanges>(
                                        context,
                                        listen: false,
                                      ).updateRef3Offset(0);
                                      print(
                                        '${Provider.of<ReferenceChanges>(context, listen: false).Ref3Offset}',
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
        Expanded(child: SizedBox()),
      ],
    );
  }
}
