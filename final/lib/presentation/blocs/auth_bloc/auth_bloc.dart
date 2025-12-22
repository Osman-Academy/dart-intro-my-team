import 'package:bloc/bloc.dart';

import '../../../core/constants/app_constants.dart';
import '../../../data/datasources/remote/api_client.dart';
import '../../../data/datasources/remote/auth_remote_data_source.dart';
import '../../../data/models/auth_response_model.dart';
import '../../../data/services/token_storage.dart';
import '../../models/auth_models.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TokenStorage tokenStorage;
  late final ApiClient _client;
  late final AuthRemoteDataSource _remote;

  AuthBloc({required this.tokenStorage}) : super(const AuthState()) {
    _client = ApiClient(
      baseUrl: AppConstants.apiBaseUrl,
      tokenProvider: () => tokenStorage.getToken(),
    );
    _remote = AuthRemoteDataSource(_client);

    on<AuthCheckRequested>(_onCheck);
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onCheck(AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    final token = await tokenStorage.getToken();
    if (token == null) {
      emit(const AuthState());
      return;
    }
    try {
      final me = await _remote.me();
      final user = AuthUserModel.fromJson(me);
      emit(state.copyWith(token: token, user: user.toEntity(), loading: false, error: null));
    } catch (_) {
      await tokenStorage.clear();
      emit(const AuthState());
    }
  }

  Future<void> _onLogin(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final AuthResponseModel res = await _remote.login(event.email, event.password);
      await _persist(res, emit);
    } catch (e) {
      emit(state.copyWith(loading: false, error: 'Неверный email или пароль'));
    }
  }

  Future<void> _onRegister(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final AuthResponseModel res = await _remote.register(
        name: event.name,
        email: event.email,
        password: event.password,
        role: event.role,
      );
      await _persist(res, emit);
    } catch (e) {
      emit(state.copyWith(loading: false, error: 'Не удалось зарегистрироваться'));
    }
  }

  Future<void> _onLogout(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await tokenStorage.clear();
    emit(const AuthState());
  }

  Future<void> _persist(AuthResponseModel res, Emitter<AuthState> emit) async {
    final token = res.token;
    final user = AuthUserModel.fromJson(res.user);
    await tokenStorage.saveToken(token);
    emit(state.copyWith(token: token, user: user.toEntity(), loading: false, error: null));
  }
}
