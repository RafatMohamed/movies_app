import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/auth_service.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/auth/auth_cubit.dart';
import 'package:movies_app/core/widgets/custom_button_app.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/feature/update_profile/view/widgets/password_did_not_match.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';
import 'package:svg_flutter/svg.dart';

class ReauthenticateDialog extends StatefulWidget {
  const ReauthenticateDialog({super.key});

  @override
  State<ReauthenticateDialog> createState() => _ReauthenticateDialogState();
}

class _ReauthenticateDialogState extends State<ReauthenticateDialog> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  bool get _isGoogleUser {
    final user = context.read<AuthCubit>().currentUser;
    if (user == null) return false;
    return user.providerData.any((info) => info.providerId == 'google.com');
  }

  Future<void> _handleConfirmPassword() async {
    final l10n = AppLocalizations.of(context);
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = l10n.passwordsDoNotMatch;
      });
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await context.read<AuthCubit>().reauthenticate(_passwordController.text);
      if (mounted) {
        Navigator.pop(context, true);
      }
    } on AuthException catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.getLocalizedMessage(l10n);
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleGoogleReauth() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await context.read<AuthCubit>().reauthenticateWithGoogle();
      if (mounted) {
        Navigator.pop(context, true);
      }
    } on AuthException catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        setState(() {
          _errorMessage = e.getLocalizedMessage(l10n);
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isGoogle = _isGoogleUser;

    return Dialog(
      backgroundColor: AppColors.caviar,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.deleteAccount,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                if (isGoogle) ...[
                  CustomButtonApp(
                    onTap: () {
                      if (!_isLoading) {
                        _handleGoogleReauth();
                      }
                    },
                    background: AppColors.gold,
                    text: l10n.reloginWithGoogle,
                    withIcon: false,
                    icon: SvgPicture.asset(AppAssets.googleIcon, width: 22, height: 22),
                  ),
                ] else ...[
                  CustomTextFormField(
                    controller: _passwordController,
                    hintText: l10n.currentPasswordHint,
                    isPassword: true,
                    withValidator: true,
                  ),
                  const SizedBox(height: 12),
                  CustomTextFormField(
                    controller: _confirmPasswordController,
                    hintText: l10n.confirmPasswordHint,
                    isPassword: true,
                    withValidator: true,
                  ),
                ],
                if (_errorMessage != null) ...[
                  const SizedBox(height: 8),
                  PasswordDidNotMatch(
                    isVisible: _errorMessage != null,
                    onDismissed: () {
                      if (mounted) {
                        setState(() => _errorMessage = null);
                      }
                    },
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: AppColors.red, fontSize: 14),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(
                          l10n.cancel,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    if (!isGoogle) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButtonApp(
                          onTap: () {
                            if (!_isLoading) {
                              _handleConfirmPassword();
                            }
                          },
                          text: l10n.delete,
                          background: AppColors.red,
                          textStyle: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
