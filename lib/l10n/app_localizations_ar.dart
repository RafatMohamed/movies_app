// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get emailHint => 'Email';

  @override
  String get passwordHint => 'Password';

  @override
  String get confirmPasswordHint => 'Confirm Password';

  @override
  String get nameHint => 'Name';

  @override
  String get phoneHint => 'Phone Number';

  @override
  String get forgetPassword => 'Forget Password ?';

  @override
  String get login => 'Login';

  @override
  String get dontHaveAccount => 'Don\'t Have Account ? ';

  @override
  String get createOne => 'Create One';

  @override
  String get alreadyHaveAccount => 'Already Have Account ? ';

  @override
  String get createAccount => 'Create Account';

  @override
  String get avatar => 'Avatar';

  @override
  String get register => 'Register';

  @override
  String get orDivider => 'OR';

  @override
  String get loginWithGoogle => 'Login With Google';
}
