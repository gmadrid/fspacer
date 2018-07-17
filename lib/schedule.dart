class Schedule {
  List<List<num>> _buckets;

  Schedule(num num_buckets) {
    _buckets = new List()..length = num_buckets;
    for (var i = 0; i < num_buckets; ++i) {
      _buckets[i] = new List()..add(i + 1);
    }
  }

  num Current() {
    return _buckets.first.first;
  }

  void PopCurrent() {
    var val = Current();

      while(_buckets.length < val + 1) {
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