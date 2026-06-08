import 'package:birdle/bloc/task/task_event.dart';
import 'package:birdle/bloc/task/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// an action kind of
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc()
    : super(
        const TaskState(
          selectedTaskId: '',
          selectedCategoryId: 'health',
          selectedPriorityId: 'high',
        ),
      ) {
    on<SelectTask>((event, emit) {
      emit(state.copyWith(selectedTaskId: event.selectedTaskId));
    });

    on<SelectCategory>((event, emit) {
      emit(state.copyWith(selectedCategoryId: event.selectedCategoryId));
    });

    on<SelectPriority>((event, emit) {
      emit(state.copyWith(selectedPriorityId: event.selectedPriorityId));
    });

    on<ResetTaskSelection>((event, emit) {
      emit(
        const TaskState(
          selectedTaskId: '',
          selectedCategoryId: 'work',
          selectedPriorityId: 'low',
        ),
      );
    });
  }
}
