import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:to_do/models/login_params.dart';
import 'package:to_do/service/network_service.dart';
import 'package:to_do/service/shared_preference_storage.dart';
import 'package:to_do/utils/constants/store_keys.dart';
import 'package:to_do/utils/enums/enums.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  void login(LoginParams params) async {
    emit(state.copyWith(loginStatus: StateStatus.inProgress));
    try {
      final result = await NetworkService.login(params);
      if (result.accessToken.isNotEmpty) {
        SharedPreferenceStorage.setString(key: StoreKeys.accessToken, value: result.accessToken);
        SharedPreferenceStorage.setString(key: StoreKeys.refreshToken, value: result.refreshToken);
        emit(state.copyWith(loginStatus: StateStatus.success));
      } else {
        emit(state.copyWith(loginStatus: StateStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(loginStatus: StateStatus.failure));
    }
  }

  void register(LoginParams params) async {
    emit(state.copyWith(registerStatus: StateStatus.inProgress));
    try {
      final result = await NetworkService.register(params);
      if (result) {
        emit(state.copyWith(registerStatus: StateStatus.success));
      } else {
        emit(state.copyWith(registerStatus: StateStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(registerStatus: StateStatus.failure));
    }
  }
}
