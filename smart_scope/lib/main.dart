import 'package:flutter/material.dart';
import 'package:smart_scope/pages/settings_pages/measurements_widgets/definitionMeasurements.dart';
import 'package:smart_scope/pages/usb_select.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/settings_pages/settings_widgets/definitions.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await windowManager.ensureInitialized();

  // WindowOptions windowOptions = WindowOptions(
  //   fullScreen: false,
  //   titleBarStyle: TitleBarStyle.normal,
  // );
  // windowManager.waitUntilReadyToShow(windowOptions, () async {
  //   await windowManager.show();
  //   // await windowManager.maximize();
  //   await windowManager.setTitleBarStyle(TitleBarStyle.normal);
  //   await windowManager.setMinimumSize(const Size(1503, 845));
  //   await windowManager.setAspectRatio(16 / 9);
  // });
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
        ChangeNotifierProvider(create: (context) => MeasurementsChanges()),
      ],
      child: MyApp(),
    ),
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
      initialRoute: '/HomePage',
      routes: {
        '/USB_Select': (context) => USB_Select(),
        '/HomePage': (context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
