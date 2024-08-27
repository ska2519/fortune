import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:fortune/firebase_options_prod.dart';
import 'package:fortune/src/app.dart';

const reCAPTCHAsiteKey = '6LeoQxYqAAAAAKUGi7-laBmbQCosZLASZfMJbqWH';
const debugToken = '4e7a1696-3be5-4462-8959-4cb247181f51';
late final FirebaseAnalytics analytics;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider(
      kReleaseMode ? reCAPTCHAsiteKey : debugToken,
    ),
    // Default provider for Android is the Play Integrity provider.
    androidProvider:
        kReleaseMode ? AndroidProvider.playIntegrity : AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider.
    // App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider:
        kReleaseMode ? AppleProvider.deviceCheck : AppleProvider.debug,
  );
  analytics = FirebaseAnalytics.instance;
  if (kReleaseMode) analytics.logAppOpen();

  // MobileAds.instance.initialize();
  // ! Uncomment this if you need to sign out when switching between Firebase
  // * projects (e.g. Firebase Local emulator vs real Firebase backend)
  // await FirebaseAuth.instance.signOut();
  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  // create an app bootstrap instance
  runApp(
    ProviderScope(
      child: const App(),
    ),
  );
}
