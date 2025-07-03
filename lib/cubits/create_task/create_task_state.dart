part of 'create_task_cubit.dart';

@immutable
class CreateTaskState extends Equatable {
  final StateStatus createStatus;

  CreateTaskState({this.createStatus = StateStatus.initial});

  CreateTaskState copyWith({StateStatus? createStatus}) =>
      CreateTaskState(createStatus: createStatus ?? this.createStatus);

  @override
  List<Object?> get props => [createStatus];
}
