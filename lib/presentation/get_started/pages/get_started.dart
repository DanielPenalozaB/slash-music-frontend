import 'package:flutter/material.dart';
import 'package:slash_music_frontend/common/widgets/button/basic_app_button.dart';
import 'package:slash_music_frontend/core/configs/assets/app_images.dart';
import 'package:slash_music_frontend/core/configs/theme/app_colors.dart';
import 'package:slash_music_frontend/presentation/auth/pages/signup_or_signin.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.getStartedBackground),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 46, 32, 32),
              child: Column(
                children: [
                  Image.asset(AppImages.logoFull, height: 60),
                  Spacer(),
                  Text(
                    'Enjoy listening to music',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis enim purus sed phasellus.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SignupOrSigninPage(),
                        ),
                      );
                    },
                    label: 'Get Started',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
