import 'package:birdle/bloc/counter/bloc/counter_event.dart';
import 'package:birdle/bloc/counter/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(counter: 0)) {
    on<IncrementCounter>((event, emit) {
      emit(state.copyWith(counter: state.counter + 1));
    });

    on<DecremenetCounter>((event, emit) {
      emit(state.copyWith(counter: state.counter - 1));
    });
  }

  void onIncrementCounter(CounterEvent event, Emitter<CounterState> emit) {
    emit(state.copyWith(counter: state.counter + 1));
  }

  void onDecremenetCounter(CounterEvent event, Emitter<CounterState> emit) {
    emit(state.copyWith(counter: state.counter - 1));
  } 
}
