import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent , AuthState>{
  AuthBloc() : super(AuthInitial()){
    on<LoginRequested>((event , emit) async{
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      if (event.username.isNotEmpty && event.password.isNotEmpty){
        emit(AuthAuthenticated());
      }else {
        emit(AuthError("Invalid credentials"));
      }
    });
  }
}