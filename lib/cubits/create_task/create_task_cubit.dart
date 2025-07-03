import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:to_do/models/task_params.dart';
import 'package:to_do/service/network_service.dart';
import 'package:to_do/utils/enums/enums.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit() : super(CreateTaskState());

  void createTask(TaskParams params) async {
    emit(state.copyWith(createStatus: StateStatus.inProgress));
    try {
      final result = await NetworkService.createTask(params);
      if (result) {
        emit(state.copyWith(createStatus: StateStatus.success));
      } else {
        emit(state.copyWith(createStatus: StateStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(createStatus: StateStatus.failure));
    }
  }
}
