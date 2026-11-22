# Movies App

A Flutter movies browsing app: browse, search and explore movies, view full details with cast and screenshots, and keep a personal watch list and watch history per account.

> Reviewed source: branch `develop`, commit `4946f16` (RafatMohamed/movies_app). The default `master` branch is only an empty scaffold; all real code lives on `develop`.

## Features

- **Authentication (Firebase Auth)**
  - Email/password registration and login with localized error messages.
  - Google sign-in, wired from the login screen button through `AuthService.signInWithGoogle()` to Firebase.
  - Forgot-password flow that sends a reset email.
  - Profile management: update name, phone and avatar (chosen from a built-in avatar list), change password, and delete the account. Sensitive actions (password change, account deletion) ask for re-authentication first, with a Google re-auth path for Google accounts.
- **Movies home feed**
  - Loads the latest movies from the API sorted by year.
  - Genre chips are derived from the loaded movies; tapping a genre filters the "watching now" section.
  - Genre labels are translated at runtime into the selected app language.
- **Explore tab**
  - Browse movies by genre, sorted by rating, with paginated loading.
- **Search**
  - Full-text movie search via the API's `query_term` (up to 50 results per query).
- **Movie details**
  - Backdrop and screenshots, cast with photos, full summary with read-more (translatable at runtime), similar-movie suggestions, and a parental guide section.
  - "Watch" button opens the movie's external page via `url_launcher`.
  - Opening a movie records it in the watch history automatically.
- **Watch list (Firestore)**
  - Per-user watch list stored in `users/{uid}/watchList`, live-streamed and ordered by most recently added, with add/remove and an in-list indicator on the details screen.
- **Watch history (Hive)**
  - Recently opened movies cached locally in a per-user Hive box (`history<uid>`), sorted by open time, with remove and clear-all.
- **Profile tab**
  - Live user profile header, watch list and history counters, tabs showing both lists, and logout (which cleanly stops the watch-list stream first).
- **Onboarding and splash**
  - Native splash screen, multi-page onboarding shown only on first open (persisted flag), then routed by auth state on later launches.
- **Localization**
  - Full English/Arabic UI from ARB files, language toggle persisted across launches, RTL-aware layouts (directional padding, borders and back-arrow assets).

## Structure and state management

- Feature-first layout under `lib/`: `core/` (services, models, shared cubits, widgets, theming) plus one folder per feature (`home_tap`, `explore_tap`, `Search`, `MovieDetails`, `profile_tab`, `update_profile`, `login`, `register`, `forget_password`, `Onboarding`, `Splash`, `MainHomeAppView`).
- Each feature follows a simple layered split: `model/` (data source interface + API implementation + repo), `view/` and `view_model/` (Cubit + states).
- State management: **Cubit (flutter_bloc)** with a custom `BlocObserver`; dependency injection via **get_it**.
- Networking: **Dio** against a YTS-compatible API (`https://movies-api.accel.li/api/v2/`: `list_movies`, `movie_details`, `movie_suggestions`, `movie_parental_guides`).
- Persistence: **Cloud Firestore** (user profile + watch list), **Hive** (watch history), **shared_preferences** (locale, onboarding flag).

## Main packages

`flutter_bloc`, `get_it`, `dio`, `firebase_core`, `firebase_auth`, `cloud_firestore`, `google_sign_in`, `hive` + `hive_flutter`, `shared_preferences`, `cached_network_image`, `shimmer` / `skeletonizer`, `flutter_svg`, `carousel_slider`, `translator`, `readmore_flutter`, `url_launcher`, `flutter_native_splash`, `flutter_launcher_icons`, `intl` + `flutter_localizations`.

## Setup

1. Flutter SDK with Dart `^3.12.2`, then `flutter pub get` (localization files generate automatically; the Hive adapter `.g.dart` file is committed).
2. Firebase: the repo includes `google-services.json` and `GoogleService-Info.plist` tied to the author's Firebase project. To run your own copy, replace them with your project's files (FlutterFire CLI).
3. Google sign-in: the app's SHA-1 (and SHA-256) certificate fingerprint must be registered in the Firebase project, or sign-in fails on other machines/builds.
4. Email/password sign-in must be enabled in Firebase Authentication, and a Firestore database created.

## Limits (what the code does not do)

- No in-app playback: the Watch button opens the movie's external web page. The app is a browser/organizer for the API's catalog.
- The movie API is a third-party YTS-compatible mirror, not owned by the app; availability depends on that service.
- Home-feed pagination exists in the data source but is commented out in the cubit, so the home feed loads a single page.
- Dark theme only (`themeMode` is hard-coded to dark).
- `DevicePreview` is left enabled in `main.dart`.
- `lib/feature/FeatureName/` is an empty scaffold template left in the tree.
- Tests: only the default Flutter counter template test; no real test coverage.
- Runtime genre/summary translation uses the `translator` package (Google Translate) and needs network access.

## Code guide

- Auth service (login, register, Google sign-in, reset, re-auth, delete): `lib/core/services/auth_service.dart`
- Firestore wrapper (user profile): `lib/core/services/firestore_service.dart`
- Watch list (Firestore): `lib/core/services/watch_list_data_source/watch_list_remote_data_source_impl.dart`
- Watch history (Hive): `lib/core/services/history_list_data_source/history_list_remote_data_source_impl.dart`
- API client: `lib/core/services/api_helper.dart`, endpoints in `lib/core/const.dart`
- Home feed + genre filtering: `lib/feature/home_tap/`
- Explore by genre: `lib/feature/explore_tap/`
- Search: `lib/feature/Search/`
- Details + watch/history hooks: `lib/feature/MovieDetails/`
- Profile, watch list/history tabs, logout: `lib/feature/profile_tab/`
- Update profile / password / delete account / re-auth: `lib/feature/update_profile/`
- Login (email + Google): `lib/feature/login/widgets/login_view_body.dart`
- Registration with avatar carousel: `lib/feature/register/`
- Locale controller (persisted EN/AR): `lib/core/utilities/app_locale_controller.dart`
- First-open onboarding flag: `lib/core/ChachRemote/is_first_open_app.dart`
