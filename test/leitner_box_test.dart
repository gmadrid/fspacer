import 'package:test/test.dart';

import 'package:fspacer/leitner_box.dart';
import 'package:fspacer/question.dart';

String Q(num index) {
  return "Question $index";
}

String A(num index) {
  return "Answer $index";
}

LeitnerBox SimpleTestSet(num size) {
  var questions = List<Question>();

  for (var i = 0; i < size; ++i) {
    questions.add(Question(Q(i), A(i)));
  }

  var lb = LeitnerBox();
  lb.AddQuestions(questions);
  return lb;
}

void main() {
  test("empty", () {
    var lb = LeitnerBox();

    expect(lb.Size(), equals(0));

    for (var i = LeitnerBox.waiting_bucket; i <= LeitnerBox.last_bucket; ++i) {
      lb.Shuffle(i);
      expect(lb.BucketSize(i), equals(0));
    }

    lb.MoveToFirst(0);
    lb.MoveUp(0);
  });
}