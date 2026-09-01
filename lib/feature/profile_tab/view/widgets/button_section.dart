import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/widgets/custom_button_app.dart';

class ButtonSection extends StatelessWidget {
  ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 55,
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: CustomButtonApp(
                textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.deepBlack,
                  fontWeight: .normal,
                ),
                onTap: () {},
                text: "Edit Profile",
              ),
            ),
            const Gap(10),
            Expanded(
              flex: 3,
              child: CustomButtonApp(
                onTap: () {},
                text: "Exit",
                withIcon: true,
                background: AppColors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
