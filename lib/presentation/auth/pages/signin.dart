import 'package:flutter/material.dart';
import 'package:slash_music_frontend/common/widgets/appbar/app_bar.dart';
import 'package:slash_music_frontend/common/widgets/button/basic_app_button.dart';
import 'package:slash_music_frontend/core/configs/assets/app_images.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SlashAppbar(title: Image.asset(AppImages.logoFull, height: 40)),
      bottomNavigationBar: _signinBottomText(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign in',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            _usernameOrEmailField(context),
            SizedBox(height: 16),
            _fullPasswordField(context),
            SizedBox(height: 32),
            BasicAppButton(label: 'Create account', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _usernameOrEmailField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Enter username or email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _fullPasswordField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signinBottomText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Don\'t have an account?'),
          TextButton(onPressed: () {}, child: const Text('Register Now')),
        ],
      ),
    );
  }
}
