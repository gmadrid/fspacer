import 'package:flutter/material.dart';
import 'package:fspacer/leitner/game.dart';

class StatusWidget extends StatelessWidget {
  StatusWidget(this._game);

  final Game _game;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                color: themeData.primaryColor,
                alignment: Alignment.centerLeft,
                child: Text(
                  _game.status,
                  style: themeData.textTheme.display1
                      .copyWith(color: Colors.white),
                )))
      ],
    );
  }
}
