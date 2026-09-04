import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/feature/login/view/login_view.dart';
import 'package:movies_app/feature/register/widgets/avatar_carousel.dart';
import 'package:svg_flutter/svg.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/widgets/auth_input_theme.dart';
import 'package:movies_app/core/widgets/custom_button_app.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/core/widgets/language_toggle.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppLocalizations l10n = AppLocalizations.of(context);

    return AuthInputTheme(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(16),
              _buildAppBar(context, textTheme, l10n),
              const Gap(24),
              const AvatarCarousel(),
              const Gap(AppPadding.p8),
              Center(
                child: Text(l10n.avatar, style: textTheme.labelSmall?.copyWith(fontSize: 16)),
              ),
              const Gap(AppPadding.p24),
              CustomTextFormField(
                hintText: l10n.nameHint,
                controller: nameController,
                isName: true,
                withValidator: true,
                prefixIconPath: AppAssets.name,
              ),
              const Gap(AppPadding.p16),
              CustomTextFormField(
                hintText: l10n.emailHint,
                controller: emailController,
                isEmail: true,
                withValidator: true,
                keyboardType: TextInputType.emailAddress,
                prefixIconPath: AppAssets.emailIcon,
              ),
              const Gap(AppPadding.p16),
              CustomTextFormField(
                hintText: l10n.passwordHint,
                controller: passwordController,
                isPassword: true,
                withValidator: true,
                prefixIconPath: AppAssets.passwordIcon,
              ),
              const Gap(AppPadding.p16),
              CustomTextFormField(
                hintText: l10n.confirmPasswordHint,
                controller: confirmPasswordController,
                isPassword: true,
                withValidator: true,
                prefixIconPath: AppAssets.passwordIcon,
              ),
              const Gap(AppPadding.p16),
              CustomTextFormField(
                hintText: l10n.phoneHint,
                controller: phoneController,
                withValidator: true,
                keyboardType: TextInputType.phone,
                prefixIconPath: AppAssets.phone,
              ),
              const Gap(AppPadding.p24),
              CustomButtonApp(
                text: l10n.createAccount,
                textStyle: textTheme.labelSmall?.copyWith(
                  color: AppColors.deepBlack,
                ),
                onTap: () {
                },
              ),
              const Gap(AppPadding.p20),
              _buildLoginRow(context, textTheme, l10n),
              const Gap(AppPadding.p24),
              const Center(child: LanguageToggle()),
              const Gap(48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, TextTheme textTheme, AppLocalizations l10n) {
    return SizedBox(
      height: 32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                AppAssets.arrowBackDetails,
                colorFilter: const ColorFilter.mode(AppColors.gold, BlendMode.srcIn),
                width: 24,
                height: 24,
              ),
            ),
          ),
          Text(
            l10n.register,
            style: textTheme.titleMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.gold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginRow(BuildContext context, TextTheme textTheme, AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.alreadyHaveAccount,
          style: textTheme.titleMedium?.copyWith(color: AppColors.white),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          },
          child: Text(
            l10n.login,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}