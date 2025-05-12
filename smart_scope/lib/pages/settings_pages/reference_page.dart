import 'package:flutter/material.dart';
import 'reference_widgets/defintionenReference.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'reference_widgets/reference1Widget.dart';
import 'reference_widgets/reference2Widget.dart';
import 'reference_widgets/reference3Widget.dart';

class ReferencePage extends StatefulWidget {
  const ReferencePage({super.key});

  @override
  State<ReferencePage> createState() => _ReferencePageState();
}

class _ReferencePageState extends State<ReferencePage> {
  int selectedReferenceGraph = 1;

  void changeReferenceGraph(int newRefGraph) {
    setState(() {
      selectedReferenceGraph = newRefGraph;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: screenHeight * 0.01759),
        Row(
          children: [
            Expanded(flex: 5, child: SizedBox()),
            Expanded(
              flex: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(
                        screenWidth * 0.0625,
                        screenHeight * 0.06,
                      ),
                      backgroundColor:
                          (selectedReferenceGraph == 1)
                              ? ref1GraphColor
                              : clear3,
                    ),
                    onPressed: () {
                      changeReferenceGraph(1);
                    },
                    child: AutoSizeText(
                      "Ref. 1",
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'PrimaryFont',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color:
                            (selectedReferenceGraph == 1)
                                ? referencenotSelectedText
                                : ref1GraphColor,
                      ),
                    ),
                  ),

                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(
                        screenWidth * 0.0625,
                        screenHeight * 0.06,
                      ),
                      backgroundColor:
                          (selectedReferenceGraph == 2)
                              ? ref2GraphColor
                              : clear3,
                    ),
                    onPressed: () {
                      changeReferenceGraph(2);
                    },
                    child: AutoSizeText(
                      "Ref. 2",
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'PrimaryFont',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color:
                            (selectedReferenceGraph == 2)
                                ? referencenotSelectedText
                                : ref2GraphColor,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(
                        screenWidth * 0.0625,
                        screenHeight * 0.06,
                      ),
                      backgroundColor:
                          (selectedReferenceGraph == 3)
                              ? ref3GraphColor
                              : clear3,
                    ),
                    onPressed: () {
                      changeReferenceGraph(3);
                    },
                    child: AutoSizeText(
                      "Ref. 3",
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'PrimaryFont',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color:
                            (selectedReferenceGraph == 3)
                                ? referencenotSelectedText
                                : ref3GraphColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex: 20, child: SizedBox()),
          ],
        ),
        SizedBox(height: screenHeight * 0.01759),
        Expanded(
          child: Center(
            child:
                (selectedReferenceGraph == 1)
                    ? Reference1()
                    : (selectedReferenceGraph == 2)
                    ? Reference2()
                    : Reference3(),
          ),
        ),
      ],
    );
  }
}
