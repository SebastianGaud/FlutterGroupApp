import 'package:flutter/cupertino.dart';
import 'package:triptaptoe_app/screens/home_screen.dart';

void navigateToHomeWithSlideTransition(BuildContext context) {

  Navigator.pushAndRemoveUntil(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 550),
      pageBuilder: (_, __, ___) => HomeScreen(),
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        );
      },
    ),
    (route) => false,
  );
}