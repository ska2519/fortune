// Copyright 2024 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fortune/generated/flutter_gen/assets.gen.dart';
import 'package:fortune/src/app.dart';
import 'package:fortune/src/common_widgets/responsive_center.dart';
import 'package:fortune/src/common_widgets/responsive_two_column_layout.dart';
import 'package:fortune/src/constants/breakpoints.dart';
import 'package:fortune/src/constants/gradient.dart';
import 'package:fortune/src/features/payment/presentation/buy_me_a_coffee_button.dart';
import 'package:fortune/src/features/physiognomy/data/image_upload_repository.dart';
import 'package:fortune/src/features/physiognomy/data/statistics_repository.dart';
import 'package:fortune/src/features/physiognomy/domain/physiognomy.dart';
import 'package:fortune/src/features/physiognomy/domain/prompts.dart';
import 'package:fortune/src/features/widgets/app_bar_title.dart';
import 'package:fortune/src/features/widgets/footer.dart';
import 'package:fortune/src/features/widgets/lsd_image_animation.dart';
import 'package:fortune/src/localization/data/locale_notifier.dart';
import 'package:fortune/src/localization/data/most_spoken_languages.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:timeago/timeago.dart' as timeago;

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// final GlobalKey _loadingDialogKey = GlobalKey();

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _loading = false;
  late final GenerativeModel _model;
  Image? image;
  final faces = [
    Assets.faces.aionyHaust3TLl97HNJoUnsplash,
    Assets.faces.danieFrancoA6O7pgc7vHgUnsplash,
    Assets.faces.erikLucateroD2MSDujJl2gUnsplash,
    Assets.faces.gabrielSilverioU3WmDyKGsrYUnsplash,
    Assets.faces.jackFinniganRriAI0nhcbcUnsplash,
    Assets.faces.juricaKoletic7YVZYZeITc8Unsplash,
  ];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = ui.PlatformDispatcher.instance.locale;
      if (locale.languageCode != 'en') ref.read(localeProvider).locale = locale;
    });

    _model = FirebaseVertexAI.instanceFor(
      appCheck: FirebaseAppCheck.instance,
    ).generativeModel(
      model: 'gemini-1.5-flash-preview-0514',
      generationConfig: GenerationConfig(
        temperature: 2.0,
        responseMimeType: 'application/json',
      ),
      safetySettings: [
        SafetySetting(
          HarmCategory.harassment,
          HarmBlockThreshold.none,
        ),
        SafetySetting(
          HarmCategory.hateSpeech,
          HarmBlockThreshold.none,
        ),
        SafetySetting(
          HarmCategory.dangerousContent,
          HarmBlockThreshold.none,
        ),
        SafetySetting(
          HarmCategory.sexuallyExplicit,
          HarmBlockThreshold.none,
        ),
        SafetySetting(
          HarmCategory.unspecified,
          HarmBlockThreshold.none,
        ),
      ],
      systemInstruction: Content.system(instruction),
    );
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Future<void> _submitImage() async {
      try {
        FilePickerResult? filePickerResult =
            await FilePicker.platform.pickFiles(
          //! heic 지원 필요하나 이미지 압축이 안되고 flutter widget에서 빌드 안됨 jpg 변환 필요
          type: FileType.image,
          allowMultiple: false,
        );
        if (filePickerResult != null) {
          var bytes = filePickerResult.files.first.bytes!;
          bytes = await ImageUploadRepository().compressImage(bytes);

          setState(() {
            _loading = true;
            image = Image.memory(bytes, fit: BoxFit.contain);
          });
          final content = [
            Content.multi([
              DataPart('image/jpeg', bytes),
              TextPart(prompt(ref.read(localeProvider).locale.languageCode)),
            ]),
          ];

          var response = await _model.generateContent(content);
          var text = response.text;

          if (text != null) {
            String removeUnnecessaryCharacters(String jsonText) {
              // JSON 시작 부분의 역따옴표와 '```json' 문자열을 제거합니다.
              return jsonText
                  .replaceFirst(RegExp(r'```json\s*'), '')
                  .replaceAll(r'`', '');
            }

            String cleanedJsonString = removeUnnecessaryCharacters(text);
            final cleanedJson = json.decode(cleanedJsonString);
            if (cleanedJson['error'] != null) {
              _showError(cleanedJson['error']);
              return;
            }
            var physiognomy = Physiognomy.fromJson(cleanedJson);
            physiognomy = physiognomy.copyWith(
              imageBytes: bytes,
            );
            debugPrint('physiognomy: $physiognomy');
            if (physiognomy.difficulties.isNotEmpty) {
              ref.read(statisticsRepositoryProvider).incrementCount();
              //! goNamed로 이동해야 web 브라우저에서 주소 변경 가능
              context.goNamed(
                AppRoute.physiognomy.name,
                extra: physiognomy,
              );
            } else {
              _showError('No face detected.');
            }
          } else if (text == null) {
            _showError('No response from API.');
          }
        }
      } catch (e) {
        _showError(e.toString());
      } finally {
        setState(() {
          _loading = false;
          image = null;
        });
      }
    }

    return SelectionArea(
      child: Scaffold(
        endDrawer: Drawer(
          width: 120,
          key: _scaffoldKey,
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
                  return ref.watch(localeProvider).locale ==
                          localeWithFlag.locale
                      ? SizedBox()
                      : ListTile(
                          title: Center(
                              child: Image.asset(
                            localeWithFlag.flagImagePath,
                            width: 32,
                            height: 32,
                          )),
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
        ),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            decoration: BoxDecoration(
              gradient: backGroundLinearGradient,
            ),
            child: ResponsiveCenter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBarTitle(),
                      Builder(builder: (context) {
                        mostSpokenLanguageLocalesWithFlags
                            .firstWhere(
                              (element) =>
                                  element.locale ==
                                  ref.watch(localeProvider).locale,
                            )
                            .flagImagePath;

                        return IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => Scaffold.of(context).openEndDrawer(),
                          icon: Image.asset(
                            mostSpokenLanguageLocalesWithFlags
                                .firstWhere(
                                  (flag) =>
                                      flag.locale ==
                                      ref.watch(localeProvider).locale,
                                )
                                .flagImagePath,
                            width: 32,
                            height: 32,
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 60),

                  ResponsiveTwoColumnLayout(
                    spacing: 80,
                    startFlex: 1,
                    endFlex: 1,
                    startContent: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Consumer(
                            builder: (context, ref, child) {
                              final translatedText = ref.watch(
                                  translatedTextProvider(
                                      'Unlock Your Future with Face Reading AI'));
                              return translatedText.when(
                                data: (text) => Text(
                                  text,
                                  style: textTheme.displaySmall,
                                ),
                                loading: () => SizedBox(
                                  height: 1400,
                                  width: 700,
                                ),
                                error: (e, st) => Text(''),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 60),
                        Flexible(
                          child: Consumer(
                            builder: (context, ref, child) {
                              final translatedText = ref.watch(
                                  translatedTextProvider(
                                      "Discover your potential based on the unique features of your face.\nExplore the deeper meaning behind your facial features.\nFace Reading offers a unique perspective on self-discovery."));
                              return translatedText.when(
                                data: (text) => Text(
                                  text,
                                  style: textTheme.titleMedium!.copyWith(
                                    height: 1.6,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                loading: () => Text(''),
                                error: (e, st) => Text(''),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    endContent: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GridView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 3 / 4,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          children: faces.map((face) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: face.image(
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 32),
                        if (image != null)
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: BackdropFilter(
                                  filter: ui.ImageFilter.blur(
                                    sigmaX: 8,
                                    sigmaY: 8,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: LSDImageAnimation(image: image!),
                                  ),
                                ),
                              ),
                              SpinKitRipple(
                                size: MediaQuery.of(context).size.width / 2,
                                itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: index.isEven
                                        ? Colors.deepPurpleAccent
                                            .withOpacity(0.3)
                                        : Colors.yellowAccent.withOpacity(0.3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: !_loading
                              ? () async {
                                  await _submitImage();
                                }
                              : null,
                          icon:
                              _loading ? null : Icon(Icons.camera_alt_rounded),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: _loading
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      LoadingAnimationWidget.dotsTriangle(
                                        color: Colors.deepPurpleAccent,
                                        size: 32,
                                      ),
                                      SizedBox(width: 16),
                                      Consumer(
                                        builder: (context, ref, child) {
                                          final translatedText = ref.watch(
                                              translatedTextProvider(
                                                  'Analyzing face...🔮'));
                                          return translatedText.when(
                                            data: (text) => Text(text),
                                            loading: () => Text(''),
                                            error: (e, st) => Text(''),
                                          );
                                        },
                                      )
                                    ],
                                  )
                                : Consumer(
                                    builder: (context, ref, child) {
                                      final translatedText = ref.watch(
                                          translatedTextProvider(
                                              'Find your job of fate with Face Reading'));

                                      return translatedText.when(
                                        data: (text) => Text(text),
                                        loading: () => Text(''),
                                        error: (e, st) => Text(''),
                                      );
                                    },
                                  ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Consumer(
                          builder: (context, ref, child) {
                            final records =
                                ref.watch(recordsStreamProvider).value;
                            final remainingTranslatedText = ref.watch(
                                translatedTextProvider(
                                    'Remaining opportunity : '));
                            final faceReadingTranslatedText = ref.watch(
                                translatedTextProvider(
                                    'People checked their Face Reading and identified suitable jobs.'));
                            final translatedText = ref.watch(
                                translatedTextProvider('Last Face Reading : '));

                            return records == null
                                ? SizedBox.shrink()
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${remainingTranslatedText.value} ${records.remainingFaceReadings}',
                                            style:
                                                textTheme.labelMedium!.copyWith(
                                              color:
                                                  records.remainingFaceReadings >
                                                          0
                                                      ? Colors.black
                                                      : Colors.redAccent,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: records.faceReadings
                                                      .toString() +
                                                  ' ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: ' ',
                                            ),
                                            TextSpan(
                                              text: faceReadingTranslatedText
                                                  .value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            ),
                                            TextSpan(
                                              text: ' 🔮',
                                              style: textTheme.labelMedium!
                                                  .copyWith(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      RichText(
                                        textAlign: TextAlign.right,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: translatedText.value,
                                              style: textTheme.labelSmall!
                                                  .copyWith(
                                                      color: Colors.grey[800]),
                                            ),
                                            TextSpan(
                                              text: ref
                                                      .watch(
                                                        translatedTextProvider(
                                                          timeago.format(records
                                                              .timestamp),
                                                        ),
                                                      )
                                                      .value ??
                                                  '',
                                              style: textTheme.labelSmall!
                                                  .copyWith(
                                                      color: Colors.grey[800]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                          },
                        ),
                        SizedBox(height: 60),
                      ],
                    ),
                  ),

                  SizedBox(
                      height:
                          MediaQuery.of(context).size.width > Breakpoint.tablet
                              ? 140
                              : 80),
                  Consumer(
                    builder: (context, ref, child) {
                      final translatedText = ref.watch(translatedTextProvider(
                          'If blocked due to policy. Please try again.'));
                      return translatedText.when(
                        data: (text) => Text(
                          text,
                          style: textTheme.labelSmall!
                              .copyWith(color: Colors.redAccent),
                        ),
                        loading: () => Text(''),
                        error: (e, st) => Text(''),
                      );
                    },
                  ),
                  SizedBox(height: 32),
                  Divider(),

                  MarkdownWidget(
                    data: faceReading,
                    shrinkWrap: true,
                  ),

                  SizedBox(height: 80),
                  Footer(),
                  BuyMeACoffeeButton(
                    shopID: kReleaseMode ? '230822' : '230812',
                    customText: 'Support Face Reading x 10',
                    textStyle: GoogleFonts.poppins(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 40),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     ref.read(statisticsRepositoryProvider).incrementCount();
                  //     final count = await ref
                  //         .read(statisticsRepositoryProvider)
                  //         .getFaceReadingsCount();
                  //     print('count: $count');
                  //     // Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(builder: (context) => AdSenseWeb()),
                  //     // );
                  //   },
                  //   child: Text('incrementCount'),
                  // ),
                  // SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
