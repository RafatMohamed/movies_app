import 'package:flutter/material.dart';
import 'package:movies_app/core/models/img_profile_model.dart';
import 'package:svg_flutter/svg.dart';
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

  @override
  Widget build(BuildContext context) {
    final List<ImgProfileModel> avatars = ImgProfileModel.avatars;
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
              final isSelected = widget.selectedAvatar == avatarName.imgPath;
              final int index = avatars.indexOf(avatarName);
              return GestureDetector(
                onTap: () {
                  widget.onAvatarSelected(avatarName.imgPath);
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
                    child: SvgPicture.asset(
                      avatars[index].imgPath,
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