import 'package:equatable/equatable.dart';

// the state of a bloc
class TaskState extends Equatable {
  final String selectedTaskId;
  final String selectedCategoryId;
  final String selectedPriorityId;

  const TaskState({
    required this.selectedTaskId,
    required this.selectedCategoryId,
    required this.selectedPriorityId,
  });

  TaskState copyWith({
    String? selectedTaskId,
    String? selectedCategoryId,
    String? selectedPriorityId,
  }) {
    return TaskState(
      selectedTaskId: selectedTaskId ?? this.selectedTaskId,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedPriorityId: selectedPriorityId ?? this.selectedPriorityId,
    );
  }

  @override
  List<Object?> get props => [
    selectedTaskId,
    selectedCategoryId,
    selectedPriorityId,
  ];
}
