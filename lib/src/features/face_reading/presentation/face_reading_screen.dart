import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortune/main.dart';
import 'package:fortune/src/common_widgets/responsive_center.dart';
import 'package:fortune/src/constants/app_sizes.dart';
import 'package:fortune/src/constants/gradient.dart';
import 'package:fortune/src/features/face_reading/domain/face_reading.dart';
import 'package:fortune/src/features/payment/presentation/support_screen.dart';
import 'package:fortune/src/features/payment/presentation/translated_buymeacoffee_button.dart';
import 'package:fortune/src/features/widgets/app_bar_title.dart';
import 'package:fortune/src/features/widgets/footer.dart';
import 'package:fortune/src/localization/data/locale_notifier.dart';
import 'package:ionicons/ionicons.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:share_plus/share_plus.dart';

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

  var promisingJobEndIndex = 1;

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
                  gapH16,
                  Align(
                    child: AppBarTitle(),
                    alignment: Alignment.centerLeft,
                  ),
                  gapH24,
                  Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.memory(
                        faceReading.imageBytes!,
                      ),
                    ),
                  ),
                  gapH40,
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
                  gapH16,
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MarkdownWidget(
                        data: faceReading.physiognomy,
                        selectable: true,
                        shrinkWrap: true,
                      ),
                    ),
                  ),
                  gapH64,
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
                  // gapH8,
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
                  //  gapH24,
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
                  //                 gapH8,
                  //                 Text(difficulty.reason),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  // gapH64,
                  !isExpanded
                      ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isExpanded = true;
                            });
                            if (kReleaseMode)
                              analytics.logEvent(
                                  name: 'Click Show My Suitable Career Button');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('Show My Suitable Career'),
                          ),
                        )
                      : Column(
                          children: [
                            Consumer(
                              builder: (context, ref, child) {
                                final translatedText = ref.watch(
                                    translatedTextProvider(
                                        promisingJobEndIndex > 1
                                            ? 'Your Future Careers'
                                            : 'Your Future Career'));
                                return translatedText.when(
                                  data: (text) => Text(
                                    text,
                                    style: textTheme.headlineMedium!.copyWith(),
                                  ),
                                  loading: () => Text(
                                    '',
                                    style: textTheme.headlineMedium!.copyWith(),
                                  ),
                                  error: (e, st) => Text(
                                    '',
                                    style: textTheme.headlineMedium!.copyWith(),
                                  ),
                                );
                              },
                            ),
                            gapH24,
                            ...promisingJobs
                                .sublist(0, promisingJobEndIndex)
                                .map(
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
                                            gapH4,
                                            Text(
                                                '📚⏳ ' + job.expertStudyPeriod),
                                            gapH8,
                                            Text(job.reason),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          ],
                        ),

                  gapH64,

                  if (isExpanded && promisingJobEndIndex < 2)
                    Builder(
                      builder: (BuildContext context) {
                        final text = """
This might be my career!

${promisingJobs.first.emoji} ${promisingJobs.first.job}

${promisingJobs.first.reason}

Find the secret hidden in your face!
https://fortune.fruitshop.app""";
                        return ElevatedButton.icon(
                          onPressed: () =>
                              Clipboard.setData(ClipboardData(text: text)).then(
                            (value) {
                              final snackBar = SnackBar(
                                content: Text('Copied to Clipboard'),
                                action: SnackBarAction(
                                  label: 'close',
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar); // -> show a notification
                              setState(() {
                                promisingJobEndIndex = 2;
                              });
                              if (kReleaseMode)
                                analytics.logEvent(name: 'click_share_button');
                            },
                          ),
                          icon: Icon(Ionicons.copy_outline),
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Share & Find New Career',
                            ),
                          ),
                        );
                      },
                    ),
                  gapH32,
                  Divider(),
                  gapH16,
                  SupportScreen(),
                  gapH40,
                  TranslatedBuymeacoffeeButton(),
                  gapH16,
                  Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Share result: ${result.status}"),
          if (result.status == ShareResultStatus.success)
            Text("Shared to: ${result.raw}")
        ],
      ),
    );
  }
}
