import 'package:flutter/material.dart';
import '../../../../core/utilities/app_colors.dart';

class AvatarBottomSheet extends StatefulWidget {
  final String selectedAvatar;
  final Function(String) onAvatarSelected;

  const AvatarBottomSheet({
    super.key,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  @override
  State<AvatarBottomSheet> createState() => _AvatarBottomSheetState();
}

class _AvatarBottomSheetState extends State<AvatarBottomSheet> {
  late String currentSelected;

  @override
  void initState() {
    super.initState();
    currentSelected = widget.selectedAvatar;
  }

  final List<String> avatars = [
    'avatar_1.png',
    'avatar_2.png',
    'avatar_3.png',
    'avatar_4.png',
    'avatar_5.png',
    'avatar_6.png',
    'avatar_7.png',
    'avatar_8.png',
    'avatar_9.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.lightBlack,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: avatars.map((avatarName) {
              final isSelected = currentSelected == avatarName;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    currentSelected = avatarName;
                  });
                  widget.onAvatarSelected(avatarName);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightBlack,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFF6BD00)
                          : const Color(0xFF707070),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      'assets/images/png/$avatarName',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}