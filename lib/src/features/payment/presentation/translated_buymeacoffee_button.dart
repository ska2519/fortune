import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortune/src/features/payment/presentation/buy_me_a_coffee_button.dart';
import 'package:fortune/src/localization/data/locale_notifier.dart';

class TranslatedBuymeacoffeeButton extends ConsumerWidget {
  const TranslatedBuymeacoffeeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translatedText = ref
        .watch(translatedTextProvider('Support Face Reading Opportunity x 10'));
    return SelectionContainer.disabled(
      child: translatedText.when(
        data: (text) => BuyMeACoffeeButton(
          shopID: kReleaseMode ? '230822' : '230812',
          customText: text,
        ),
        loading: () => Text(''),
        error: (e, st) => Text(''),
      ),
    );
  }
}
