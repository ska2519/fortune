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
import 'package:fortune/src/common_widgets/responsive_center.dart';
import 'package:fortune/src/common_widgets/responsive_two_column_layout.dart';
import 'package:fortune/src/constants/app_sizes.dart';
import 'package:fortune/src/constants/breakpoints.dart';
import 'package:fortune/src/constants/gradient.dart';
import 'package:fortune/src/features/face_reading/data/image_upload_repository.dart';
import 'package:fortune/src/features/face_reading/data/statistics_repository.dart';
import 'package:fortune/src/features/face_reading/domain/face_reading.dart';
import 'package:fortune/src/features/face_reading/domain/prompts.dart';
import 'package:fortune/src/features/payment/presentation/support_screen.dart';
import 'package:fortune/src/features/payment/presentation/translated_buymeacoffee_button.dart';
import 'package:fortune/src/features/seo/widgets/app_text.dart';
import 'package:fortune/src/features/widgets/app_bar_title.dart';
import 'package:fortune/src/features/widgets/end_drawer.dart';
import 'package:fortune/src/features/widgets/flag_drawer_button.dart';
import 'package:fortune/src/features/widgets/footer.dart';
import 'package:fortune/src/features/widgets/lsd_image_animation.dart';
import 'package:fortune/src/localization/data/locale_notifier.dart';
import 'package:fortune/src/router/router.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:seo/seo.dart';
import 'package:timeago/timeago.dart' as timeago;

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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

  Future<void> _submitImage() async {
    try {
      FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
        //! heic 지원 필요하나 이미지 압축이 안되고 flutter widget에서 빌드 안됨 jpg 변환 필요
        type: FileType.image,
        allowMultiple: false,
      );
      if (filePickerResult != null) {
        final bytes = filePickerResult.files.first.bytes!;
        final compressImageBytes =
            await ImageUploadRepository().compressImage(bytes);

        setState(() {
          _loading = true;
          image = Image.memory(compressImageBytes, fit: BoxFit.contain);
        });
        final content = [
          Content.multi([
            DataPart('image/jpeg', compressImageBytes),
            TextPart(prompt(ref.read(localeProvider).locale.languageCode)),
          ]),
        ];

        var response = await _model.generateContent(content);
        var text = response.text;
        debugPrint('text: $text');
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

          final faceReading = FaceReading.fromJson(cleanedJson).copyWith(
            imageBytes: compressImageBytes,
          );

          if (faceReading.difficulties.isNotEmpty) {
            ref.read(statisticsRepositoryProvider).updateCounts();
            //! goNamed로 이동해야 web 브라우저에서 주소 변경 가능
            context.goNamed(
              AppRoute.faceReading.name,
              extra: faceReading,
            );
          } else {
            _showError('No face detected.');
          }
        } else if (text == null) {
          _showError('No response from API.');
        }
      }
    } catch (e) {
      if (e.toString().contains('Quota exceeded')) {
        _showError('Quota exceeded - Gemini-1.5-flash');
        return;
      }
      _showError(e.toString());
    } finally {
      setState(() {
        _loading = false;
        image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return
        // AppHead(
        //   title: 'Face Reading AI',
        //   description:
        //       'Discover your potential based on the unique features of your face. Explore the deeper meaning behind your facial features. Face Reading AI offers a unique perspective on self-discovery.',
        //   author: 'sk@',

        //   child:
        Scaffold(
      endDrawer: EndDrawer(),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gapH16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppBarTitle(),
                    FlagDrawerButton(),
                  ],
                ),
                gapH64,
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
                              data: (text) => AppText(
                                text,
                                tagStyle: TextTagStyle.h1,
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
                      gapH64,
                      Flexible(
                        child: Consumer(
                          builder: (context, ref, child) {
                            final translatedText = ref.watch(
                              translatedTextProvider(
                                "Discover your potential based on the unique features of your face.\nExplore the deeper meaning behind your facial features.\nFace Reading AI offers a unique perspective on self-discovery.",
                              ),
                            );
                            return translatedText.when(
                              data: (text) => AppText(
                                tagStyle: TextTagStyle.h2,
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
                      gapH80,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              final records =
                                  ref.watch(recordsStreamProvider).value;
                              final faceReadingTranslatedText = ref.watch(
                                  translatedTextProvider(
                                      'People checked their Face Reading and identified suitable Careers'));
                              return records == null
                                  ?
                                  // AnimatedContainer(
                                  //     // Use the properties stored in the State class.
                                  //     // width: _width,
                                  //     height: 80,
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.grey[200]!,
                                  //       borderRadius: BorderRadius.circular(16),
                                  //     ),
                                  //     // Define how long the animation should take.
                                  //     duration: const Duration(seconds: 1),
                                  //     // Provide an optional curve to make the animation feel smoother.
                                  //     curve: Curves.fastOutSlowIn,
                                  //   )
                                  // :
                                  Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200]!,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    )
                                  : Card(
                                      elevation: 0.1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: records.faceReadings
                                                        .toString() +
                                                    ' ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      color: Colors
                                                          .deepPurpleAccent,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    .titleMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                            },
                          ),
                          gapH4,
                          Consumer(
                            builder: (context, ref, child) {
                              final translatedText = ref.watch(
                                  translatedTextProvider(
                                      'We do not store photo or personal information.'));
                              return translatedText.when(
                                data: (text) => Text(
                                  text,
                                  style: textTheme.labelMedium!
                                      .copyWith(color: Colors.redAccent),
                                ),
                                loading: () => Text(''),
                                error: (e, st) => Text(''),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  endContent: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.builder(
                        itemCount: faces.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemBuilder: (context, i) => ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: faces[i].image(
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      gapH32,
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
                                      ? Colors.deepPurpleAccent.withOpacity(0.3)
                                      : Colors.yellowAccent.withOpacity(0.3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      gapH16,
                      Consumer(
                        builder: (context, ref, child) {
                          final records =
                              ref.watch(recordsStreamProvider).value;
                          return records == null
                              ? SizedBox()
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: _loading ||
                                              records.remainingFaceReadings <= 0
                                          ? null
                                          : () async {
                                              await _submitImage();
                                            },
                                      icon: _loading
                                          ? null
                                          : Icon(Icons.camera_alt_rounded),
                                      label: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16.0,
                                        ),
                                        child: _loading
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  LoadingAnimationWidget
                                                      .dotsTriangle(
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                    size: 32,
                                                  ),
                                                  gapW16,
                                                  Consumer(
                                                    builder:
                                                        (context, ref, child) {
                                                      final translatedText = ref.watch(
                                                          translatedTextProvider(
                                                              'Analyzing face...🔮'));
                                                      return translatedText
                                                          .when(
                                                        data: (text) =>
                                                            Text(text),
                                                        loading: () => Text(''),
                                                        error: (e, st) =>
                                                            Text(''),
                                                      );
                                                    },
                                                  )
                                                ],
                                              )
                                            : Consumer(
                                                builder: (context, ref, child) {
                                                  final translatedText =
                                                      ref.watch(
                                                    translatedTextProvider(
                                                      'Find Your Careers of Fate with Face Reading',
                                                    ),
                                                  );

                                                  return translatedText.when(
                                                    data: (text) => AppText(
                                                      text,
                                                      tagStyle: TextTagStyle.h3,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    loading: () => Text(''),
                                                    error: (e, st) => Text(''),
                                                  );
                                                },
                                              ),
                                      ),
                                    ),
                                    gapH8,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Consumer(
                                          builder: (context, ref, child) {
                                            final remainingTranslatedText = ref
                                                .watch(translatedTextProvider(
                                                    'Remaining opportunity : '));
                                            return remainingTranslatedText.when(
                                              data: (text) => Text(
                                                '${text} ${records.remainingFaceReadings}',
                                                style: textTheme.labelMedium!
                                                    .copyWith(
                                                  color:
                                                      records.remainingFaceReadings >
                                                              0
                                                          ? Colors
                                                              .deepPurpleAccent
                                                          : Colors.redAccent,
                                                ),
                                              ),
                                              error: (error, stackTrace) =>
                                                  Text(''),
                                              loading: () => Text(''),
                                            );
                                          },
                                        ),
                                        gapW4,
                                        Consumer(
                                          builder: (context, ref, child) {
                                            final supportToolTipText = ref
                                                .watch(translatedTextProvider(
                                                    'Please support us by clicking the Support Button below to get 10 more face reading opportunities'));
                                            return supportToolTipText.when(
                                              data: (text) => Tooltip(
                                                message: text,
                                                child: Icon(
                                                  Ionicons.help_circle_outline,
                                                  size: 16,
                                                  color:
                                                      records.remainingFaceReadings >
                                                              0
                                                          ? Colors
                                                              .deepPurpleAccent
                                                          : Colors.redAccent,
                                                ),
                                              ),
                                              error: (error, stackTrace) =>
                                                  Text(''),
                                              loading: () => Text(''),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    gapH8,
                                    Consumer(
                                      builder: (context, ref, child) {
                                        final translatedText = ref.watch(
                                            translatedTextProvider(
                                                'Last Face Reading : '));
                                        return translatedText.when(
                                          error: (error, stackTrace) =>
                                              Text(''),
                                          loading: () => Text(''),
                                          data: (text) => Align(
                                            alignment: Alignment.centerRight,
                                            child: RichText(
                                              textAlign: TextAlign.right,
                                              softWrap: true,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: text,
                                                    style: textTheme.labelSmall!
                                                        .copyWith(
                                                            color: Colors
                                                                .grey[800]),
                                                  ),
                                                  TextSpan(
                                                    text: ref
                                                            .watch(
                                                              translatedTextProvider(
                                                                timeago.format(
                                                                    records
                                                                        .timestamp),
                                                              ),
                                                            )
                                                            .value ??
                                                        '',
                                                    style: textTheme.labelSmall!
                                                        .copyWith(
                                                            color: Colors
                                                                .grey[800]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                        },
                      ),
                      gapH64,
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width > Breakpoint.tablet
                      ? 100
                      : 70,
                ),
                SupportScreen(),
                gapH16,
                TranslatedBuymeacoffeeButton(),
                gapH32,
                Divider(),
                MarkdownWidget(
                  data: faceReading,
                  selectable: true,
                  shrinkWrap: true,
                ),
                gapH40,
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
