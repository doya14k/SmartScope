import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'settings_widgets/channel_enable.dart';
import 'settings_widgets/definitions.dart';
import 'package:provider/provider.dart';
import 'package:serial_port_win32/serial_port_win32.dart';

class SignalPage extends StatefulWidget {
  const SignalPage({super.key});

  @override
  State<SignalPage> createState() => _SignalPageState();
}

class _SignalPageState extends State<SignalPage> {
  void updateSlider(double delta, BuildContext context) {
    setState(() {
      final appState = Provider.of<AppState>(context, listen: false);
      appState.updateSliderValue(appState.currentsliderValue - delta / 100);
    });
  }

  void updateTime(double delta, BuildContext context) {
    setState(() {
      final appState = Provider.of<AppState>(context, listen: false);
      appState.updateTimeValue(appState.timeValue - delta / 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChannelEnable(),
        FloatingActionButton(onPressed: () {}, backgroundColor: Colors.amber),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.settings),
          hoverColor: Colors.blue,
        ),
        Text('${SerialPort.getAvailablePorts()}'),
        // ElevatedButton(onPressed: () {}, child: Text("Elevated")),
        // OutlinedButton(onPressed: () {}, child: Text("Outlined")),
        Center(
          child: Container(
            color: Colors.amber,
            height: 200.0,
            width: 30.0,
            child: Listener(
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) {
                  updateSlider(event.scrollDelta.dy, context);
                  // print(currentsliderValue);
                }
              },
              child: RotatedBox(
                quarterTurns: -1,
                child: Slider(
                  value: Provider.of<AppState>(context).currentsliderValue,
                  min: 1.0,
                  max: 100.0,
                  divisions: 100,
                  onChanged: (double value) {
                    Provider.of<AppState>(
                      context,
                      listen: false,
                    ).updateSliderValue(value);
                  },
                ),
              ),
            ),
          ),
        ),

        Center(
          child: Container(
            color: Colors.amber,
            height: 200.0,
            width: 30.0,
            child: Listener(
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) {
                  updateTime(event.scrollDelta.dy, context);
                  // print(currentsliderValue);
                }
              },
              child: RotatedBox(
                quarterTurns: -1,
                child: Slider(
                  value: Provider.of<AppState>(context).timeValue,
                  min: 0.0001,
                  max: 100.0,
                  divisions: 100,
                  onChanged: (double value) {
                    Provider.of<AppState>(
                      context,
                      listen: false,
                    ).updateTimeValue(value);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
