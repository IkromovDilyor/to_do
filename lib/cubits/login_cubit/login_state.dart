part of 'login_cubit.dart';

@immutable
class LoginState extends Equatable {
  final StateStatus loginStatus;
  final StateStatus registerStatus;

  const LoginState({this.loginStatus = StateStatus.initial, this.registerStatus = StateStatus.initial});

  LoginState copyWith({StateStatus? loginStatus, StateStatus? registerStatus}) =>
      LoginState(loginStatus: loginStatus ?? this.loginStatus, registerStatus: registerStatus ?? this.registerStatus);

  @override
  List<Object?> get props => [loginStatus, registerStatus];
}
