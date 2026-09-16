import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Hint text for the email field on Login/Register
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// Hint text for the password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// Hint text for the confirm password field on Register
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordHint;

  /// Hint text for the name field on Register
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameHint;

  /// Hint text for the phone field on Register
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneHint;

  /// Link on Login that navigates to forget password screen
  ///
  /// In en, this message translates to:
  /// **'Forget Password ?'**
  String get forgetPassword;

  /// Login button text and Register screen's link back to Login
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Text on Login before the Create One link
  ///
  /// In en, this message translates to:
  /// **'Don\'t Have Account ? '**
  String get dontHaveAccount;

  /// Link on Login that navigates to the Register screen
  ///
  /// In en, this message translates to:
  /// **'Create One'**
  String get createOne;

  /// Text on Register before the Login link
  ///
  /// In en, this message translates to:
  /// **'Already Have Account ? '**
  String get alreadyHaveAccount;

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Label under the avatar carousel on Register
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get avatar;

  /// Register screen app bar title
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Divider label between the login form and the Google button
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get orDivider;

  /// Google sign-in button text
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get loginWithGoogle;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @watchList.
  ///
  /// In en, this message translates to:
  /// **'Watch List'**
  String get watchList;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @seeMore.
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get seeMore;

  /// No description provided for @pickAvatar.
  ///
  /// In en, this message translates to:
  /// **'Pick Avatar'**
  String get pickAvatar;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @enterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterYourPhoneNumber;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @updateData.
  ///
  /// In en, this message translates to:
  /// **'Update Data'**
  String get updateData;

  /// No description provided for @currentPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPasswordHint;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordHint;

  /// No description provided for @confirmNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm New password'**
  String get confirmNewPasswordHint;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @oldPasswordIncorrect.
  ///
  /// In en, this message translates to:
  /// **'old password is Incorrect'**
  String get oldPasswordIncorrect;

  /// No description provided for @newPasswordMustDiffer.
  ///
  /// In en, this message translates to:
  /// **'New password must be another for current'**
  String get newPasswordMustDiffer;

  /// No description provided for @watch.
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get watch;

  /// No description provided for @screen_shots.
  ///
  /// In en, this message translates to:
  /// **'Screen Shots'**
  String get screen_shots;

  /// No description provided for @similar.
  ///
  /// In en, this message translates to:
  /// **'Similar'**
  String get similar;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @parental_guide.
  ///
  /// In en, this message translates to:
  /// **'Parental Guide'**
  String get parental_guide;

  /// No description provided for @cast.
  ///
  /// In en, this message translates to:
  /// **'Cast'**
  String get cast;

  /// No description provided for @genres.
  ///
  /// In en, this message translates to:
  /// **'Genres'**
  String get genres;

  /// No description provided for @character.
  ///
  /// In en, this message translates to:
  /// **'Character'**
  String get character;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'is required'**
  String get required;

  /// No description provided for @read_more.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get read_more;

  /// No description provided for @read_less.
  ///
  /// In en, this message translates to:
  /// **'Read less'**
  String get read_less;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @invalidEmailFormat.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmailFormat;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email first'**
  String get pleaseEnterEmail;

  /// No description provided for @passwordResetSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent successfully! Check your inbox.'**
  String get passwordResetSent;

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmail;

  /// No description provided for @authInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'That email address looks invalid.'**
  String get authInvalidEmail;

  /// No description provided for @authUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get authUserDisabled;

  /// No description provided for @authUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No account found with this email.'**
  String get authUserNotFound;

  /// No description provided for @authWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password.'**
  String get authWrongPassword;

  /// No description provided for @authEmailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with this email.'**
  String get authEmailAlreadyInUse;

  /// No description provided for @authWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak.'**
  String get authWeakPassword;

  /// No description provided for @authNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Network error. Check your connection.'**
  String get authNetworkError;

  /// No description provided for @authTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Try again later.'**
  String get authTooManyRequests;

  /// No description provided for @authOperationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Operation not allowed.'**
  String get authOperationNotAllowed;

  /// No description provided for @googleSignInCancelled.
  ///
  /// In en, this message translates to:
  /// **'Google sign in was cancelled.'**
  String get googleSignInCancelled;

  /// No description provided for @googleSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to sign in with Google. Please try again.'**
  String get googleSignInFailed;

  /// No description provided for @authRequiresRecentLogin.
  ///
  /// In en, this message translates to:
  /// **'Please log in again to perform this action.'**
  String get authRequiresRecentLogin;

  /// No description provided for @authNoSignedInUser.
  ///
  /// In en, this message translates to:
  /// **'No signed-in user.'**
  String get authNoSignedInUser;

  /// No description provided for @authDefaultError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authDefaultError;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @adventure.
  ///
  /// In en, this message translates to:
  /// **'Adventure'**
  String get adventure;

  /// No description provided for @animation.
  ///
  /// In en, this message translates to:
  /// **'Animation'**
  String get animation;

  /// No description provided for @biography.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get biography;

  /// No description provided for @comedy.
  ///
  /// In en, this message translates to:
  /// **'Comedy'**
  String get comedy;

  /// No description provided for @crime.
  ///
  /// In en, this message translates to:
  /// **'Crime'**
  String get crime;

  /// No description provided for @documentary.
  ///
  /// In en, this message translates to:
  /// **'Documentary'**
  String get documentary;

  /// No description provided for @drama.
  ///
  /// In en, this message translates to:
  /// **'Drama'**
  String get drama;

  /// No description provided for @family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get family;

  /// No description provided for @fantasy.
  ///
  /// In en, this message translates to:
  /// **'Fantasy'**
  String get fantasy;

  /// No description provided for @horror.
  ///
  /// In en, this message translates to:
  /// **'Horror'**
  String get horror;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @musical.
  ///
  /// In en, this message translates to:
  /// **'Musical'**
  String get musical;

  /// No description provided for @mystery.
  ///
  /// In en, this message translates to:
  /// **'Mystery'**
  String get mystery;

  /// No description provided for @romance.
  ///
  /// In en, this message translates to:
  /// **'Romance'**
  String get romance;

  /// No description provided for @sciFi.
  ///
  /// In en, this message translates to:
  /// **'Sci-Fi'**
  String get sciFi;

  /// No description provided for @sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get sport;

  /// No description provided for @thriller.
  ///
  /// In en, this message translates to:
  /// **'Thriller'**
  String get thriller;

  /// No description provided for @war.
  ///
  /// In en, this message translates to:
  /// **'War'**
  String get war;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
