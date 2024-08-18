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

final translatedTextProvider = FutureProvider.family<String, String>(
  (ref, input) async {
    final translator = ref.read(translatorProvider);
    final locale = ref.watch(localeProvider);

    final from = 'en';
    final to = locale.locale.languageCode;
    if (from != to) {
      final translatorResult =
          await translator.translate(input, from: from, to: to);
      var text = translatorResult.text;
      debugPrint('text: $text');
      if (to == 'ko') {
        if (text.contains('Face Reading')) {
          text = text.replaceAll('Face Reading', "관상");
        }
        if (text.contains('얼굴 특징')) {
          text = text.replaceAll('얼굴 특징', "관상");
        }
        if (text.contains('얼굴 독서는')) {
          text = text.replaceAll('얼굴 독서는', "관상은");
        }
        if (text.contains('얼굴 읽기')) {
          text = text.replaceAll('얼굴 읽기', "관상");
        }
        if (text.contains('얼굴을')) {
          text = text.replaceAll('얼굴을', "관상을");
        }
        if (text.contains('찾으십시오')) {
          text = text.replaceAll('찾으십시오', "찾으세요");
        }
        if (text.contains('하십시오')) {
          text = text.replaceAll('하십시오', "하세요");
        }
        if (text.contains('잠금 해제하세요')) {
          text = text.replaceAll('잠금 해제하세요', "확인 하세요");
        }
      }
      return text;
    }
    return input;
  },
);
