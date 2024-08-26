import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortune/generated/flutter_gen/assets.gen.dart';
import 'package:fortune/src/common_widgets/async_value_widget.dart';
import 'package:fortune/src/constants/app_sizes.dart';
import 'package:fortune/src/features/payment/data/support_repository.dart';

import '../../../localization/data/locale_notifier.dart';

class SupportScreen extends ConsumerStatefulWidget {
  const SupportScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SupportScreenState();
}

class _SupportScreenState extends ConsumerState<SupportScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final purchasesAsyncValue = ref.watch(purchaseStreamProvider);
    final textTheme = Theme.of(context).textTheme;
    final carouselController = CarouselController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer(
          builder: (context, ref, child) {
            final translatedText = ref.watch(translatedTextProvider(
                "It's Free to Operate Thanks to Supporters"));
            return translatedText.when(
              data: (text) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  gapW8,
                  Assets.emojis.greenHeart.image(
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
              loading: () => Text(''),
              error: (e, st) => Text(''),
            );
          },
        ),
        SizedBox(height: 16),
        AsyncValueWidget(
            value: purchasesAsyncValue,
            data: (purchases) {
              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 100),
                child: CarouselView(
                  itemExtent: 300,
                  shrinkExtent: 300,
                  onTap: null,
                  // (index) {
                  //   selectedIndex = index;
                  //   // print('index: $index');
                  //   // carouselController.jumpTo(selectedIndex.toDouble());
                  //   // carouselController.animateTo(index.toDouble(),
                  //   //     duration: Duration(seconds: 1),
                  //   //     curve: Curves.easeInOut);
                  // },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  controller: carouselController,
                  children: [
                    ...purchases.map((purchase) {
                      return Card(
                        elevation: 0.5,
                        child: ListTile(
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          title: Text(purchase.supporterName),
                          subtitle: Text(purchase.message),
                          trailing: Text(
                            'x' + (purchase.quantity * 10).toString(),
                            style: textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList()
                  ],
                ),
              );
            }),
      ],
    );
  }
}
