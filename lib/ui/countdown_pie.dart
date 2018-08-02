import 'dart:math';

import 'package:flutter/material.dart';

class CountdownPie extends StatelessWidget {
  CountdownPie({@required double currentPct}) : _currentPct = currentPct;

  final double _currentPct;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        foregroundPainter: ArcPainter(
            current: _currentPct, color: Theme.of(context).accentColor),
        child: Container());
  }
}

class ArcPainter extends CustomPainter {
  ArcPainter({double min, double max, @required double current, Color color})
      : this._min = min ?? 0.0,
        this._max = max ?? 100.0,
        this._current = current,
        this._color = color ?? Colors.black;

  final double _min;
  final double _max;
  final double _current;
  final Color _color;

  @override
  void paint(Canvas canvas, Size size) {
    var pct = (_current - _min) / (_max - _min);
    canvas.drawArc(Offset.zero & size, -pi / 2, -2 * pi * (1 - pct), true,
        Paint()..color = _color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
