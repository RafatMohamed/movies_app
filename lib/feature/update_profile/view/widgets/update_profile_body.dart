import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/models/img_profile_model.dart';
import 'package:movies_app/core/models/user_model.dart';
import 'package:movies_app/core/services/auth_service.dart';
import 'package:movies_app/core/utilities/app_text.dart';
import 'package:movies_app/core/utilities/auth/auth_cubit.dart';
import 'package:movies_app/feature/update_profile/view/widgets/update_password_buttom_sheet.dart';
import 'package:svg_flutter/svg.dart';
import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_padding.dart';
import '../../../../core/widgets/custom_button_app.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../l10n/generated/app_localizations.dart';
import 'avatar_bottom_sheet.dart';

class UpdateProfileBody extends StatefulWidget {
  const UpdateProfileBody({super.key});

  @override
  State<UpdateProfileBody> createState() => _UpdateProfileBodyState();
}

class _UpdateProfileBodyState extends State<UpdateProfileBody> {
  String selectedAvatar = ImgProfileModel.avatars.first.imgPath;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  bool _isLoading = false;
  bool _isDeleting = false;
  int _avatarIndex = 0;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final UserModel? data = await context
        .read<AuthCubit>()
        .getCurrentUserData();
    if (data != null && mounted) {
      setState(() {
        nameController.text = data.name;
        phoneController.text = data.phone;
        _avatarIndex = (data.avatarIndex >= 0 &&
                data.avatarIndex < ImgProfileModel.avatars.length)
            ? data.avatarIndex
            : 0;
        selectedAvatar = ImgProfileModel.getAvatarPath(_avatarIndex);
      });
    }
  }

  Future<void> _handleAvatarSelected(String newAvatar) async {
    final newIndex = ImgProfileModel.avatars.indexWhere(
      (a) => a.imgPath == newAvatar,
    );

    setState(() {
      selectedAvatar = newAvatar;
      _avatarIndex = newIndex;
    });

    try {
      await context.read<AuthCubit>().updateUserData({'avatarIndex': newIndex});
    } on AuthException catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.getLocalizedMessage(l10n))));
      }
    }
  }

  Future<void> _handleUpdate() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await context.read<AuthCubit>().updateUserData({
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'avatarIndex': _avatarIndex,
      });
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profileUpdatedSuccessfully)),
        );
      }
    } on AuthException catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.getLocalizedMessage(l10n))));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleDeleteAccount() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.caviar,
        title: Text(
          l10n.deleteAccount,
          style: const TextStyle(color: AppColors.white),
        ),
        content: Text(
          l10n.deleteAccountConfirmation,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(
              l10n.cancel,
              style: const TextStyle(color: AppColors.white, fontSize: 20),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(
              l10n.delete,
              style: const TextStyle(color: AppColors.red, fontSize: 20),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isDeleting = true);
    try {
      if (!mounted) return;
      await context.read<AuthCubit>().deleteAccount();
      if (!mounted) return;
      await context.read<AuthCubit>().logout();
      if (mounted) {
        Navigator.of(
          context,
        ).pushReplacementNamed(AppOnRouteText.loginName,);
      }
    } on AuthException catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.getLocalizedMessage(l10n))));
      }
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }

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
              _handleAvatarSelected(newAvatar);
            });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
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
                      child: InkWell(
                        onTap: () {
                          _showAvatarBottomSheet(context);
                        },
                        child: SizedBox(
                          width: 140,
                          height: 140,
                          child: SvgPicture.asset(
                            selectedAvatar,
                            fit: BoxFit.contain,
                            placeholderBuilder: (context) => const CircleAvatar(
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
                    Form(
                      key: formKey,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          primaryColor: AppColors.white,
                          hintColor: Colors.white60,
                          inputDecorationTheme: const InputDecorationTheme(
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            CustomTextFormField(
                              controller: nameController,
                              hintText: AppLocalizations.of(
                                context,
                              ).enterYourName,
                              isName: true,
                              prefixIconPath: 'assets/icons/person.svg',
                            ),
                            const SizedBox(height: AppPadding.p16),
                            CustomTextFormField(
                              controller: phoneController,
                              hintText: AppLocalizations.of(
                                context,
                              ).enterYourPhoneNumber,
                              keyboardType: TextInputType.phone,
                              prefixIconPath: 'assets/icons/phone.svg',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppPadding.p16),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return const UpdatePasswordButtomSheet();
                            },
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context).resetPassword,
                          style: const TextStyle(
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
                      textStyle: Theme.of(context).textTheme.labelSmall
                          ?.copyWith(
                            color: AppColors.white,
                            fontWeight: .normal,
                          ),
                      text: AppLocalizations.of(context).deleteAccount,
                      background: AppColors.red,
                      onTap: () {
                        if (!_isDeleting) {
                          _handleDeleteAccount();
                        }
                      },
                    ),
                    const SizedBox(height: AppPadding.p10),
                    CustomButtonApp(
                      text: AppLocalizations.of(context).updateData,
                      background: AppColors.gold,
                      onTap: () {
                        if (!_isLoading) {
                          _handleUpdate();
                        }
                      },
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
