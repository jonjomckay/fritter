extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
          (Map<K, List<E>> map, E element) =>
      map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

extension ListSorted<T> on Iterable<T> {
  Iterable<T> sorted(int compare(T a, T b)) => [...this]..sort(compare);
}