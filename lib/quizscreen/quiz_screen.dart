import 'package:flutter/material.dart';

import 'package:fspacer/colors.dart';
import 'game_widget.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildTheme();

    return new MaterialApp(
        title: "Mnemonica Tutor",
        theme: buildTheme(),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Mnemonica Tutor"),
          ),
          body: GameWidget(),
        ));
  }

  ThemeData buildTheme() {
    return ThemeData.light().copyWith(
        accentColor: secondaryColor,
        primaryColor: primaryColor,
        buttonColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        cardColor: surfaceColor,
        textSelectionColor: secondaryColor,
        errorColor: errorColor
    );
  }
}
