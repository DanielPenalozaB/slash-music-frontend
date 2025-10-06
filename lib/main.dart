import 'package:flutter/material.dart';
import 'package:slash_music_frontend/core/configs/theme/app_theme.dart';
import 'package:slash_music_frontend/ui/splash.dart';
import 'package:slash_music_frontend/ui/signin.dart';
import 'package:slash_music_frontend/ui/signup.dart';
import 'package:slash_music_frontend/ui/home.dart';

void main() {
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

      routes: {
        '/signin': (context) => const SigninPage(),
        '/signup': (context) => const SignupPage(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final args = settings.arguments;
          String? name;
          if (args is Map && args['name'] is String) {
            name = args['name'] as String;
          }
          return MaterialPageRoute(
            builder: (context) => HomePage(displayName: name),
            settings: settings,
          );
        }

        return MaterialPageRoute(
          builder: (context) => const SplashPage(),
          settings: settings,
        );
      },
    );
  }
}
