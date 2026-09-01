import 'package:flutter/material.dart';
import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_padding.dart';
import '../../../../core/widgets/custom_button_app.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import 'avatar_bottom_sheet.dart';

class UpdateProfileBody extends StatefulWidget {
  const UpdateProfileBody({super.key});

  @override
  State<UpdateProfileBody> createState() => _UpdateProfileBodyState();
}

class _UpdateProfileBodyState extends State<UpdateProfileBody> {
  String selectedAvatar = 'avatar_1.png';

  void _showAvatarBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return AvatarBottomSheet(
          selectedAvatar: selectedAvatar,
          onAvatarSelected: (newAvatar) {
            setState(() {
              selectedAvatar = newAvatar;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p16,
                vertical: AppPadding.p20,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _showAvatarBottomSheet(context);
                        },
                        child: SizedBox(
                          width: 140,
                          height: 140,
                          child: Image.asset(
                            'assets/images/png/$selectedAvatar',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const CircleAvatar(
                                  radius: 70,
                                  backgroundColor: AppColors.lightBlack,
                                  child: Icon(
                                    Icons.person,
                                    size: 70,
                                    color: AppColors.white,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppPadding.p24),
                    Theme(
                      data: Theme.of(context).copyWith(
                        primaryColor: AppColors.white,
                        hintColor: Colors.white60,
                        inputDecorationTheme: const InputDecorationTheme(
                          hintStyle: TextStyle(
                            color: Colors.white60,
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      child: Column(
                        children: const [
                          CustomTextFormField(
                            hintText: 'Enter your name',
                            isName: true,
                            prefixIconPath: 'assets/icons/person.svg',
                          ),
                          SizedBox(height: AppPadding.p16),
                          CustomTextFormField(
                            hintText: 'Enter your phone number',
                            keyboardType: TextInputType.phone,
                            prefixIconPath: 'assets/icons/phone.svg',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppPadding.p16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: AppPadding.p16),
                    CustomButtonApp(
                      text: 'Delete Account',
                      background: AppColors.red,
                      onTap: () {},
                    ),
                    const SizedBox(height: AppPadding.p10),
                    CustomButtonApp(
                      text: 'Update Data',
                      background: AppColors.gold,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
