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
        if (text.contains('얼굴 읽기로')) {
          text = text.replaceAll('얼굴 읽기로', "관상으로");
        }
        if (text.contains('얼굴 읽기')) {
          text = text.replaceAll('얼굴 읽기', "관상");
        }
        if (text.contains('얼굴 특징')) {
          text = text.replaceAll('얼굴 특징', "관상");
        }
        if (text.contains('얼굴 독서는')) {
          text = text.replaceAll('얼굴 독서는', "관상은");
        }
        if (text.contains('얼굴 독서로')) {
          text = text.replaceAll('얼굴 독서로', "관상으로");
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
        if (text.contains('관상을 읽고')) {
          text = text.replaceAll('관상을 읽고', "관상을 확인하고");
        }
        if (text.contains('적절한 직업')) {
          text = text.replaceAll('적절한 직업', "어울리는 직업");
        }
        if (text.contains('마지막 관상')) {
          text = text.replaceAll('마지막 관상', "최근 관상 확인");
        }
        if (text.contains('나머지 기회')) {
          text = text.replaceAll('나머지 기회', "남은 기회");
        }
        if (text.contains('있습니다')) {
          text = text.replaceAll('있습니다', "있어요");
        }
        if (text.contains('했습니다')) {
          text = text.replaceAll('했습니다', "했어요");
        }
        if (text.contains('경력을')) {
          text = text.replaceAll('경력을', "직업을");
        }
        if (text.contains('지지자')) {
          text = text.replaceAll('지지자', "서포터");
        }
        if (text.contains('지원')) {
          text = text.replaceAll('지원', "서포트 하기");
        }
        if (text.contains(
            "'10 free uses per hour\n10 more uses per Buy me a coffee charge'")) {
          text = text.replaceAll(
              "'10 free uses per hour\n10 more uses per Buy me a coffee charge'",
              '매 시간 10회의 무료 사용 가능\n하단의 Buy me a coffee 충전 시 공용 횟수 10회 추가');
        }
      }
      return text;
    }
    return input;
  },
);
