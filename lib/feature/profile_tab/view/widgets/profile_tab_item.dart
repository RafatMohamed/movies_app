import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileTabItem extends StatelessWidget {
  ProfileTabItem({required this.iconPath, required this.text});
  String iconPath;
  String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        SvgPicture.asset(iconPath, height: 42, width: 42, fit: .scaleDown),
        Text(text, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
