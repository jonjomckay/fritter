extension Iterables<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }

  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(<K, List<E>>{},
      (Map<K, List<E>> map, E element) => map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));

  Iterable<E> getRange(int start, [int? end]) {
    return (end != null ? take(end) : this).skip(start);
  }

  Iterable<E> sorted(int Function(E a, E b) compare) => [...this]..sort(compare);
}
