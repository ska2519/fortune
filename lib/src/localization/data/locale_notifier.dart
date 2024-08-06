// localeProvider 정의 (예시: ChangeNotifier 사용)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortune/src/localization/data/most_spoken_languages.dart';
import 'package:translator/translator.dart';

final translatorProvider =
    Provider<GoogleTranslator>((ref) => GoogleTranslator());

class LocaleNotifier extends ChangeNotifier {
  Locale _locale = mostSpokenLanguageLocales[0]; // 기본 언어 설정 EN
  Locale get locale => _locale;

  set locale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}

final localeProvider = ChangeNotifierProvider((ref) => LocaleNotifier());

final translatedTextProvider =
    FutureProvider.family<String, String>((ref, input) async {
  final locale = ref.watch(localeProvider);
  final translator = ref.read(translatorProvider);

  final from = 'en';
  final to = locale.locale.languageCode;
  final translatorResult =
      await translator.translate(input, from: from, to: to);
  return translatorResult.text;
});
