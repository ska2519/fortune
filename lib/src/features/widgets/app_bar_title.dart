import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortune/src/app.dart';
import 'package:fortune/src/localization/data/locale_notifier.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/flutter_gen/assets.gen.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => context.goNamed(AppRoute.home.name),
      child: Consumer(
        builder: (context, ref, child) {
          final translatedText =
              ref.watch(translatedTextProvider('Face Reading AI'));
          return translatedText.when(
            data: (text) => Row(
              children: [
                Assets.appIcon.image(width: 24, height: 24),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: textTheme.titleLarge,
                ),
              ],
            ),
            loading: () => Text(''),
            error: (e, st) => Text(''),
          );
        },
      ),
    );
  }
}
