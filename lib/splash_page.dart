import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tic_tac_toe_game/constant.dart';
import 'package:tic_tac_toe_game/game_page.dart';
import 'package:tic_tac_toe_game/gen/assets.gen.dart';
import 'package:tic_tac_toe_game/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => OnboardingPage(),
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.images.logo),
            Text(
              'Tic Tac Toe',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            LoadingAnimationWidget.stretchedDots(color: Colors.white, size: 45),
          ],
        ),
      ),
    );
  }
}
