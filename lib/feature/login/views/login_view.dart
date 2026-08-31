import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:svg_flutter/svg.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/widgets/custom_button_app.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
    return Scaffold(
      body: SafeArea(
        child: Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: const TextStyle(color: AppColors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.r16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.r16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.r16),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.r16),
                borderSide: const BorderSide(color: AppColors.red),
              ),
            ),
          ),
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
                    hintText: "Email",
                    controller: emailController,
                    isEmail: true,
                    withValidator: true,
                    keyboardType: TextInputType.emailAddress,
                    prefixIconPath: AppAssets.emailIcon,
                  ),
                  const Gap(AppPadding.p16),
                  CustomTextFormField(
                    hintText: "Password",
                    controller: passwordController,
                    isPassword: true,
                    withValidator: true,
                    prefixIconPath: AppAssets.passwordIcon,
                  ),
                  const Gap(AppPadding.p10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: navigate to forget password screen
                      },
                      child: Text(
                        "Forget Password ?",
                        style: textTheme.titleSmall,
                      ),
                    ),
                  ),
                  const Gap(AppPadding.p24),
                  CustomButtonApp(
                    text: "Login",
                    textStyle: textTheme.titleMedium?.copyWith(
                      color: AppColors.deepBlack,
                    ),
                    onTap: () {
                      // TODO: handle login
                    },
                  ),
                  const Gap(AppPadding.p20),
                  _buildCreateAccountRow(textTheme),
                  const Gap(AppPadding.p24),
                  _buildOrDivider(),
                  const Gap(AppPadding.p24),
                  _buildGoogleButton(textTheme),
                  const Gap(AppPadding.p24),
                  Center(child: _LanguageToggle()),
                  const Gap(48),
                ],
              ),
            ),
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
        child: Image.asset(AppAssets.appLogo, fit: .contain),
      ),
    );
  }

  Widget _buildCreateAccountRow(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        Text(
          "Don't Have Account ? ",
          style: textTheme.titleMedium?.copyWith(color: AppColors.white),
        ),
        GestureDetector(
          onTap: () {
            // TODO: navigate to register screen
          },
          child: Text(
            "Create One",
            style: textTheme.titleMedium?.copyWith(fontWeight: .bold),
          ),
        ),
      ],
    );
  }

  Widget _buildOrDivider() {
    return const Row(
      mainAxisAlignment: .center,
      children: const [
        SizedBox(
          width: 60,
          child: Divider(color: AppColors.gold, thickness: 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Text(
            "OR",
            style: TextStyle(color: AppColors.gold, fontSize: 14),
          ),
        ),
        SizedBox(
          width: 60,
          child: Divider(color: AppColors.gold, thickness: 1),
        ),
      ],
    );
  }

  Widget _buildGoogleButton(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        // TODO: handle Google sign in
      },
      child: Container(
        alignment: .center,
        padding: const EdgeInsetsDirectional.all(AppPadding.p16),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(AppBorderRadius.r16),
          color: AppColors.gold,
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            SvgPicture.asset(AppAssets.googleIcon, width: 22, height: 22),
            const Gap(AppPadding.p8),
            Text(
              "Login With Google",
              style: textTheme.labelSmall?.copyWith(color: AppColors.deepBlack),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageToggle extends StatefulWidget {
  @override
  State<_LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<_LanguageToggle> {
  bool isArabic = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppBorderRadius.r24),
        border: Border.all(color: AppColors.gold, width: 2),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          _flagCircle(
            AppAssets.englishIcon,
            selected: !isArabic,
            onTap: () {
              if (isArabic) setState(() => isArabic = false);
            },
          ),
          _flagCircle(
            AppAssets.arabicIcon,
            selected: isArabic,
            onTap: () {
              if (!isArabic) setState(() => isArabic = true);
            },
          ),
        ],
      ),
    );
  }

  Widget _flagCircle(
      String iconPath, {
        required bool selected,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? AppColors.gold : Colors.transparent,
        ),
        padding: EdgeInsets.all(selected ? 5 : 3),
        child: ClipOval(
          child: SvgPicture.asset(iconPath, fit: .cover),
        ),
      ),
    );
  }
}
