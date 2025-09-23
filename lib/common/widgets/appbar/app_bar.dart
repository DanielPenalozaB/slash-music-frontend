import 'package:flutter/material.dart';
import 'package:slash_music_frontend/common/helpers/is_dark_theme.dart';

class SlashAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;

  const SlashAppbar({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: title ?? const Text(''),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: context.isDarkTheme
                  ? Colors.white12
                  : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 15,
              color: context.isDarkTheme ? Colors.white : Colors.black45,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
