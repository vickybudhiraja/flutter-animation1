import 'package:flutter/material.dart';
import 'package:/components/like_animation.dart';

class TweenAnimationDemo extends StatefulWidget {
  const TweenAnimationDemo({Key? key}) : super(key: key);

  static const String screen_name = 'tween_animation_demo';

  @override
  State<TweenAnimationDemo> createState() => _TweenAnimationDemoState();
}

class _TweenAnimationDemoState extends State<TweenAnimationDemo> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tween Animation Demo"),
      ),
      body: Container(
        child: Column(
          children: [
            GestureDetector(
              onDoubleTap: () {
                setState(() {
                  isLikeAnimating = true;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      'https://raw.githubusercontent.com/vickybudhiraja/testvideos/88d1b0822876c18723fd9713ea9e62103988c878/pencilsketch1_thumb.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isLikeAnimating ? 1.0 : 0.0,
                    child: LikeAnimation(
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 120,
                        ),
                        isAnimating: isLikeAnimating,
                        duration: const Duration(
                          milliseconds: 400,
                          // seconds: 400,
                        ),
                        onEnd: () {
                          setState(() {
                            isLikeAnimating = false;

                          });
                      },
                    ),
                  ),
                ],
              ),
            ),
            // LikeAnimation(
            //   isAnimating: false,
            //   child: IconButton(
            //     onPressed: () {},
            //     icon: const Icon(
            //       Icons.favorite,
            //       color: Colors.red,
            //     ),
            //   ),
            //
            // ),
          ],
        ),
      ),
    );
  }
}
