import 'package:flutter/material.dart';

import 'package:fspacer/ui/card_helpers.dart';
import 'package:fspacer/ui/countdown_pie.dart';

class DisplayWidget extends StatelessWidget {
  DisplayWidget(this.currentCard);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(children: <Widget>[
      Container(
          color: Color(0xfff0f0f0),
          alignment: Alignment.center,
          child: Card(
              child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 96.0,
                        color: Color(0xff000000),
                      ),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: cardTexts(currentCard)))))),
      Positioned(
          top: 0.0,
          right: 0.0,
          width: 60.0,
          height: 60.0,
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CountdownPie(
                currentPct: 40.0,
              ))),
    ]));
  }

  final String currentCard;
}
