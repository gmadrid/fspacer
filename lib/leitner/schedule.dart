class Schedule {
  List<List<num>> _buckets;

  Schedule(num numBuckets) {
    _buckets = new List()..length = numBuckets;
    for (var i = 0; i < numBuckets; ++i) {
      _buckets[i] = new List()..add(i + 1);
    }
  }

  num current() {
    return _buckets.first.first;
  }

  void popCurrent() {
    var val = current();

    while (_buckets.length < val + 1) {
      _buckets.add(new List());
    }
    _buckets[val].add(val);

    _buckets.first.removeAt(0);

    while (_buckets.first.isEmpty) {
      _buckets.removeAt(0);
      _buckets.first.sort();
      _buckets[0] = _buckets.first.reversed.toList();
    }
  }
}
