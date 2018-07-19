import 'package:flutter/material.dart';

import 'game_widget.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "Mnemonica Tutor",
        theme: ThemeData(
          primaryColor: Colors.purple,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Mnemonica Tutor"),
          ),
          body: GameWidget(),
        ));
  }
}
