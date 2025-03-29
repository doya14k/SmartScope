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

  double topMargin = 50.0;
  double leftMargin = 10.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(top: topMargin, left: leftMargin, child: ChannelEnable()),
          Positioned(
            top: topMargin,
            left: leftMargin + 145,
            child: TriggerModeSelector(),
          ),
          Positioned(
            top: topMargin,
            left: leftMargin + 350,
            child: TriggerStateSelector(),
          ),
          Positioned(
            top: topMargin + 168,
            left: leftMargin + 350,
            child: TriggerChannelSelection(),
          ),
          Positioned(
            top: topMargin + 165,
            left: leftMargin,
            child: HorizontalScaler(),
          ),
          Positioned(
            top: topMargin + 290,
            left: leftMargin,
            child: HorizontalTriggerScaler(),
          ),
          Positioned(
            top: topMargin + 415,
            left: leftMargin + 325,
            child: VerticalScaler(),
          ),
          Positioned(
            top: topMargin + 415,
            left: leftMargin,
            child: LevelOffsetShifter(),
          ),
        ],
      ),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Positioned(child: TriggerChannelSelection(), bottom: 100.0),
      //     Positioned(child: ChannelEnable(), bottom: 100.0),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         // Expanded(child: Container()),
      //         // ChannelEnable(),
      //         // Expanded(child: Container()),
      //         // TriggerModeSelector(),
      //         // TriggerChannelSelection()
      //         // StreamBuilder<String>(
      //         //   stream: dataController.stream,
      //         //   builder: (context, snapshot) {
      //         //     if (snapshot.hasData) {
      //         //       return Text("Letzte Nachricht: ${snapshot.data}");
      //         //     } else {
      //         //       return Text("Warte auf Daten...");
      //         //     }
      //         //   },
      //         // ),
      //         // PopupMenuButton(
      //         //   child: SizedBox(
      //         //     height: 100,
      //         //     width: 200,
      //         //     child: Container(
      //         //       color: Colors.amber,
      //         //       child: Center(child: Text('$selectedTestChannel')),
      //         //     ),
      //         //   ),
      //         //   itemBuilder: (context) {
      //         //     return List.generate(channels.length, (index) {
      //         //       return PopupMenuItem(
      //         //         child: Text('${channels[index].channelName}'),
      //         //         onTap: () {
      //         //           setState(() {
      //         //             selectedTestChannel = '${channels[index].channelName}';
      //         //             print('${channels[index].channelName}');
      //         //           });
      //         //         },
      //         //       );
      //         //     });
      //         //   },
      //         // ),
      //         // FloatingActionButton(onPressed: () {}, backgroundColor: Colors.amber),
      //         // IconButton(
      //         //   onPressed: () {},
      //         //   icon: Icon(Icons.settings),
      //         //   hoverColor: Colors.blue,
      //         // ),
      //         // Center(
      //         //   child: Container(
      //         //     color: Colors.grey[400],
      //         //     height: 200.0,
      //         //     width: 30.0,
      //         //     child: Listener(
      //         //       onPointerSignal: (event) {
      //         //         if (event is PointerScrollEvent) {
      //         //           updateSlider(event.scrollDelta.dy, context);
      //         //           print(channel1.uVperDivision);
      //         //         }
      //         //       },
      //         //       child: RotatedBox(
      //         //         quarterTurns: -1,
      //         //         child: SliderTheme(
      //         //           data: SliderThemeData(
      //         //             trackShape: RectangularSliderTrackShape(),
      //         //             trackHeight: 3.0,
      //         //             activeTrackColor: Colors.white,
      //         //             inactiveTrackColor: Colors.white,
      //         //             thumbColor: Colors.black,
      //         //             thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
      //         //           ),
      //         //           child: Slider(
      //         //             value: Provider.of<AppState>(context).ch1_uVoltageValue,
      //         //             min: 1.0,
      //         //             max: 100.0,
      //         //             divisions: 100,
      //         //             onChanged: (double value) {
      //         //               Provider.of<AppState>(
      //         //                 context,
      //         //                 listen: false,
      //         //               ).updateSliderValue_ch1();
      //         //               channel1.uVperDivision = value;
      //         //             },
      //         //           ),
      //         //         ),
      //         //       ),
      //         //     ),
      //         //   ),
      //         // ),
      //         // Center(
      //         //   child: Container(
      //         //     color: Colors.grey[400],
      //         //     height: 200.0,
      //         //     width: 30.0,
      //         //     child: Listener(
      //         //       onPointerSignal: (event) {
      //         //         if (event is PointerScrollEvent) {
      //         //           updateTime(event.scrollDelta.dy, context);
      //         //           // print(ch1_uVoltageValue);
      //         //         }
      //         //       },
      //         //       child: RotatedBox(
      //         //         quarterTurns: -1,
      //         //         child: SliderTheme(
      //         //           data: SliderThemeData(
      //         //             trackShape: RectangularSliderTrackShape(),
      //         //             trackHeight: 3.0,
      //         //             activeTrackColor: Colors.white,
      //         //             inactiveTrackColor: Colors.white,
      //         //             thumbColor: Colors.black,
      //         //             thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
      //         //           ),
      //         //           child: Slider(
      //         //             value: Provider.of<AppState>(context).timeValue,
      //         //             min: 0.0001,
      //         //             max: 100.0,
      //         //             divisions: 100,

      //         //             onChanged: (double value) {
      //         //               Provider.of<AppState>(
      //         //                 context,
      //         //                 listen: false,
      //         //               ).updateTimeValue(value);
      //         //             },
      //         //           ),
      //         //         ),
      //         //       ),
      //         //     ),
      //         //   ),
      //         // ),
      //       ],
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         // TriggerChannelSelection(),
      //         HorizontalScaler(),
      //       ],
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      //       children: [VerticalScaler(), LevelOffsetShifter()],
      //     ),
      //   ],
      // ),
    );
  }
}
