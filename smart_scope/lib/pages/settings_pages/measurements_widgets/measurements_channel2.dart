import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'definitionMeasurements.dart';
import 'package:provider/provider.dart';

class MeasurementsSettingsChannel2 extends StatefulWidget {
  const MeasurementsSettingsChannel2({super.key});

  @override
  State<MeasurementsSettingsChannel2> createState() =>
      _MeasurementsSettingsChannel2State();
}

class _MeasurementsSettingsChannel2State
    extends State<MeasurementsSettingsChannel2> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(20),
      color: channel2_lightBackgroundColor,
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
                    Expanded(child: SizedBox(), flex: 10),
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
                                    ).measCH2_Period)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH2_Period();
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
                                    ).measCH2_Frequency)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH2_Frequency();
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
                                    ).measCH2_widthPos)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH2_widthPos();
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
                                    ).measCH2_widthNeg)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH2_widthNeg();
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
                                    ).measCH2_DutyPos)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH2_dutyPos();
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
                                    ).measCH2_DutyNeg)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH2_dutyNeg();
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
                    Expanded(child: SizedBox(), flex: 10),
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
                                    ).measCH2_Vmax)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH2_Vmax();
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
                                    ).measCH2_Vmin)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH2_Vmin();
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
                                    ).measCH2_Vtop)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH2_Vtop();
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
                                    ).measCH2_Vbase)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH2_Vbase();
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
                                    ).measCH2_Vpp)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH2_Vpp();
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
                                    ).measCH2_Vamp)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH2_Vamp();
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
                                    ).measCH2_Vavg)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH2_Vavg();
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
                                    ).measCH2_Vrms)
                                    ? measurementSelectedBackground
                                    : measurementnotSelectedBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<MeasurementsChanges>(
                                context,
                                listen: false,
                              ).update_measCH2_Vrms();
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
