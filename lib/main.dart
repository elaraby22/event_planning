import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/ui/auth/login/login_screen.dart';
import 'package:event_planning/ui/auth/register/register_screen.dart';
import 'package:event_planning/ui/event_details/edit_event.dart';
import 'package:event_planning/ui/event_details/event_details_screen.dart';
import 'package:event_planning/ui/home_screen/home_screen.dart';
import 'package:event_planning/ui/home_screen/tabs/home/add_Event/add_event.dart';
import 'package:event_planning/ui/onboarding/onboarding_screen.dart';
import 'package:event_planning/ui/onboarding/start_screen.dart';
import 'package:event_planning/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        lazy: false, create: (context) => AppLanguageProvider()),
    ChangeNotifierProvider(
        lazy: false, create: (context) => AppThemeProvider()),
    ChangeNotifierProvider(create: (context) => EventListProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        StartScreen.routeName: (context) => StartScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        AddEvent.routeName: (context) => AddEvent(),
        EventDetailsScreen.routeName: (context) => EventDetailsScreen(),
        EditEventScreen.routeName: (context) => EditEventScreen()
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
    );
  }
}
