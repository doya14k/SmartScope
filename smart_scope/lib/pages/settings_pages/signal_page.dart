import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'settings_widgets/channel_enable.dart';
import 'settings_widgets/definitions.dart';

class SignalPage extends StatefulWidget {
  const SignalPage({super.key});

  @override
  State<SignalPage> createState() => _SignalPageState();
}

class _SignalPageState extends State<SignalPage> {

  void updateSlider(double delta) {
    setState(() {
      currentsliderValue = (currentsliderValue - delta / 100).clamp(0.0, 100.0);
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
                  updateSlider(event.scrollDelta.dy);
                  print(currentsliderValue);
                }
              },
              child: RotatedBox(
                quarterTurns: -1,
                child: Slider(
                  value: currentsliderValue,
                  min: 1.0,
                  max: 100.0,
                  divisions: 100,
                  onChanged: (double value) {
                    setState(() {
                      currentsliderValue = value;
                      print(currentsliderValue);
                    });
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
