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
                    Navigator.pushNamed(context, AppOnRouteText.forgetPasswordName);
                  },
                  child: Text("Forget Password ?", style: textTheme.titleSmall),
                ),
              ),
              const Gap(AppPadding.p24),
              CustomButtonApp(
                text: "Login",
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
              _buildCreateAccountRow(context, textTheme),
              const Gap(AppPadding.p24),
              _buildOrDivider(),
              const Gap(AppPadding.p24),
              _buildGoogleButton(textTheme),
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

  Widget _buildCreateAccountRow(BuildContext context, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't Have Account ? ",
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
            "Create One",
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildOrDivider() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 60, child: Divider(color: AppColors.gold, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Text("OR", style: TextStyle(color: AppColors.gold, fontSize: 14)),
        ),
        SizedBox(width: 60, child: Divider(color: AppColors.gold, thickness: 1)),
      ],
    );
  }

  Widget _buildGoogleButton(TextTheme textTheme) {
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
              "Login With Google",
              style: textTheme.labelSmall?.copyWith(color: AppColors.deepBlack),
            ),
          ],
        ),
      ),
    );
  }
}
