import 'dart:math';

import 'package:flutter/material.dart';

class PacMan extends StatelessWidget {
  PacMan({@required double currentPct}) {
    _currentPct = currentPct;
  }

  double _currentPct;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        foregroundPainter:
        ArcPainter(current: _currentPct, color: Theme.of(context).accentColor),
        child: Container());
  }
}

class ArcPainter extends CustomPainter {
  ArcPainter({double min, double max, @required double current, Color color}) {
    this._min = min ?? 0.0;
    this._max = max ?? 100.0;
    this._current = current;
    this._color = color ?? Colors.black;
  }

  double _min;
  double _max;
  double _current;
  Color _color;

  @override
  void paint(Canvas canvas, Size size) {
    var pct = (_current - _min) / (_max - _min);
    canvas.drawArc(Offset.zero & size, -pi / 2, 2 * pi * pct, true, Paint()..color = _color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class DisplayWidget extends StatelessWidget {
  DisplayWidget(this.currentCard);

  List<Widget> cardTexts(String cardName) {
    var pips = cardName[0];
    var suit = cardName[1];
    var suitColor = suit == 'H' || suit == 'D' ? Color(0xffff0000) : Color(0xff000000);
    var suitSymbol = symbolForSuit_(suit);
    return [
      Text(pips),
      Text(suitSymbol, style: TextStyle(color: suitColor)),
    ];
  }

  String symbolForSuit_(String suit) {
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
    return suitSymbol;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(children: <Widget>[
      Container(
          color: Color(0xffeeeeee),
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
              child: PacMan(currentPct: 40.0,))),
    ]));
  }

  final String currentCard;
}
