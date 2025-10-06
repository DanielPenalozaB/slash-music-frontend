import 'package:flutter/material.dart';
import 'package:slash_music_frontend/core/configs/theme/app_theme.dart';
import 'package:slash_music_frontend/presentation/splash/pages/splash.dart';
import 'package:slash_music_frontend/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slash Music',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
