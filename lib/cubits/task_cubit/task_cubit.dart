import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/service/network_service.dart';
import 'package:to_do/utils/enums/enums.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskState());

  void getTask() async {
    List<TaskModel> activeTaskList = [];
    List<TaskModel> historyTaskList = [];

    emit(state.copyWith(getTaskStatus: StateStatus.inProgress));

    try {
      final result = await NetworkService.getTask();

      for (var element in result) {
        if (element.isDone) {
          historyTaskList.add(element);
        } else {
          activeTaskList.add(element);
        }
      }

      emit(
        state.copyWith(
          getTaskStatus: StateStatus.success,
          taskList: activeTaskList,
          historyTaskList: historyTaskList,
        ),
      );
    } catch (e) {
      print(e);
      emit(state.copyWith(getTaskStatus: StateStatus.failure));
    }
  }

  void deleteTask(int id) async {
    try {
      final result = await NetworkService.deleteTask(id);
      getTask();
    } catch (e) {
      print(e);
    }
  }

  void updateTask(int id, bool isDone) async {
    emit(state.copyWith(updateStatus: StateStatus.inProgress));

    try {
      final updatedList = state.taskList.map((task) {
        if (task.id == id) {
          return task.copyWith(isDone: isDone);
        }
        return task;
      }).toList();
      final result = await NetworkService.updateTask(id, isDone);
      if (result) {
        emit(
          state.copyWith(
            updateStatus: StateStatus.success,
            taskList: updatedList,
          ),
        );
      } else {
        emit(state.copyWith(updateStatus: StateStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(updateStatus: StateStatus.failure));
    }
  }
}
