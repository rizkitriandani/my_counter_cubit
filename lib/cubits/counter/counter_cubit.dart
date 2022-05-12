import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState.initial());

  void increment(){
    final newState = state.counter+1;
    print(newState);
    emit(state.copyWith(counter: newState));
  }

  void decrement(){
    final newState = state.counter - 1;
    print(newState);
    emit(state.copyWith(counter: newState));
  }
}

