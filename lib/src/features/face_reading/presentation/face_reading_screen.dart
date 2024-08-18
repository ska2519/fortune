import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortune/src/common_widgets/responsive_center.dart';
import 'package:fortune/src/constants/gradient.dart';
import 'package:fortune/src/features/payment/presentation/buy_me_a_coffee_button.dart';
import 'package:fortune/src/features/face_reading/domain/face_reading.dart';
import 'package:fortune/src/features/widgets/app_bar_title.dart';
import 'package:fortune/src/features/widgets/footer.dart';
import 'package:fortune/src/localization/data/locale_notifier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_widget/markdown_widget.dart';

class FaceReadingScreen extends ConsumerStatefulWidget {
  const FaceReadingScreen({super.key, required this.faceReading});
  final FaceReading faceReading;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _faceReadingScreenState();
}

class _faceReadingScreenState extends ConsumerState<FaceReadingScreen> {
  FaceReading get faceReading => widget.faceReading;
  late List<PromisingJob> promisingJobs;
  bool isExpanded = false;

  @override
  void initState() {
    promisingJobs = faceReading.promisingJobs.toList();
    promisingJobs.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SelectionArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: backGroundLinearGradient,
            ),
            child: ResponsiveCenter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Align(
                    child: AppBarTitle(),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(height: 24),
                  Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.memory(
                        faceReading.imageBytes!,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Consumer(
                    builder: (context, ref, child) {
                      final translatedText =
                          ref.watch(translatedTextProvider('Face Reading'));
                      return translatedText.when(
                        data: (text) => Text(
                          text,
                          style: textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        loading: () => Text(
                          '',
                          style: textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        error: (e, st) => Text(
                          '',
                          style: textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MarkdownWidget(
                        data: faceReading.physiognomy,
                        selectable: true,
                        shrinkWrap: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  // Consumer(
                  //   builder: (context, ref, child) {
                  //     final translatedText = ref
                  //         .watch(translatedTextProvider(' Future-Proof Jobs:'));
                  //     return translatedText.when(
                  //       data: (text) => Text(
                  //         text,
                  //         style: textTheme.headlineMedium!.copyWith(
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //       loading: () => Text(
                  //         '',
                  //         style: textTheme.headlineMedium!.copyWith(
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //       error: (e, st) => Text(
                  //         '',
                  //         style: textTheme.headlineMedium!.copyWith(
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  // SizedBox(height: 8),
                  // Consumer(
                  //   builder: (context, ref, child) {
                  //     final translatedText = ref.watch(translatedTextProvider(
                  //         '• Recommend jobs that will not disappear due to expertise'));
                  //     return translatedText.when(
                  //       data: (text) => Text(
                  //         text,
                  //         style: textTheme.titleMedium,
                  //       ),
                  //       loading: () => Text(
                  //         '',
                  //         style: textTheme.titleMedium,
                  //       ),
                  //       error: (e, st) => Text(
                  //         '',
                  //         style: textTheme.titleMedium,
                  //       ),
                  //     );
                  //   },
                  // ),
                  // SizedBox(height: 24),
                  // ...physiognomy.difficulties.sublist(1, 4).map(
                  //       (difficulty) => Card(
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: ListTile(
                  //             title: RichText(
                  //                 maxLines: 2,
                  //                 text: TextSpan(
                  //                   children: [
                  //                     TextSpan(
                  //                       text: difficulty.emoji + ' ',
                  //                     ),
                  //                     TextSpan(
                  //                       text: difficulty.job,
                  //                     ),
                  //                     TextSpan(
                  //                       text: ' ' + '⭐️' * difficulty.level,
                  //                     ),
                  //                   ],
                  //                 )),
                  //             subtitle: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 SizedBox(height: 8),
                  //                 Text(difficulty.reason),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  // SizedBox(height: 60),
                  !isExpanded
                      ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isExpanded = true;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('Show more'),
                          ),
                        )
                      : Column(
                          children: [
                            Consumer(
                              builder: (context, ref, child) {
                                final translatedText = ref.watch(
                                    translatedTextProvider(
                                        ' Your Face, Your Future Jobs:'));
                                return translatedText.when(
                                  data: (text) => Text(
                                    text,
                                    style: textTheme.headlineMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  loading: () => Text(
                                    '',
                                    style: textTheme.headlineMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  error: (e, st) => Text(
                                    '',
                                    style: textTheme.headlineMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 24),
                            ...promisingJobs.sublist(0, 1).map(
                                  (job) => Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        title: RichText(
                                          maxLines: 2,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(text: '${job.emoji} '),
                                              TextSpan(text: job.job),
                                            ],
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 4),
                                            Text(
                                                '📚⏳ ' + job.expertStudyPeriod),
                                            SizedBox(height: 8),
                                            Text(job.reason),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          ],
                        ),

                  SizedBox(height: 60),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     final result = await Share.share(
                  //         'Find the secret hidden in your face! https://fortune.fruitshop.app');

                  //     if (result.status == ShareResultStatus.success) {
                  //       print('Thank you for sharing my website!');
                  //     }
                  //   },
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Icon(Icons.face),
                  //       SizedBox(width: 8),
                  //       Text('Share with friends'),
                  //     ],
                  //   ),
                  // ),
                  Footer(),
                  BuyMeACoffeeButton(
                    shopID: kReleaseMode ? '230822' : '230812',
                    customText: 'Support Face Reading x 10',
                    textStyle: GoogleFonts.poppins(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
