import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 12.0)
        .chain(CurveTween(curve: Curves.bounceInOut))
        .animate(animationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              animationController.forward();
            }
          });
    animationController.forward(from: 0.0);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: offsetAnimation,
            builder: (context, child) {
              return Container(
                padding: EdgeInsets.only(
                  top: offsetAnimation.value + 12.0,
                  bottom: 12.0 - offsetAnimation.value,
                ),
                child: child,
              );
            },
            child: Image.asset('assets/images/loading.png'),
          ),
          const Text('Loading...'),
        ],
      ),
    );
  }
}
