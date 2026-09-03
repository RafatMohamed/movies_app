import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/custom_button_app.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/feature/update_profile/view/widgets/password_did_not_match.dart';
import 'package:movies_app/l10n/generated/app_localizations.dart';

class UpdatePasswordButtomSheet extends StatefulWidget {
  const UpdatePasswordButtomSheet({super.key});

  @override
  State<UpdatePasswordButtomSheet> createState() =>
      _UpdatePasswordButtomSheetState();
}

class _UpdatePasswordButtomSheetState extends State<UpdatePasswordButtomSheet> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController currentFailed = TextEditingController();

  final TextEditingController newPasswordFailed = TextEditingController();

  final TextEditingController confirmNewPasswordFailed = TextEditingController();

  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.resetPassword,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: currentFailed,
              withValidator: true,
              hintText: AppLocalizations.of(context)!.currentPasswordHint,
              isPassword: true,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: newPasswordFailed,
              withValidator: true,
              hintText: AppLocalizations.of(context)!.newPasswordHint,
              isPassword: true,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: confirmNewPasswordFailed,
              withValidator: true,
              hintText: AppLocalizations.of(context)!.confirmNewPasswordHint,
              isPassword: true,
            ),
            if(errorMessage!=null)
            Visibility(
              visible:errorMessage!=null,
              child: PasswordDidNotMatch(
                onDismissed: () {
                  setState(() {
                    errorMessage=null;
                  });
                },
                isVisible: errorMessage!=null,
                child:  Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),

            CustomButtonApp(
              onTap: () {
                final oldPassword ="12345678";
                if (confirmNewPasswordFailed.text != newPasswordFailed.text) {
                  setState(() {
                    errorMessage= AppLocalizations.of(context)!.passwordsDoNotMatch;
                  });
                  return;
                }
                if (currentFailed.text != oldPassword) {
                  setState(() {
                    errorMessage= AppLocalizations.of(context)!.oldPasswordIncorrect;
                  });
                  return;
                }
                if (currentFailed.text == newPasswordFailed.text) {
                  setState(() {
                    errorMessage= AppLocalizations.of(context)!.newPasswordMustDiffer;
                  });
                  return;
                }
                if (formKey.currentState!.validate() &&
                    currentFailed.text.isNotEmpty &&
                    newPasswordFailed.text.isNotEmpty &&
                    confirmNewPasswordFailed.text.isNotEmpty &&
                    confirmNewPasswordFailed.text == newPasswordFailed.text) {
                  // Implement your password reset logic here

                  Navigator.pop(context);
                }
                // Close the bottom sheet
              },
              text: AppLocalizations.of(context)!.resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}