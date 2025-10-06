import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slash_music_frontend/core/network/dio_client.dart';
import 'package:slash_music_frontend/data/repositories/auth/auth_repository_impl.dart';
import 'package:slash_music_frontend/data/sources/auth/auth_api_service.dart';
import 'package:slash_music_frontend/data/sources/auth/auth_local_service.dart';
import 'package:slash_music_frontend/domain/repositories/auth/auth_repository.dart';
import 'package:slash_music_frontend/domain/usecases/auth/signin_usecase.dart';
import 'package:slash_music_frontend/domain/usecases/auth/signup_usecase.dart';
import 'package:slash_music_frontend/presentation/auth/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // Network
  sl.registerSingleton<DioClient>(DioClient());

  // Services
  sl.registerSingleton<AuthApiService>(
    AuthApiServiceImpl(sl<DioClient>()),
  );

  sl.registerSingleton<AuthLocalService>(
    AuthLocalServiceImpl(sl<SharedPreferences>()),
  );

  // Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      sl<AuthApiService>(),
      sl<AuthLocalService>(),
      sl<DioClient>(),
    ),
  );

  // Use Cases
  sl.registerSingleton<SignupUseCase>(
    SignupUseCase(sl<AuthRepository>()),
  );

  sl.registerSingleton<SigninUseCase>(
    SigninUseCase(sl<AuthRepository>()),
  );

  // Blocs
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      sl<SignupUseCase>(),
      sl<SigninUseCase>(),
    ),
  );
}

