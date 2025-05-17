import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:smart_scope/pages/settings_pages/settings_widgets/definitions.dart';
import 'defintionenReference.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:smart_scope/usb_reader.dart';

class Reference1 extends StatefulWidget {
  const Reference1({super.key});

  @override
  State<Reference1> createState() => _Reference1State();
}

class _Reference1State extends State<Reference1> {
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

  void updateRef1_VperDiv(double delta, BuildContext context) {
    setState(() {
      final referenceChanges = Provider.of<ReferenceChanges>(
        context,
        listen: false,
      );
      referenceChanges.incrementVoltageValueperDivision_Ref1(-delta / 100);
      print('Delta ${delta / 100}');
      print('appState.ch1 ${referenceChanges.Ref1uVperDivision}');
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

    final usb = Provider.of<UsbProvider>(context, listen: false);
    final ref = Provider.of<ReferenceChanges>(context, listen: false);
    final appState = Provider.of<AppState>(context, listen: false);

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
                              "CH${selectedReference1Graph + 1}",
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
                      setState(() {
                        Provider.of<ReferenceChanges>(
                          context,
                          listen: false,
                        ).updateRef1IsAcitve(true);
                        print(
                          Provider.of<ReferenceChanges>(
                            context,
                            listen: false,
                          ).Ref1IsActive,
                        );

                        print(ref.Ref1IsActive);
                        // Convert channel plot data to ref data
                        ref.saveReference1Data(
                          usb.dataChannelLists[selectedReference1Graph],
                          (selectedReference1Graph == 0)
                              ? appState.ch1_uVoltageLevelOffset
                              : appState.ch2_uVoltageLevelOffset,
                          (selectedReference1Graph == 0)
                              ? channel1.uVperDivision
                              : channel2.uVperDivision,
                          (selecetTriggerModeIndex == 3)
                              ? (usb.currentTime -
                                  (NOF_xGrids * appState.timeValue))
                              : (appState.minGraphTimeValue),
                          (selecetTriggerModeIndex == 3)
                              ? usb.currentTime
                              : (appState.maxGraphTimeValue),
                          (selectedReference1Graph == 0)
                              ? appState.minGraphVoltageValueCH1
                              : appState.minGraphVoltageValueCH2,
                          (selectedReference1Graph == 0)
                              ? appState.maxGraphVoltageValueCH1
                              : appState.maxGraphVoltageValueCH2,
                        );
                      });
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
                      setState(() {
                        Provider.of<ReferenceChanges>(
                          context,
                          listen: false,
                        ).updateRef1IsAcitve(false);
                        List<FlSpot> empty_dummy = [FlSpot(0, 0)];

                        ref.saveReference1Data(
                          empty_dummy,
                          ref.Ref1Offset,
                          ref.Ref1uVperDivision,
                          0,
                          0,
                          ref.minGraphVoltageValueRef1,
                          ref.maxGraphVoltageValueRef1,
                        );
                      });
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
                                    ).voltageValueTextperDivision_Ref1,
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
                                ).convertVoltageText2Value_perDivision_Ref1(
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
                                    updateRef1_VperDiv(
                                      event.scrollDelta.dy,
                                      context,
                                    );
                                    print(
                                      Provider.of<ReferenceChanges>(
                                        context,
                                        listen: false,
                                      ).Ref1uVperDivision,
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
                                    ).Ref1uVperDivision,
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
                                    ).updateSliderValue_Ref1(transformedValue);
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
                                            ).triggerVerticalOffsetValue2Text_Ref1,
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
                                        ).convertTriggerVerticalOffsetText2Value_Ref1(
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
                                            ).incrementRef1VerticalOffset(
                                              -event.scrollDelta.dy / 100,
                                            );
                                            print(
                                              '${Provider.of<ReferenceChanges>(context, listen: false).Ref1Offset}',
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
                                            ).Ref1Offset,
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
                                              ).updateRef1Offset(
                                                inverseLogTransform(
                                                  value,
                                                  max_uV_RefLevelOffset,
                                                ),
                                              );
                                              print(
                                                'Offset slide: ${(Provider.of<ReferenceChanges>(context, listen: false).Ref1Offset)}',
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
                                      ).updateRef1Offset(0);
                                      print(
                                        '${Provider.of<ReferenceChanges>(context, listen: false).Ref1Offset}',
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
