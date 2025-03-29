import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tic_tac_toe_game/constant.dart';
import 'package:tic_tac_toe_game/game_page.dart';
import 'package:tic_tac_toe_game/gen/assets.gen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<Widget> onboaringList = [
    OnboardingWidget(
      svg: Assets.images.onboarding1,
      title: 'Welcome',
      message:
          'One of the oldest world games now available on your smartphone device!',
    ),
    OnboardingWidget(
      svg: Assets.images.onboarding2,
      title: 'Compete',
      message:
          'Play the game with your friends, and prove that you’re a worthy opponent!',
    ),
    OnboardingWidget(
      svg: Assets.images.onboarding3,
      title: 'Scoreboard',
      message:
          'Earn points and make your own way to the top of the scoreboard!',
    ),
  ];

  int index = 0;

  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: PageView(
          controller: pageController,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) {
            index = value;
            setState(() {
              
            });
          },
          children: onboaringList,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                  );
                },
                child: Text('Back', style: TextStyle(color: Colors.white),),
              ),

              TextButton(onPressed: () {
                if(index == 2){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => GamePage(),
                  ));
                } else {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                  );
                }
              }, child: Text(index == 2 ? 'Start' : 'Next', style: TextStyle(color: Colors.white),)),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key,
    required this.svg,
    required this.title,
    required this.message,
  });
  final String svg;
  final String title;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(svg),

        const SizedBox(height: 16),
        Text(title, style: TextStyle(color: Colors.white, fontSize: 22)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44),
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
