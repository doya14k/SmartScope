import 'package:flutter/material.dart';
import 'package:smart_scope/pages/settings_pages/cursor_page/definitionenCursor.dart';
import 'package:smart_scope/pages/settings_pages/measurements_widgets/definitionMeasurements.dart';
import 'package:smart_scope/pages/usb_select.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/settings_pages/settings_widgets/definitions.dart';
import 'package:window_manager/window_manager.dart';
import 'pages/settings_pages/reference_widgets/defintionenReference.dart';
import 'usb_reader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    // fullScreen: true,
    //   titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.maximize();
    await windowManager.setTitleBarStyle(TitleBarStyle.normal);
    await windowManager.setMinimumSize(const Size(1503, 845));
    await windowManager.setAspectRatio(16 / 9);
  });
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
        ChangeNotifierProvider(create: (context) => MeasurementsChanges()),
        ChangeNotifierProvider(create: (context) => ReferenceChanges()),
        ChangeNotifierProvider(create: (context) => CursorChanges()),
        ChangeNotifierProvider(create: (context) => UsbProvider()),
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
  void initState() {
    final appState = Provider.of<AppState>(context, listen: false);
    Provider.of<UsbProvider>(context, listen: false).setAppState(appState);
    final measurementProvider = Provider.of<MeasurementsChanges>(
      context,
      listen: false,
    );
    Provider.of<UsbProvider>(
      context,
      listen: false,
    ).setMeasurementState(measurementProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/USB_Select',
      routes: {
        '/USB_Select': (context) => USB_Select(),
        '/HomePage': (context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
