import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/auth_service.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/utilities/auth/auth_cubit.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.deepBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.gold),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.resetPassword,
          style: const TextStyle(
            color: AppColors.gold,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p20,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  AppAssets.forgetPasswordImage,
                  height: 260,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: AppPadding.p24),
                Theme(
                  data: Theme.of(context).copyWith(
                    primaryColor: AppColors.white,
                    hintColor: Colors.white60,
                    inputDecorationTheme: const InputDecorationTheme(
                      hintStyle: TextStyle(color: Colors.white60, fontSize: 16),
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
                    ),
                  ),
                  child: CustomTextFormField(
                    controller: _emailController,
                    hintText: l10n.emailHint,
                    isEmail: true,
                    withValidator: true,
                    keyboardType: TextInputType.emailAddress,
                    prefixIconPath: AppAssets.emailIcon,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (!_formKey.currentState!.validate()) return;

                      final email = _emailController.text.trim();
                      if (email.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.pleaseEnterEmail),
                          ),
                        );
                        return;
                      }

                      try {
                        await context.read<AuthCubit>().resetPassword(email);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.passwordResetSent),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          final errorMessage = e is AuthException
                              ? e.getLocalizedMessage(l10n)
                              : e.toString();
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(errorMessage)));
                        }
                      }
                    },
                    child: Text(
                      l10n.verifyEmail,
                      style: const TextStyle(
                        color: AppColors.deepBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
