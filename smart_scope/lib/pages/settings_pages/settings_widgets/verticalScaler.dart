import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'definitions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class VerticalScaler extends StatefulWidget {
  const VerticalScaler({super.key});

  @override
  State<VerticalScaler> createState() => _VerticalScalerState();
}

class _VerticalScalerState extends State<VerticalScaler> {
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

  void updateCH1_VperDiv(double delta, BuildContext context) {
    setState(() {
      final appState = Provider.of<AppState>(context, listen: false);
      appState.incrementVoltageValueCH1(-delta / 100);
      print('Delta ${delta / 100}');
      print('appState.ch1 ${appState.ch1_uVoltageValue}');
      appState.updateGraphVoltageValue();
    });
  }

  void updateCH2_VperDiv(double delta, BuildContext context) {
    setState(() {
      final appState = Provider.of<AppState>(context, listen: false);
      appState.incrementVoltageValueCH2(-delta / 100);
      print('Delta ${delta / 100}');
      print('appState.ch2 ${appState.ch2_uVoltageValue}');
      appState.updateGraphVoltageValue();
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
      height: screenHeight * 0.4045,
      width: screenWidth * 0.1172,
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
                  'Vertical',
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'PrimaryFont',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontSize: screenWidth * 0.01041,
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
                            fontSize: screenWidth * 0.01562,
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
                                    ).voltageValueTextCH1,
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
                                Provider.of<AppState>(
                                  context,
                                  listen: false,
                                ).convertVoltageText2ValueCH1(inputText);
                                print(inputText);
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.1759,
                          child: RotatedBox(
                            quarterTurns: -1,
                            child: Listener(
                              onPointerSignal: (event) {
                                if (event is PointerScrollEvent) {
                                  setState(() {
                                    updateCH1_VperDiv(
                                      event.scrollDelta.dy,
                                      context,
                                    );
                                    print(
                                      Provider.of<AppState>(
                                        context,
                                        listen: false,
                                      ).ch1_uVoltageValue,
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
                                    ).ch1_uVoltageValue,
                                    min_uVperDivision,
                                    max_uVperDivision,
                                  ),
                                  min: 0,
                                  max: 1,
                                  divisions:
                                      (max_uVperDivision / min_uVperDivision)
                                          .toInt(),
                                  onChanged: (double value) {
                                    double transformedValue =
                                        inverseLogTransform(
                                          value,
                                          min_uVperDivision,
                                          max_uVperDivision,
                                        );
                                    Provider.of<AppState>(
                                      context,
                                      listen: false,
                                    ).updateSliderValue_ch1(transformedValue);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        PopupMenuButton(
                          tooltip: 'Tastkopf',
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                              child: SizedBox(
                                height: screenHeight * 0.02638,
                                width: screenWidth * 0.0208,
                                child: Center(
                                  child: AutoSizeText(
                                    (channel1.ChannelIs1to1 == true)
                                        ? tastkopfModes[0]
                                        : tastkopfModes[1],
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
                            return List.generate(tastkopfModes.length, (index) {
                              return PopupMenuItem(
                                value: index,
                                child: Text(
                                  tastkopfModes[index],
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
                              if (selectedIndex == 0) {
                                channel1.ChannelIs1to1 = true;
                              } else {
                                channel1.ChannelIs1to1 = false;
                              }
                            });
                          },
                        ),
                        SizedBox(height: screenHeight * 0.0088),
                        PopupMenuButton(
                          tooltip: 'Coupling',
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                              child: SizedBox(
                                height: screenHeight * 0.02638,
                                width: screenWidth * 0.0208,
                                child: Center(
                                  child: AutoSizeText(
                                    (channel1.channelIsDC == true)
                                        ? couplingModes[0]
                                        : couplingModes[1],
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
                            return List.generate(couplingModes.length, (index) {
                              return PopupMenuItem(
                                value: index,
                                child: Text(
                                  couplingModes[index],
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
                              if (selectedIndex == 0) {
                                channel1.channelIsDC = true;
                              } else {
                                channel1.channelIsDC = false;
                              }
                            });
                          },
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
                            fontSize: screenWidth * 0.01562,
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
                                    ).voltageValueTextCH2,
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
                                Provider.of<AppState>(
                                  context,
                                  listen: false,
                                ).convertVoltageText2ValueCH2(inputText);
                                print(inputText);
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.1759,
                          child: RotatedBox(
                            quarterTurns: -1,
                            child: Listener(
                              onPointerSignal: (event) {
                                if (event is PointerScrollEvent) {
                                  setState(() {
                                    updateCH2_VperDiv(
                                      event.scrollDelta.dy,
                                      context,
                                    );
                                    print(
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
                                    ).ch2_uVoltageValue,
                                    min_uVperDivision,
                                    max_uVperDivision,
                                  ),
                                  min: 0,
                                  max: 1,
                                  divisions:
                                      (max_uVperDivision / min_uVperDivision)
                                          .toInt(),
                                  onChanged: (double value) {
                                    double transformedValue =
                                        inverseLogTransform(
                                          value,
                                          min_uVperDivision,
                                          max_uVperDivision,
                                        );
                                    Provider.of<AppState>(
                                      context,
                                      listen: false,
                                    ).updateSliderValue_ch2(transformedValue);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        PopupMenuButton(
                          tooltip: 'Tastkopf',
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                              child: SizedBox(
                                height: screenHeight * 0.02638,
                                width: screenWidth * 0.02083,
                                child: Center(
                                  child: AutoSizeText(
                                    (channel2.ChannelIs1to1 == true)
                                        ? tastkopfModes[0]
                                        : tastkopfModes[1],
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
                            return List.generate(tastkopfModes.length, (index) {
                              return PopupMenuItem(
                                value: index,
                                child: Text(
                                  tastkopfModes[index],
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
                              if (selectedIndex == 0) {
                                channel2.ChannelIs1to1 = true;
                              } else {
                                channel2.ChannelIs1to1 = false;
                              }
                            });
                          },
                        ),
                        SizedBox(height: screenHeight * 0.0088),
                        PopupMenuButton(
                          tooltip: 'Coupling',
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                              child: SizedBox(
                                height: screenHeight * 0.02638,
                                width: screenWidth * 0.02083,
                                child: Center(
                                  child: AutoSizeText(
                                    (channel2.channelIsDC == true)
                                        ? couplingModes[0]
                                        : couplingModes[1],
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
                            return List.generate(couplingModes.length, (index) {
                              return PopupMenuItem(
                                value: index,
                                child: Text(
                                  couplingModes[index],
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
                              if (selectedIndex == 0) {
                                channel2.channelIsDC = true;
                              } else {
                                channel2.channelIsDC = false;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(flex: 1),
              ],
            ),

            // Row(
            //   children: [
            //     Spacer(flex: 10),
            //     AutoSizeText(
            //       '1:1',
            //       maxLines: 1,
            //       style: TextStyle(
            //         fontFamily: 'PrimaryFont',
            //         fontWeight: FontWeight.normal,
            //         fontSize: 17,
            //         color: Colors.black,
            //       ),
            //     ),
            //     Spacer(flex: 5),
            //     AutoSizeText(
            //       '10:1',
            //       maxLines: 1,
            //       style: TextStyle(
            //         fontFamily: 'PrimaryFont',
            //         fontWeight: FontWeight.normal,
            //         fontSize: 17,
            //         color: Colors.black,
            //       ),
            //     ),
            //     Spacer(flex: 35),
            //   ],
            // ),
            // Row(
            //   children: [
            //     SizedBox(width: 10),
            // AutoSizeText(
            //   'CH1',
            //   maxLines: 1,
            //   style: TextStyle(
            //     fontFamily: 'PrimaryFont',
            //     fontWeight: FontWeight.bold,
            //     fontSize: 20,
            //     color: channel1.channelColor,
            //   ),
            // ),
            //     SizedBox(width: 10),
            //     RotatedBox(
            //       quarterTurns: 2,
            //       child: Switch(
            //         focusColor: clear,
            //         hoverColor: clear,
            //         activeColor: TastkopfSwitchBackgroundColor,
            //         inactiveTrackColor: TastkopfSwitchBackgroundColor,
            //         trackOutlineColor: WidgetStatePropertyAll(Colors.black),
            //         inactiveThumbColor: Colors.black,
            //         thumbColor: WidgetStatePropertyAll(Colors.black),
            //         thumbIcon: WidgetStatePropertyAll(
            //           Icon(Icons.circle, color: Colors.black),
            //         ),
            //         value: channel1.ChannelIs1to1,
            //         onChanged: (newSelect) {
            //           setState(() {
            //             channel1.ChannelIs1to1 = newSelect;
            //             print('CH1: 1:1 ${channel1.ChannelIs1to1}');
            //           });
            //         },
            //       ),
            //     ),
            //     Expanded(
            //       child: Listener(
            //         onPointerSignal: (event) {
            //           if (event is PointerScrollEvent) {
            //             updateCH1_VperDiv(event.scrollDelta.dy, context);
            //             print(
            //               Provider.of<AppState>(
            //                 context,
            //                 listen: false,
            //               ).timeValue,
            //             );
            //           }
            //         },
            //         child: SliderTheme(
            //           data: SliderThemeData(
            //             trackShape: RectangularSliderTrackShape(),
            //             trackHeight: 5.0,
            //             activeTrackColor: Colors.grey,
            //             inactiveTrackColor: Colors.grey,
            //             thumbColor: Colors.black,
            //             thumbShape: RoundSliderThumbShape(
            //               enabledThumbRadius: 10,
            //             ),
            //           ),
            //           child: Slider(
            //             value: logTransform(
            //               Provider.of<AppState>(context).timeValue,
            //               min_uSperDivision,
            //               max_uSperDivision,
            //             ),
            //             min: 0,
            //             max: 1,
            //             divisions:
            //                 (max_uSperDivision / min_uSperDivision).toInt(),
            //             onChanged: (double value) {
            //               double transformedValue = inverseLogTransform(
            //                 value,
            //                 min_uSperDivision,
            //                 max_uSperDivision,
            //               );
            //               Provider.of<AppState>(
            //                 context,
            //                 listen: false,
            //               ).updateTimeValue(transformedValue);
            //             },
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            // Row(
            //   children: [
            //     Spacer(flex: 2),
            //     AutoSizeText(
            //       'CH2',
            //       maxLines: 1,
            //       style: TextStyle(
            //         fontFamily: 'PrimaryFont',
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20,
            //         color: channel2.channelColor,
            //       ),
            //     ),
            //     Spacer(flex: 2),
            //     RotatedBox(
            //       quarterTurns: 2,
            //       child: Switch(
            //         focusColor: clear,
            //         hoverColor: clear,
            //         activeColor: TastkopfSwitchBackgroundColor,
            //         inactiveTrackColor: TastkopfSwitchBackgroundColor,
            //         trackOutlineColor: WidgetStatePropertyAll(Colors.black),
            //         inactiveThumbColor: Colors.black,
            //         thumbColor: WidgetStatePropertyAll(Colors.black),
            //         thumbIcon: WidgetStatePropertyAll(
            //           Icon(Icons.circle, color: Colors.black),
            //         ),
            //         value: channel2.ChannelIs1to1,
            //         onChanged: (newSelect) {
            //           setState(() {
            //             channel2.ChannelIs1to1 = newSelect;
            //             print('CH2: 1:1 ${channel2.ChannelIs1to1}');
            //           });
            //         },
            //       ),
            //     ),
            //     Spacer(flex: 3),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
