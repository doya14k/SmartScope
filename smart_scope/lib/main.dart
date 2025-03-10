import 'package:flutter/material.dart';
import 'package:smart_scope/pages/usb_select.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/settings_pages/settings_widgets/definitions.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => AppState(), child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: USB_Select(),
      initialRoute: '/USB_Select',
      routes: {
        '/USB_Select': (context) => USB_Select(),
        '/HomePage': (context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
