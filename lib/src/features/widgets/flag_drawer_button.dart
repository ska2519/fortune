import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortune/src/constants/app_sizes.dart';
import 'package:fortune/src/localization/data/locale_notifier.dart';
import 'package:fortune/src/localization/data/most_spoken_languages.dart';

class FlagDrawerButton extends ConsumerWidget {
  const FlagDrawerButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () => Scaffold.of(context).openEndDrawer(),
      icon: Image.asset(
        mostSpokenLanguageLocalesWithFlags
            .firstWhere(
              (flag) => flag.locale == ref.watch(localeProvider).locale,
            )
            .flagImagePath,
        width: 32,
        height: 32,
      ),
    );
  }
}
