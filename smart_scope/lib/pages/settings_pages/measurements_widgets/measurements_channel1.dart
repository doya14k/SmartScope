import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'definitionMeasurements.dart';
import 'package:provider/provider.dart';

class MeasurementsSettingsChannel1 extends StatefulWidget {
  const MeasurementsSettingsChannel1({super.key});

  @override
  State<MeasurementsSettingsChannel1> createState() =>
      _MeasurementsSettingsChannel1State();
}

class _MeasurementsSettingsChannel1State
    extends State<MeasurementsSettingsChannel1> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(20),
      color: channel1_lightBackgroundColor,
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Expanded(child: SizedBox()),
                    AutoSizeText(
                      'Horizontal',
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'PrimaryFont',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(flex: 10, child: SizedBox()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fixedSize: Size(
                              screenWidth * 0.078,
                              screenHeight * 0.053,
                            ),
                            backgroundColor:
                                (Provider.of<MeasurementsChanges>(
                                      context,
                                      listen: true,
                                    ).measCH1_Period)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH1_Period();
                            });
                          },
                          child: AutoSizeText(
                            "Period",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.0088),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fixedSize: Size(
                              screenWidth * 0.078,
                              screenHeight * 0.053,
                            ),
                            backgroundColor:
                                (Provider.of<MeasurementsChanges>(
                                      context,
                                      listen: true,
                                    ).measCH1_Frequency)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH1_Frequency();
                            });
                          },
                          child: AutoSizeText(
                            "Frequency",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fixedSize: Size(
                              screenWidth * 0.078,
                              screenHeight * 0.053,
                            ),
                            backgroundColor:
                                (Provider.of<MeasurementsChanges>(
                                      context,
                                      listen: true,
                                    ).measCH1_widthPos)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH1_widthPos();
                            });
                          },
                          child: AutoSizeText(
                            "Width +",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.0088),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fixedSize: Size(
                              screenWidth * 0.078,
                              screenHeight * 0.053,
                            ),
                            backgroundColor:
                                (Provider.of<MeasurementsChanges>(
                                      context,
                                      listen: true,
                                    ).measCH1_widthNeg)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH1_widthNeg();
                            });
                          },
                          child: AutoSizeText(
                            "Width -",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fixedSize: Size(
                              screenWidth * 0.078,
                              screenHeight * 0.053,
                            ),
                            backgroundColor:
                                (Provider.of<MeasurementsChanges>(
                                      context,
                                      listen: true,
                                    ).measCH1_DutyPos)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH1_dutyPos();
                            });
                          },
                          child: AutoSizeText(
                            "Duty-Cycle +",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.0088),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fixedSize: Size(
                              screenWidth * 0.078,
                              screenHeight * 0.053,
                            ),
                            backgroundColor:
                                (Provider.of<MeasurementsChanges>(
                                      context,
                                      listen: true,
                                    ).measCH1_DutyNeg)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH1_dutyNeg();
                            });
                          },
                          child: AutoSizeText(
                            "Duty-Cycle -",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Expanded(child: SizedBox()),
                    AutoSizeText(
                      'Vertical',
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'PrimaryFont',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(flex: 10, child: SizedBox()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fixedSize: Size(
                              screenWidth * 0.078,
                              screenHeight * 0.053,
                            ),
                            backgroundColor:
                                (Provider.of<MeasurementsChanges>(
                                      context,
                                      listen: true,
                                    ).measCH1_Vmax)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH1_Vmax();
                            });
                          },
                          child: AutoSizeText(
                            "Vmax",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.0088),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fixedSize: Size(
                              screenWidth * 0.078,
                              screenHeight * 0.053,
                            ),
                            backgroundColor:
                                (Provider.of<MeasurementsChanges>(
                                      context,
                                      listen: true,
                                    ).measCH1_Vmin)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH1_Vmin();
                            });
                          },
                          child: AutoSizeText(
                            "Vmin",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.044),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fixedSize: Size(
                              screenWidth * 0.078,
                              screenHeight * 0.053,
                            ),
                            backgroundColor:
                                (Provider.of<MeasurementsChanges>(
                                      context,
                                      listen: true,
                                    ).measCH1_Vtop)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH1_Vtop();
                            });
                          },
                          child: AutoSizeText(
                            "Vtop",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.0088),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fixedSize: Size(
                              screenWidth * 0.078,
                              screenHeight * 0.053,
                            ),
                            backgroundColor:
                                (Provider.of<MeasurementsChanges>(
                                      context,
                                      listen: true,
                                    ).measCH1_Vbase)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH1_Vbase();
                            });
                          },
                          child: AutoSizeText(
                            "Vbase",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(flex: 4, child: SizedBox()),
                    Column(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fixedSize: Size(
                              screenWidth * 0.078,
                              screenHeight * 0.053,
                            ),
                            backgroundColor:
                                (Provider.of<MeasurementsChanges>(
                                      context,
                                      listen: true,
                                    ).measCH1_Vpp)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH1_Vpp();
                            });
                          },
                          child: AutoSizeText(
                            "Vpp",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.0088),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fixedSize: Size(
                              screenWidth * 0.078,
                              screenHeight * 0.053,
                            ),
                            backgroundColor:
                                (Provider.of<MeasurementsChanges>(
                                      context,
                                      listen: true,
                                    ).measCH1_Vamp)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH1_Vamp();
                            });
                          },
                          child: AutoSizeText(
                            "Vamp",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.044),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fixedSize: Size(
                              screenWidth * 0.078,
                              screenHeight * 0.053,
                            ),
                            backgroundColor:
                                (Provider.of<MeasurementsChanges>(
                                      context,
                                      listen: true,
                                    ).measCH1_Vavg)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH1_Vavg();
                            });
                          },
                          child: AutoSizeText(
                            "Vavg",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.0088),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            fixedSize: Size(
                              screenWidth * 0.078,
                              screenHeight * 0.053,
                            ),
                            backgroundColor:
                                (Provider.of<MeasurementsChanges>(
                                      context,
                                      listen: true,
                                    ).measCH1_Vrms)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH1_Vrms();
                            });
                          },
                          child: AutoSizeText(
                            "Vrms",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'PrimaryFont',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(flex: 30, child: SizedBox()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
