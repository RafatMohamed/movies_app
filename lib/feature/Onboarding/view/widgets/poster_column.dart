import 'package:flutter/material.dart';
import 'package:movies_app/feature/Onboarding/view/widgets/poster_images.dart';

class PosterColumn extends StatelessWidget {
  final AnimationController controller;
  final int startIndex;
  final bool moveUp;
  final double listHeight;

  const PosterColumn({
    super.key,
    required this.controller,
    required this.startIndex,
    required this.moveUp,
    required this.listHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRect(
        clipBehavior: Clip.hardEdge,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final double offset = controller.value * listHeight;
            return Stack(
              children: [
                Positioned(
                  top: moveUp ? -offset : offset - listHeight,
                  left: 0,
                  right: 0,
                  child: PosterImages(startIndex: startIndex),
                ),
                Positioned(
                  top: moveUp ? listHeight - offset : offset,
                  left: 0,
                  right: 0,
                  child: PosterImages(startIndex: startIndex),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
