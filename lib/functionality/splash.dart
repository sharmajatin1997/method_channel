import 'dart:ui';
import 'package:esferasoft_task/app_helpers/app_text.dart';
import 'package:esferasoft_task/functionality/login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      if (mounted) {
        return Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
            transitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return HolePageTransitionsBuilder().buildTransitions(
                MaterialPageRoute(
                  builder: (context) =>LoginScreen(),
                ),
                context,
                animation,
                secondaryAnimation,
                child,
              );
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff00D7E3), Color(0xffFF00FF)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/mic.png',color: Colors.white,height: 100,width: 100,),
            SizedBox(
              height: 20,
            ),
            AppText(
                text: 'Music App',
                textSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ],
        ),
      ),
    );
  }
}

class HolePageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return ClipPath(clipper: _HoleClipper(animation), child: child);
  }
}

class _HoleClipper extends CustomClipper<Path> {
  _HoleClipper(this.animation);

  final Animation<double> animation;
  late final curve = CurvedAnimation(
    parent: animation,
    curve: Curves.easeOut,
    reverseCurve: Curves.easeIn,
  );

  @override
  Path getClip(Size size) {
    final rightBottom = size.bottomRight(Offset.zero);
    final radius = lerpDouble(0, rightBottom.distance, curve.value)!;
    final oval = Rect.fromCircle(center: rightBottom, radius: radius);
    return Path()..addOval(oval);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
