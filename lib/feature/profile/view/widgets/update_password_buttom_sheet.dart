import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/custom_button_app.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/feature/profile/view/widgets/password_did_not_match.dart';

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

  bool showMessageForConfirmError = false;
  bool showMessageErrorForCurrent = false;
  bool showMessageErrorOldPassWithCurrent = false;
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
            const Text(
              'Reset Password',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: currentFailed,
              withValidator: true,
              hintText: 'Current password',
              isPassword: true,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: newPasswordFailed,
              withValidator: true,
              hintText: 'New password',
              isPassword: true,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: confirmNewPasswordFailed,
              withValidator: true,
              hintText: 'Confirm New password',
              isPassword: true,
            ),
            if (!showMessageForConfirmError || !showMessageErrorForCurrent || !showMessageErrorOldPassWithCurrent) const SizedBox(height: 16),
            Visibility(
              visible: showMessageForConfirmError ||showMessageErrorForCurrent || showMessageErrorOldPassWithCurrent,
              child: PasswordDidNotMatch(
                onDismissed: () {
                  setState(() {
                    showMessageForConfirmError = false;
                    showMessageErrorForCurrent = false;
                    showMessageErrorOldPassWithCurrent = false;
                  });
                },
                isVisible: showMessageForConfirmError || showMessageErrorForCurrent|| showMessageErrorOldPassWithCurrent,
                child:  Text(
                  showMessageForConfirmError ? 'Passwords do not match':showMessageErrorForCurrent ?'old password is Incorrect':showMessageErrorOldPassWithCurrent?"New password must be another for current":"",
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
                    showMessageForConfirmError = true;
                  });
                  return;
                }
                if (currentFailed.text != oldPassword) {
                  setState(() {
                    showMessageErrorForCurrent = true;
                  });
                  return;
                }
                if (currentFailed.text == newPasswordFailed.text) {
                  setState(() {
                    showMessageErrorOldPassWithCurrent = true;
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
              text: 'Reset Password',
            ),
          ],
        ),
      ),
    );
  }
}
