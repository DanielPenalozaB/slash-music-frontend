import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash_music_frontend/data/models/auth/signin_request.dart';
import 'package:slash_music_frontend/data/models/auth/signup_request.dart';
import 'package:slash_music_frontend/domain/usecases/auth/signin_usecase.dart';
import 'package:slash_music_frontend/domain/usecases/auth/signup_usecase.dart';
import 'package:slash_music_frontend/presentation/auth/bloc/auth_event.dart';
import 'package:slash_music_frontend/presentation/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUseCase _signupUseCase;
  final SigninUseCase _signinUseCase;

  AuthBloc(this._signupUseCase, this._signinUseCase) : super(AuthInitial()) {
    on<SignupButtonPressed>(_onSignup);
    on<SigninButtonPressed>(_onSignin);
  }

  Future<void> _onSignup(
    SignupButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final request = SignupRequest(
      email: event.email,
      name: event.name,
      password: event.password,
      confirmPassword: event.confirmPassword,
    );

    final result = await _signupUseCase.call(request);

    result.fold(
      (error) => emit(AuthFailure(error)),
      (response) => emit(AuthSuccess(response)),
    );
  }

  Future<void> _onSignin(
    SigninButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final request = SigninRequest(
      email: event.email,
      password: event.password,
    );

    final result = await _signinUseCase.call(request);

    result.fold(
      (error) => emit(AuthFailure(error)),
      (response) => emit(AuthSuccess(response)),
    );
  }
}

