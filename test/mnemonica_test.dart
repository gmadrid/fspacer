import 'package:fspacer/leitner/mnemonica.dart';
import 'package:test/test.dart';

void main() {
  test('All cards present', () {
    var cards = mnemonica.split(":");

    expect(52, cards.length);

    List<String> suits = ["S", "C", "H", "D"];
    List<String> pips = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K"];

    for (var suit in suits){
      for (var pip in pips) {
        var val = pip + suit;
        expect(cards, contains(val));
      }
    }
  });
}