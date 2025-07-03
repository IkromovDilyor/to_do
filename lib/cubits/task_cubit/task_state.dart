part of 'task_cubit.dart';

@immutable
class TaskState extends Equatable {
  final List<TaskModel> taskList;
  final List<TaskModel> historyTaskList;
  final StateStatus getTaskStatus;
  final StateStatus updateStatus;

  TaskState({
    this.taskList = const [],
    this.getTaskStatus = StateStatus.initial,
    this.updateStatus = StateStatus.initial,
    this.historyTaskList=const [],
  });

  TaskState copyWith({
    List<TaskModel>? taskList,
    StateStatus? getTaskStatus,
    StateStatus? updateStatus,
    List<TaskModel>? historyTaskList,
  }) => TaskState(
    taskList: taskList ?? this.taskList,
    getTaskStatus: getTaskStatus ?? this.getTaskStatus,
    updateStatus: updateStatus ?? this.updateStatus,
    historyTaskList: historyTaskList?? this.historyTaskList,
  );

  @override
  List<Object?> get props => [taskList, getTaskStatus, updateStatus, historyTaskList];
}
