import 'package:flutter/material.dart';
import 'settings_widgets/channel_enable.dart';
import 'settings_widgets/definitions.dart';
import 'package:provider/provider.dart';
import 'settings_widgets/triggerModeSelect.dart';
import 'settings_widgets/triggerChannelSelection.dart';
import 'settings_widgets/horizontalScale.dart';
import 'settings_widgets/verticalScaler.dart';
import 'settings_widgets/levelOffsetShifter.dart';
import 'settings_widgets/triggerStateSelect.dart';
import 'settings_widgets/triggerScalerHorizontal.dart';

class SignalPage extends StatefulWidget {
  const SignalPage({super.key});

  @override
  State<SignalPage> createState() => _SignalPageState();
}

class _SignalPageState extends State<SignalPage> {
  void updateSlider(double delta, BuildContext context) {
    setState(() {
      final appState = Provider.of<AppState>(context, listen: false);
      channel1.uVperDivision =
          appState.ch1_uVoltageValue - delta / max_uVperDivision;
      appState.updateSliderValue_ch1(
        appState.ch1_uVoltageValue - delta / max_uVperDivision,
      );
    });
  }

  void updateTime(double delta, BuildContext context) {
    setState(() {
      final appState = Provider.of<AppState>(context, listen: false);
      appState.updateTimeValue(appState.timeValue - delta / max_uSperDivision);
    });
  }

  double topMargin = 0.0;
  double leftMargin = 10.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(
        children: [
          Positioned(top: topMargin, left: leftMargin, child: ChannelEnable()),
          Positioned(
            top: topMargin,
            left: screenWidth * 0.0807,
            child: TriggerModeSelector(),
          ),
          Positioned(
            top: topMargin,
            left: screenWidth * 0.1875,
            child: TriggerStateSelector(),
          ),
          Positioned(
            top: screenHeight * 0.1477,
            left: screenWidth * 0.1875,
            child: TriggerChannelSelection(),
          ),
          Positioned(
            top: screenHeight * 0.1477,
            left: leftMargin,
            child: HorizontalScaler(),
          ),
          Positioned(
            top: screenHeight * 0.2726,
            left: leftMargin,
            child: HorizontalTriggerScaler(),
          ),
          Positioned(
            top: screenHeight * 0.4,
            left: leftMargin,
            child: LevelOffsetShifter(),
          ),
          Positioned(
            top: screenHeight * 0.4,
            left: screenWidth * 0.1744,
            child: VerticalScaler(),
          ),
        ],
      ),
    );
  }
}
