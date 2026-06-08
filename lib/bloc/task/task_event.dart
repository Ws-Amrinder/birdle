import 'package:equatable/equatable.dart';

// the dispatch of a bloc action
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class SelectTask extends TaskEvent {
  final String selectedTaskId;

  const SelectTask({required this.selectedTaskId});

  @override
  List<Object?> get props => [selectedTaskId];
}

class SelectCategory extends TaskEvent {
  final String selectedCategoryId;

  const SelectCategory({required this.selectedCategoryId});

  @override
  List<Object?> get props => [selectedCategoryId];
}

class SelectPriority extends TaskEvent {
  final String selectedPriorityId;

  const SelectPriority({required this.selectedPriorityId});

  @override
  List<Object?> get props => [selectedPriorityId];
}

class ResetTaskSelection extends TaskEvent {
  const ResetTaskSelection();
}
