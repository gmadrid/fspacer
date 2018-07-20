import 'package:flutter/material.dart';
import 'package:fspacer/leitner/game.dart';

class StatusWidget extends StatelessWidget {
  StatusWidget(this._game);

  final Game _game;

  @override
  Widget build(BuildContext context) {
    var theme = buildStatusTheme(Theme.of(context));
    return Theme(
        data: theme,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _game.status,
                  style: theme.textTheme.display1,
                )
              ],
            ))
          ],
        ));
  }

  ThemeData buildStatusTheme(ThemeData base) {
    return base.copyWith(backgroundColor: Colors.red);
  }
}
