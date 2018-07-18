import 'package:fspacer/leitner/question.dart';
import 'package:test/test.dart';

main() {
  test("Default question", () {
    var q = Question("foo", "barb");
    expect(q.q, equals("foo"));
    expect(q.a, equals("barb"));
  });

  test("Equality and hash", () {
    var q1 = Question("Quux", "Foo");
    var q2 = Question("Quux", "Foo");
    expect(q1, equals(q2));

    expect(q1.hashCode, equals(q2.hashCode));
  });

  test("case-insensitive match", () {
    var q = Question("QQ", "AnSwEr");
    expect(q.match("answer"), isTrue);
    expect(q.match("ANSWER"), isTrue);
    expect(q.match("aNsWeR"), isTrue);
  });
}
