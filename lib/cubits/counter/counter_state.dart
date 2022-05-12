part of 'counter_cubit.dart';

/* -------------------------------------------------------------------------- */
/*                  How to make your cubit state like a pro :                 */
/* 
1. Deklarasikan semua fieldnya terlebih dahulu
2. Generate Constructor
3. extends equatable dan override method yang diperlukan
4. Generate CopyWith
5. Generate toString
6. Buat factory method initial() untuk dilempar sbg counter initial.
*/
/* -------------------------------------------------------------------------- */

class CounterState extends Equatable {
  final int counter;

  CounterState({
    required this.counter,
  });

  factory CounterState.initial() {
    return CounterState(counter: 0);
  }

  @override
  List<Object> get props => [counter];

  @override
  String toString() => 'CounterState(counter: $counter)';

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}
