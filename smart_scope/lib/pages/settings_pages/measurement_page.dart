import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:smart_scope/pages/settings_pages/measurements_widgets/measurements_channel1.dart';
import 'settings_widgets/definitions.dart';
import 'measurements_widgets/definitionMeasurements.dart';
import 'measurements_widgets/measurements_channel2.dart';

class MeasurementPage extends StatefulWidget {
  const MeasurementPage({super.key});

  @override
  State<MeasurementPage> createState() => _MeasurementPageState();
}

class _MeasurementPageState extends State<MeasurementPage> {
  void switchMeasurementSettingsChannel(int newChannel) {
    selectedMeasurementSettingsChannel = newChannel;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.018),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: 6,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(
                        screenWidth * 0.0625,
                        screenHeight * 0.045,
                      ),
                      backgroundColor:
                          (selectedMeasurementSettingsChannel == 0)
                              ? channel1.channelColor
                              : clear,
                    ),
                    onPressed: () {
                      setState(() {
                        switchMeasurementSettingsChannel(0);
                      });
                    },
                    child: AutoSizeText(
                      "CH1",
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'PrimaryFont',
                        fontWeight: FontWeight.bold,
                        fontSize: ActivateChannelFontSize,
                        color:
                            (selectedMeasurementSettingsChannel == 0)
                                ? ChannelSelected_fontColor
                                : channel1.channelColor,
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 6,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(
                        screenWidth * 0.0625,
                        screenHeight * 0.045,
                      ),
                      backgroundColor:
                          (selectedMeasurementSettingsChannel == 1)
                              ? channel2.channelColor
                              : clear,
                    ),
                    onPressed: () {
                      setState(() {
                        switchMeasurementSettingsChannel(1);
                      });
                    },
                    child: AutoSizeText(
                      "CH2",
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'PrimaryFont',
                        fontWeight: FontWeight.bold,
                        fontSize: ActivateChannelFontSize,
                        color:
                            (selectedMeasurementSettingsChannel == 1)
                                ? ChannelSelected_fontColor
                                : channel2.channelColor,
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 10, child: SizedBox()),
              ],
            ),
          ),
          Expanded(
            flex: 20,
            child: Row(
              children: [
                Expanded(
                  flex: 30,
                  child:
                      (selectedMeasurementSettingsChannel == 0)
                          ? MeasurementsSettingsChannel1()
                          : MeasurementsSettingsChannel2(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
