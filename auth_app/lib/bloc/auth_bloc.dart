import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_app/bloc/auth_event.dart';
import 'package:auth_app/bloc/auth_state.dart';
import 'package:auth_app/models/user.dart';
import 'package:auth_app/repositories/repository_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.login(event.username, event.password);
        emit(AuthSuccess(user: user));
      } catch (e) {
        emit(AuthError(message: 'Login failed. Please try again.'));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.register(
          event.username,
          event.email,
          event.password,
        );
        emit(AuthSuccess(user: user));
      } catch (e) {
        emit(AuthError(message: 'Registration failed. Please try again.'));
      }
    });

    on<LogoutEvent>((event, emit) {
      emit(AuthInitial());
    });
  }
}