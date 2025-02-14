import 'package:flutter/material.dart';
import 'settings_widgets/channel_enable.dart';

class SignalPage extends StatefulWidget {
  const SignalPage({super.key});

  @override
  State<SignalPage> createState() => _SignalPageState();
}

class _SignalPageState extends State<SignalPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
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
          ElevatedButton(onPressed: () {}, child: Text("Elevated")),
          OutlinedButton(onPressed: () {}, child: Text("Outlined")),
        ],
      ),
    );
  }
}
