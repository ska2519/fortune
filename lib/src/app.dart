import 'package:flutter/material.dart';
import 'package:fortune/src/home_screen.dart';
import 'package:fortune/src/physiognomy/domain/physiognomy.dart';
import 'package:fortune/src/physiognomy/presentation/physiognomy_screen.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Face Reading AI',
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurpleAccent,
          brightness: Brightness.light,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            backgroundColor:
                Colors.deepPurpleAccent, // background (button) color
            foregroundColor: Colors.white, // foreground (text) color
          ),
        ),
        useMaterial3: true,
        // scaffoldBackgroundColor: Color(0xFF1c0f10),
      ),
      routerConfig: _router,
    );
  }
}

enum AppRoute {
  home,
  physiognomy,
}

final _router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final path = state.uri.path;
    if (path == '/${AppRoute.physiognomy.name}' &&
        (state.extra == null || state.extra is! Physiognomy?)) {
      return '/';
    }
    return null;
  },
  routes: [
    GoRoute(
      name: AppRoute.home.name,
      path: '/',
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          name: AppRoute.physiognomy.name,
          path: AppRoute.physiognomy.name,
          pageBuilder: (context, state) {
            final physiognomy = state.extra as Physiognomy;
            return MaterialPage(
              child: physiognomyScreen(physiognomy: physiognomy),
            );
          },
        ),
      ],
    ),
  ],
);
