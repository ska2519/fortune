import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortune/src/constants/gradient.dart';
import 'package:fortune/src/features/home_screen.dart';
import 'package:fortune/src/localization/data/locale_notifier.dart';
import 'package:fortune/src/localization/data/most_spoken_languages.dart';

class EndDrawer extends ConsumerWidget {
  const EndDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Drawer(
      width: 120,
      key: scaffoldKey,
      child: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            child: Center(
              child: Text(
                'Select Language',
                textAlign: TextAlign.center,
                style: textTheme.titleSmall,
              ),
            ),
            decoration: BoxDecoration(
              gradient: backGroundLinearGradient,
            ),
          ),
          ...mostSpokenLanguageLocalesWithFlags.map(
            (localeWithFlag) {
              return ref.watch(localeProvider).locale == localeWithFlag.locale
                  ? SizedBox()
                  : ListTile(
                      title: Center(
                        child: Image.asset(
                          localeWithFlag.flagImagePath,
                          width: 32,
                          height: 32,
                        ),
                      ),
                      onTap: () {
                        ref.read(localeProvider.notifier).locale =
                            localeWithFlag.locale;
                        Navigator.pop(context);
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
