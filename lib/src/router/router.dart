import 'package:flutter/widgets.dart';
import 'package:fortune/src/features/face_reading/domain/face_reading.dart';
import 'package:fortune/src/features/face_reading/presentation/face_reading_screen.dart';
import 'package:fortune/src/features/home_screen.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home,
faceReading,
}

final router = GoRouter(
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
              transitionDuration: const Duration(milliseconds: 1000),
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
