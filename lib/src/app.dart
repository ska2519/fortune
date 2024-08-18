import 'package:flutter/material.dart';
import 'package:fortune/generated/flutter_gen/fonts.gen.dart';
import 'package:fortune/src/features/home_screen.dart';
import 'package:fortune/src/features/face_reading/domain/face_reading.dart';
import 'package:fortune/src/features/face_reading/presentation/face_reading_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:seo/seo.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return SeoController(
      enabled: true,
      tree: WidgetTree(context: context),
      child: MaterialApp.router(
        key: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Face Reading AI',
        theme: ThemeData(
          fontFamily: FontFamily.nanumSquareNeo,
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
      ),
    );
  }
}

enum AppRoute {
  home,
  faceReading,
}

final _router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final path = state.uri.path;
    if (path == '/${AppRoute.faceReading.name}' &&
        (state.extra == null || state.extra is! FaceReading?)) {
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
          name: AppRoute.faceReading.name,
          path: AppRoute.faceReading.name,
          pageBuilder: (context, state) {
            final faceReading = state.extra as FaceReading;
            return CustomTransitionPage(
              key: state.pageKey,
              child: FaceReadingScreen(faceReading: faceReading),
              transitionDuration: const Duration(milliseconds: 1500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
      ],
    ),
  ],
);
