import 'package:flutter/material.dart';
import 'package:fortune/generated/flutter_gen/fonts.gen.dart';
import 'package:fortune/src/router/router.dart';
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
          scaffoldBackgroundColor: const Color(0xFFEEEEEE),
        ),
        routerConfig: router,
      ),
    );
  }
}
