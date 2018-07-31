import 'package:flutter/material.dart';

class DisplayWidget extends StatelessWidget {
  DisplayWidget(this.currentCard);

  @override
  Widget build(BuildContext context) {
    var pips = currentCard[0];
    var suit = currentCard[1];
    var suitColor =
    suit == 'H' || suit == 'D' ? Color(0xffff0000) : Color(0xff000000);
    var suitSymbol;
    switch (suit) {
      case 'H':
        suitSymbol = "\u2665";
        break;
      case 'S':
        suitSymbol = "\u2660";
        break;
      case 'D':
        suitSymbol = "\u2666";
        break;
      case 'C':
        suitSymbol = "\u2663";
        break;
    }

    return Expanded(
        child: Container(
            color: Color(0xffdddddd),
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
                            children: <Widget>[
                              Text(pips),
                              Text(suitSymbol,
                                  style: TextStyle(color: suitColor)),
                            ]))))));
  }

  final String currentCard;
}
