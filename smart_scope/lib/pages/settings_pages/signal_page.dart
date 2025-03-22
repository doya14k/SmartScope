import 'package:flutter/material.dart';
import 'settings_widgets/channel_enable.dart';
import 'settings_widgets/definitions.dart';
import 'package:provider/provider.dart';
import 'settings_widgets/triggerModeSelect.dart';
import 'settings_widgets/triggerChannelSelection.dart';
import 'settings_widgets/horizontalScale.dart';
import 'settings_widgets/verticalScaler.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded(child: Container()),
            ChannelEnable(),
            // Expanded(child: Container()),
            TriggerModeSelector(),
            // StreamBuilder<String>(
            //   stream: dataController.stream,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return Text("Letzte Nachricht: ${snapshot.data}");
            //     } else {
            //       return Text("Warte auf Daten...");
            //     }
            //   },
            // ),
            // PopupMenuButton(
            //   child: SizedBox(
            //     height: 100,
            //     width: 200,
            //     child: Container(
            //       color: Colors.amber,
            //       child: Center(child: Text('$selectedTestChannel')),
            //     ),
            //   ),
            //   itemBuilder: (context) {
            //     return List.generate(channels.length, (index) {
            //       return PopupMenuItem(
            //         child: Text('${channels[index].channelName}'),
            //         onTap: () {
            //           setState(() {
            //             selectedTestChannel = '${channels[index].channelName}';
            //             print('${channels[index].channelName}');
            //           });
            //         },
            //       );
            //     });
            //   },
            // ),
            // FloatingActionButton(onPressed: () {}, backgroundColor: Colors.amber),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.settings),
            //   hoverColor: Colors.blue,
            // ),
            // Center(
            //   child: Container(
            //     color: Colors.grey[400],
            //     height: 200.0,
            //     width: 30.0,
            //     child: Listener(
            //       onPointerSignal: (event) {
            //         if (event is PointerScrollEvent) {
            //           updateSlider(event.scrollDelta.dy, context);
            //           print(channel1.uVperDivision);
            //         }
            //       },
            //       child: RotatedBox(
            //         quarterTurns: -1,
            //         child: SliderTheme(
            //           data: SliderThemeData(
            //             trackShape: RectangularSliderTrackShape(),
            //             trackHeight: 3.0,
            //             activeTrackColor: Colors.white,
            //             inactiveTrackColor: Colors.white,
            //             thumbColor: Colors.black,
            //             thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
            //           ),
            //           child: Slider(
            //             value: Provider.of<AppState>(context).ch1_uVoltageValue,
            //             min: 1.0,
            //             max: 100.0,
            //             divisions: 100,
            //             onChanged: (double value) {
            //               Provider.of<AppState>(
            //                 context,
            //                 listen: false,
            //               ).updateSliderValue_ch1();
            //               channel1.uVperDivision = value;
            //             },
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Center(
            //   child: Container(
            //     color: Colors.grey[400],
            //     height: 200.0,
            //     width: 30.0,
            //     child: Listener(
            //       onPointerSignal: (event) {
            //         if (event is PointerScrollEvent) {
            //           updateTime(event.scrollDelta.dy, context);
            //           // print(ch1_uVoltageValue);
            //         }
            //       },
            //       child: RotatedBox(
            //         quarterTurns: -1,
            //         child: SliderTheme(
            //           data: SliderThemeData(
            //             trackShape: RectangularSliderTrackShape(),
            //             trackHeight: 3.0,
            //             activeTrackColor: Colors.white,
            //             inactiveTrackColor: Colors.white,
            //             thumbColor: Colors.black,
            //             thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
            //           ),
            //           child: Slider(
            //             value: Provider.of<AppState>(context).timeValue,
            //             min: 0.0001,
            //             max: 100.0,
            //             divisions: 100,

            //             onChanged: (double value) {
            //               Provider.of<AppState>(
            //                 context,
            //                 listen: false,
            //               ).updateTimeValue(value);
            //             },
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        TriggerChannelSelection(),
        HorizontalScaler(),
        VerticalScaler(),
      ],
    );
  }
}
