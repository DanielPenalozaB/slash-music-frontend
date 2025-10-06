import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slash_music_frontend/common/widgets/appbar/app_bar.dart';
import 'package:slash_music_frontend/common/widgets/button/basic_app_button.dart';
import 'package:slash_music_frontend/core/configs/assets/app_images.dart';

import 'package:slash_music_frontend/bloc/auth_bloc.dart';
import 'package:slash_music_frontend/model/user_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // use the new bloc
  final AuthBloc _authBloc = AuthBloc();
  StreamSubscription<String>? _messageSub;

  @override
  void initState() {
    super.initState();
    // Optional: listen to messages to show transient info/errors from bloc
    _messageSub = _authBloc.messages.listen((msg) {
      // show snackbars for messages coming from the bloc
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    });
  }

  @override
  void dispose() {
    _messageSub?.cancel();
    _authBloc.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final UserModel user = await _authBloc.signup(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmController.text,
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      // success message already posted via the bloc stream; we can show a focused snackbar too:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Welcome ${user.name.isNotEmpty ? user.name : user.email}!',
          ),
        ),
      );

      // navigate to signin (or home) after registering
      Navigator.of(context).pushReplacementNamed('/signin');
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);

      // Try to make error user-friendly
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SlashAppbar(title: Image.asset(AppImages.logoFull, height: 40)),
      bottomNavigationBar: _signupBottomText(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Register',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              _fullNameField(context),
              const SizedBox(height: 16),
              _fullEmailField(context),
              const SizedBox(height: 16),
              _fullPasswordField(context),
              const SizedBox(height: 16),
              _confirmPasswordField(context),
              const SizedBox(height: 32),
              BasicAppButton(
                label: _isLoading ? 'Creating...' : 'Create account',
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _signup,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        hintText: 'Full name',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Name is required';
        if (v.trim().length > 50) return 'Name must be under 50 chars';
        return null;
      },
    );
  }

  Widget _fullEmailField(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: 'Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Email is required';
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(v.trim())) return 'Enter a valid email';
        if (v.trim().length > 100) return 'Email must be under 100 chars';
        return null;
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _fullPasswordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Password is required';
        if (v.length < 6) return 'Password must be at least 6 characters';
        return null;
      },
    );
  }

  Widget _confirmPasswordField(BuildContext context) {
    return TextFormField(
      controller: _confirmController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Confirm password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Confirm password is required';
        if (v != _passwordController.text) return 'Passwords do not match';
        return null;
      },
    );
  }

  Widget _signupBottomText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Already have an account?'),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signin');
            },
            child: const Text('Sign in'),
          ),
        ],
      ),
    );
  }
}
