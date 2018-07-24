import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'quizscreen/quiz_screen.dart';

// TODO
// - persistence
// - style status bar
// - write a Card keyboard
// - handle input
// - add timer
// - update status bar with messages for:
//   - changing buckets
//   - number of questions left in box
// - toast when adding new questions to bucket 1.
// - deal with game end when no more questions anywhere!

void main() {
  //debugPaintSizeEnabled = true;
  runApp(new QuizScreen());
}
