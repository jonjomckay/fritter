extension Iterables<E> on Iterable<E> {
  E? get firstOrNull {
    if (isEmpty) {
      return null;
    }

    return first;
  }

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

extension MapWithIndex<T> on List<T> {
  List<R> mapWithIndex<R>(R Function(T, int i) callback) {
    List<R> result = [];
    for (int i = 0; i < length; i++) {
      R item = callback(this[i], i);
      result.add(item);
    }
    return result;
  }
}