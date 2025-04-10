import 'package:flutter/material.dart';
import 'package:smart_scope/pages/monitoring_page.dart';
import 'settings_pages/signal_page.dart';
import 'settings_pages/settings_widgets/definitions.dart';
import 'settings_pages/measurement_page.dart';
import 'settings_pages/reference_page.dart';
import 'settings_pages/cursor_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: MonitorSizePercentage,
            child: Container(
              color: MonitorBackroundColor,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [MonitoringPage()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(flex: (100 - MonitorSizePercentage), child: SettingsMenu()),
        ],
      ),
    );
  }
}

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

int selectedIndex = 0;

class _SettingsMenuState extends State<SettingsMenu> {
  final List<Widget> pages = [
    SignalPage(),
    MeasurementPage(),
    ReferencePage(),
    CursorPage(),
  ];

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarBackroundColor,
        title: Text(
          "Settings-Menu",
          style: TextStyle(
            fontFamily: 'PrimaryFont',
            fontSize: screenHeight * 0.04,
          ),
        ),
        toolbarHeight: screenHeight * 0.075,
      ),
      body: pages[selectedIndex],
      backgroundColor: BodyBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: BottomNavigationBarBackgroundColor,
        selectedItemColor: SelectedItemColor,
        unselectedItemColor: UnselectedItemColor,
        currentIndex: selectedIndex,
        onTap: changePage,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart_outlined),
            label: "Signal",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Measurements",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_line_chart),
            label: "Reference",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows_rounded),
            label: "Cursor",
          ),
        ],
      ),
    );
  }
}
