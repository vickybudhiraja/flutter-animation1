import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  const LikeAnimation({
    Key? key,
    required this.child,
    required this.isAnimating,
    // this.duration = const Duration(milliseconds: 150),
    required this.duration,
    this.onEnd,
  }) : super(key: key);

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

// mixing, adding many capabilities to a class, unlike inherritance
class _LikeAnimationState extends State<LikeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;  // not AnimatedController!
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,  // the ticker provider
        duration: Duration(
            milliseconds: widget.duration.inMilliseconds, // ~/ 2,
            // seconds: widget.duration.inSeconds,
        ),

    );
    // tween is In-Between!
    scaleAnimation = Tween<double>(begin: 1, end: 1.3).animate(controller);
    // scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    // scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
  }

  startAnimation() async {
    if (widget.isAnimating) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(const Duration(milliseconds: 400,),);
      controller.addListener(() {
        print(controller.value);
      });
      print(controller.status.name);

      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: widget.child,  // our heart icon
    );
  }
}
