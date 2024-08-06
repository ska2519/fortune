import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortune/src/common_widgets/responsive_center.dart';
import 'package:fortune/src/constants/gradient.dart';
import 'package:fortune/src/footer.dart';
import 'package:fortune/src/home_screen.dart';
import 'package:fortune/src/localization/data/locale_notifier.dart';
import 'package:fortune/src/physiognomy/domain/physiognomy.dart';
import 'package:markdown_widget/markdown_widget.dart';

class physiognomyScreen extends ConsumerStatefulWidget {
  const physiognomyScreen({super.key, required this.physiognomy});
  final Physiognomy physiognomy;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _physiognomyScreenState();
}

class _physiognomyScreenState extends ConsumerState<physiognomyScreen> {
  Physiognomy get physiognomy => widget.physiognomy;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            gradient: backGroundLinearGradient,
          ),
          child: ResponsiveCenter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      physiognomy.imageBytes!,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MarkdownWidget(
                    data: physiognomy.physiognomy,
                    shrinkWrap: true,
                  ),
                ),
                SizedBox(height: 60),
                Consumer(
                  builder: (context, ref, child) {
                    final translatedText = ref
                        .watch(translatedTextProvider(' Jobs by difficulty'));
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
                Consumer(
                  builder: (context, ref, child) {
                    final translatedText = ref.watch(translatedTextProvider(
                        '• Recommend jobs that will not disappear due to expertise'));
                    return translatedText.when(
                      data: (text) => Text(
                        text,
                        style: textTheme.titleMedium,
                      ),
                      loading: () => Text(
                        '',
                        style: textTheme.titleMedium,
                      ),
                      error: (e, st) => Text(
                        '',
                        style: textTheme.titleMedium,
                      ),
                    );
                  },
                ),
                SizedBox(height: 24),
                ...physiognomy.difficulties.sublist(0, 3).map(
                      (difficulty) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: RichText(
                                maxLines: 2,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: difficulty.emoji + ' ',
                                    ),
                                    TextSpan(
                                      text: difficulty.job,
                                    ),
                                    TextSpan(
                                      text: ' ' + '⭐️' * difficulty.level,
                                    ),
                                  ],
                                )),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text(difficulty.reason),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                SizedBox(height: 60),
                Consumer(
                  builder: (context, ref, child) {
                    final translatedText =
                        ref.watch(translatedTextProvider(' Future-proof jobs'));
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
                ...physiognomy.promisingJobs.sublist(0, 3).map(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4),
                                Text('📚⏳ ' + job.expertStudyPeriod),
                                SizedBox(height: 8),
                                Text(job.reason),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                SizedBox(height: 60),
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
