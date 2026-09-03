import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:svg_flutter/svg.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/app_text.dart';
import 'package:movies_app/core/widgets/auth_input_theme.dart';
import 'package:movies_app/core/widgets/custom_button_app.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/core/widgets/language_toggle.dart';
import 'package:movies_app/feature/register/view/register_view.dart';
import 'package:movies_app/l10n/app_localizations.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return AuthInputTheme(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(48),
              _buildLogo(),
              const Gap(48),
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
              const Gap(AppPadding.p10),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: GestureDetector(
                  onTap: () {
                    // TODO: navigate to forget password screen
                    Navigator.pushNamed(context, AppOnRouteText.forgetPasswordName);
                  },
                  child: Text(l10n.forgetPassword, style: textTheme.titleSmall),
                ),
              ),
              const Gap(AppPadding.p24),
              CustomButtonApp(
                text: l10n.login,
                textStyle: textTheme.labelSmall?.copyWith(
                  color: AppColors.deepBlack,
                ),
                onTap: () {
                  // TODO: handle login
                  ///if login success
                  Navigator.pushNamed(context, AppOnRouteText.mainAppName);
                },
              ),
              const Gap(AppPadding.p20),
              _buildCreateAccountRow(context, textTheme, l10n),
              const Gap(AppPadding.p24),
              _buildOrDivider(l10n),
              const Gap(AppPadding.p24),
              _buildGoogleButton(textTheme, l10n),
              const Gap(AppPadding.p24),
              const Center(child: LanguageToggle()),
              const Gap(48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: SizedBox(
        height: 150,
        width: 150,
        child: Image.asset(AppAssets.appLogo, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildCreateAccountRow(
    BuildContext context,
    TextTheme textTheme,
    AppLocalizations l10n,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.dontHaveAccount,
          style: textTheme.titleMedium?.copyWith(color: AppColors.white),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterView()),
            );
          },
          child: Text(
            l10n.createOne,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildOrDivider(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 60, child: Divider(color: AppColors.gold, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Text(l10n.orDivider, style: const TextStyle(color: AppColors.gold, fontSize: 14)),
        ),
        const SizedBox(width: 60, child: Divider(color: AppColors.gold, thickness: 1)),
      ],
    );
  }

  Widget _buildGoogleButton(TextTheme textTheme, AppLocalizations l10n) {
    return GestureDetector(
      onTap: () {
        // TODO: handle Google sign in
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsetsDirectional.all(AppPadding.p16),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(AppBorderRadius.r16),
          color: AppColors.gold,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.googleIcon, width: 22, height: 22),
            const Gap(AppPadding.p8),
            Text(
              l10n.loginWithGoogle,
              style: textTheme.labelSmall?.copyWith(color: AppColors.deepBlack),
            ),
          ],
        ),
      ),
    );
  }
}