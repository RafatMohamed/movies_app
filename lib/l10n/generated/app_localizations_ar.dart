// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get emailHint => 'البريد الإلكتروني';

  @override
  String get passwordHint => 'كلمة المرور';

  @override
  String get confirmPasswordHint => 'تأكيد كلمة المرور';

  @override
  String get nameHint => 'الاسم';

  @override
  String get phoneHint => 'رقم الهاتف';

  @override
  String get forgetPassword => 'نسيت كلمة المرور؟';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟ ';

  @override
  String get createOne => 'إنشاء حساب';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟ ';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get avatar => 'الصورة الرمزية';

  @override
  String get register => 'التسجيل';

  @override
  String get orDivider => 'أو';

  @override
  String get loginWithGoogle => 'الدخول عبر جوجل';
}
