import 'package:flutter/material.dart';
import 'package:movies_app/core/ChachRemote/is_first_open_app.dart';
import 'package:movies_app/feature/Onboarding/view/starting_view.dart';
import 'package:movies_app/feature/Splash/view/widgets/splash_circle.dart';
import 'package:movies_app/feature/Splash/view/widgets/triangle_painter.dart';
import 'package:movies_app/feature/login/view/login_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with TickerProviderStateMixin {
  late final AnimationController moveController;
  late final AnimationController fadeController;
  @override
  void initState() {
    super.initState();

    moveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    startAnimation();
  }

  Future<void> startAnimation() async {

    await moveController.forward();
    await Future.delayed(const Duration(seconds: 1));
    await fadeController.forward();
    final completed =  IsFirstOpenApp.getIsFirstOpen();
    if(!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 100),
        pageBuilder: (context, animation, secondaryAnimation) {
          return completed ? const LoginView() : const StartingView();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    moveController.dispose();
    fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: moveController,
      builder: (context, child) {
        final value = moveController.value;

        return SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const SplashCircle(),

              Transform.translate(
                offset: Offset(-150 + (value * 130), 0),
                child: Transform.scale(
                  scale: 1.5 - (value * 0.4),
                  child: Transform.rotate(
                    angle: 0,
                    child: CustomPaint(
                      size: const Size(50, 55),
                      painter: TrianglePainter(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
