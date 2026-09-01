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

  bool showMassegeEror = false;
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
            if (!showMassegeEror) const SizedBox(height: 16),
            Visibility(
              visible: showMassegeEror,
              child: PasswordDidNotMatch(
                onDismissed: () {
                  setState(() {
                    showMassegeEror = false;
                  });
                },
                isVisible: showMassegeEror,
                child: const Text(
                  'Passwords do not match',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            ),

            CustomButtonApp(
              onTap: () {
                if (currentFailed.text != newPasswordFailed.text) {
                  setState(() {
                    showMassegeEror = true;
                  });
                  return;
                }
                if (formKey.currentState!.validate() &&
                    currentFailed.text.isNotEmpty &&
                    newPasswordFailed.text.isNotEmpty &&
                    currentFailed.text == newPasswordFailed.text) {
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
