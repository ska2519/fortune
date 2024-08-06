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

import 'package:emoji_flag_converter/emoji_flag_converter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortune/generated/flutter_gen/assets.gen.dart';
import 'package:fortune/src/app.dart';
import 'package:fortune/src/common_widgets/responsive_center.dart';
import 'package:fortune/src/common_widgets/responsive_two_column_layout.dart';
import 'package:fortune/src/constants/breakpoints.dart';
import 'package:fortune/src/constants/gradient.dart';
import 'package:fortune/src/footer.dart';
import 'package:fortune/src/localization/data/locale_notifier.dart';
import 'package:fortune/src/localization/data/most_spoken_languages.dart';
import 'package:fortune/src/physiognomy/data/image_upload_repository.dart';
import 'package:fortune/src/physiognomy/domain/physiognomy.dart';
import 'package:fortune/src/prompts.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey _loadingDialogKey = GlobalKey();

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

          // showDialog(
          //   context: context,
          //   barrierDismissible: true,
          //   builder: (context) {
          //     return AlertDialog(
          //       key: _loadingDialogKey,
          //       title: Row(
          //         children: [
          //           LoadingAnimationWidget.dotsTriangle(
          //             color: Colors.deepPurpleAccent,
          //             size: 32,
          //           ),
          //           SizedBox(width: 16),
          //           Text('Analyzing face...🔮'),
          //         ],
          //       ),
          //       content: ClipRRect(
          //         borderRadius: BorderRadius.circular(16),
          //         child: image,
          //       ),
          //     );
          //   },
          // );

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

            var physiognomy = Physiognomy.fromJson(cleanedJson);
            physiognomy = physiognomy.copyWith(
              imageBytes: bytes,
            );
            debugPrint('physiognomy: $physiognomy');
            if (physiognomy.difficulties.isNotEmpty) {
              // Navigator.pop(_loadingDialogKey.currentContext!);
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

    return Scaffold(
      endDrawer: Drawer(
        width: 100,
        key: _scaffoldKey,
        child: ListView(
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
            ...mostSpokenLanguageLocales.map(
              (locale) {
                final emojiFlag =
                    EmojiConverter.fromAlpha2CountryCode(locale.countryCode!);

                return ref.read(localeProvider).locale == locale
                    ? SizedBox.shrink()
                    : ListTile(
                        title: Center(child: Text(emojiFlag)),
                        onTap: () {
                          ref.read(localeProvider.notifier).locale = locale;
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
                    Builder(
                      builder: (context) => IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: Scaffold.of(context).openEndDrawer,
                        icon: Text(
                          EmojiConverter.fromAlpha2CountryCode(
                            ref.watch(localeProvider).locale.countryCode!,
                          ),
                        ),
                      ),
                    ),
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
                            final translatedText = ref.watch(translatedTextProvider(
                                'Discover your potential based on the unique features of your face.\nOur AI-powered analysis provides personalized recommendations to help you thrive.'));
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: image,
                          ),
                        ),
                      // SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: !_loading
                            ? () async {
                                await _submitImage();
                              }
                            : null,
                        icon: _loading ? null : Icon(Icons.camera_alt_rounded),
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
                                            'Get your fate with Face Reading'));
                                    return translatedText.when(
                                      data: (text) => Text(text),
                                      loading: () => Text(''),
                                      error: (e, st) => Text(''),
                                    );
                                  },
                                ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Consumer(
                        builder: (context, ref, child) {
                          final translatedText = ref.watch(translatedTextProvider(
                              'We do not store any personal information, including facial images.'));
                          return translatedText.when(
                            data: (text) => Text(
                              text,
                              textAlign: TextAlign.center,
                              style: textTheme.labelMedium!
                                  .copyWith(color: Colors.grey[800]),
                            ),
                            loading: () => Text(''),
                            error: (e, st) => Text(''),
                          );
                        },
                      ),

                      //   '323 people found their occupations through face reading.',
                      //   textAlign: TextAlign.center,
                      //   style: Theme.of(context).textTheme.labelLarge,
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                    height:
                        MediaQuery.of(context).size.width > Breakpoint.tablet
                            ? 140
                            : 80),
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
              ref.watch(translatedTextProvider('🔮 Face Reading AI'));
          return translatedText.when(
            data: (text) => Text(
              text,
              style: textTheme.titleLarge,
            ),
            loading: () => Text(''),
            error: (e, st) => Text(''),
          );
        },
      ),
    );
  }
}
