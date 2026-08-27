// ─────────────────────────────────────────────────────────────
// FILE: lib/utils/constants.dart
// PURPOSE: Centralized app-wide constants — route names,
//          shared preference keys, and config values.
//          Import this wherever you need a string literal.
// ─────────────────────────────────────────────────────────────

class AppRoutes {
  // Named routes for Navigator.pushNamed(context, AppRoutes.login)
  static const String splash   = '/';
  static const String login    = '/login';
  static const String home     = '/home';
  static const String mood     = '/mood';
  static const String focus    = '/focus';
  static const String report   = '/report';
}

class AppStrings {
  // ── App identity ─────────────────────────────────────────────
  static const String appName    = 'MIND TRACE';
  static const String appTagline = 'Neural Wellness Interface';
  static const String version    = 'v1.0.0';

  // ── Onboarding / auth ────────────────────────────────────────
  static const String welcomeBack   = 'WELCOME BACK';
  static const String signIn        = 'SIGN IN';
  static const String emailLabel    = 'Neural ID (Email)';
  static const String passwordLabel = 'Access Code';
  static const String forgotPass    = 'Reset Access?';
  static const String noAccount     = "New to MindTrace? ";
  static const String signUp        = 'Initialize';

  // ── Navigation labels ────────────────────────────────────────
  static const String navHome   = 'Home';
  static const String navMood   = 'Mood';
  static const String navFocus  = 'Focus';
  static const String navReport = 'Report';

  // ── Mood labels ──────────────────────────────────────────────
  static const List<String> moodLabels = [
    'TERRIBLE', 'BAD', 'NEUTRAL', 'GOOD', 'GREAT',
  ];
  static const List<String> moodEmojis = ['😔', '😟', '😐', '🙂', '😄'];

  // ── Focus session durations (minutes) ───────────────────────
  static const List<int> focusDurations = [15, 25, 45, 60];

  // ── SharedPreferences keys ───────────────────────────────────
  static const String prefIsLoggedIn   = 'is_logged_in';
  static const String prefUserName     = 'user_name';
  static const String prefUserEmail    = 'user_email';
  static const String prefOnboarded    = 'has_onboarded';
  static const String prefDailyStreak  = 'daily_streak';
  static const String prefLastMoodDate = 'last_mood_date';
}

class AppSizes {
  // ── Spacing scale ────────────────────────────────────────────
  static const double xs  = 4.0;
  static const double sm  = 8.0;
  static const double md  = 16.0;
  static const double lg  = 24.0;
  static const double xl  = 32.0;
  static const double xxl = 48.0;

  // ── Border radius ─────────────────────────────────────────────
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 20.0;
  static const double radiusXl = 28.0;

  // ── Icon sizes ───────────────────────────────────────────────
  static const double iconSm = 18.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
}