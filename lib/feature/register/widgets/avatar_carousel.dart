import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_colors.dart';


class AvatarCarousel extends StatefulWidget {
  const AvatarCarousel({super.key});

  static const List<String> avatars = [
    AppAssets.person1,
    AppAssets.person2,
    AppAssets.person3,
  ];

  @override
  State<AvatarCarousel> createState() => _AvatarCarouselState();
}

class _AvatarCarouselState extends State<AvatarCarousel> {
  static const double _selectedSize = 150;
  static const double _viewportFraction = 0.5;

  late final PageController _controller;
  double _page = 1;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: _viewportFraction,
      initialPage: 1,
    );
    _controller.addListener(() {
      setState(() => _page = _controller.page ?? 1);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _selectedSize,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final peekWidth = constraints.maxWidth * (1 - _viewportFraction) / 2;
          final unselectedSize = (peekWidth - 6).clamp(50.0, 90.0);

          return PageView.builder(
            controller: _controller,
            itemCount: AvatarCarousel.avatars.length,
            itemBuilder: (context, index) {
              final distance = (index - _page).abs().clamp(0.0, 1.0);
              final size =
                  unselectedSize + (_selectedSize - unselectedSize) * (1 - distance);
              final side = index > _page ? -1.0 : (index < _page ? 1.0 : 0.0);
              final alignment = Alignment(side * distance, 0);

              return Align(
                alignment: alignment,
                child: Container(
                  width: size,
                  height: size,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightBlack,
                  ),
                  child: Image.asset(AvatarCarousel.avatars[index], fit: BoxFit.cover),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
