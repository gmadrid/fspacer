import 'package:fspacer/leitner/schedule.dart';
import 'package:test/test.dart';

void main() {
  test('Base', () {
    var s = Schedule(7);
    expect(s.current(), equals(1));
  });

  test('FirstPop', () {
    var s = Schedule(4);

    expect(s.current(), equals(1));
    s.popCurrent();
    expect(s.current(), equals(2));
  });

  test('extended', (){
    var s = Schedule(4);

    // 1/2/3/4
    expect(s.current(), equals(1));
    s.popCurrent();

    // 2 1/3/4
    expect(s.current(), equals(2));
    s.popCurrent();

    // 1/3/4 2
    expect(s.current(), equals(1));
    s.popCurrent();

    // 3 1/4/2
    expect(3, equals(s.current()));
    expect(s.current(), equals(3));
    s.popCurrent();

    // 1/4 2//3
    expect(s.current(), equals(1));
    s.popCurrent();

    // 4 2 1//3
    expect(s.current(), equals(4));
    s.popCurrent();

    // 2 1 //3//4
    expect(s.current(), equals(2));
    s.popCurrent();

    // 1//3 2//4
    expect(s.current(), equals(1));
    s.popCurrent();

    // 1/3 2//4
    expect(s.current(), equals(1));
    s.popCurrent();

    // 3 2 1 //4
    expect(s.current(), equals(3));
    s.popCurrent();

    // 2 1//4/3
    expect(s.current(), equals(2));
    s.popCurrent();

    // 1//4 2/3
    expect(s.current(), equals(1));
    s.popCurrent();

    // 1/4 2/3
    expect(s.current(), equals(1));
    s.popCurrent();

    // 4 2 1/3
    expect(s.current(), equals(4));
  });
}