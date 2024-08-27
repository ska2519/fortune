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
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final purchasesAsyncValue = ref.watch(purchaseStreamProvider);

    return SelectionContainer.disabled(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          gapH16,
          AsyncValueWidget(
              value: purchasesAsyncValue,
              loading: () => gapH64,
              data: (purchases) {
                return ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 80),
                  child: ListView.builder(
                    itemCount: purchases.length,
                    itemExtent: 300,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      final purchase = purchases[index];
                      return Card(
                        elevation: 0.5,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          dense: true,
                          onTap: () {
                            // setState(() {
                            //   selectedIndex = index;
                            //   scrollController.animateTo(
                            //     index * 300.0,
                            //     duration: Duration(milliseconds: 300),
                            //     curve: Curves.easeInOut,
                            //   );
                            // });
                          },
                          visualDensity: VisualDensity.compact,
                          title: Text(purchase.supporterName),
                          subtitle: Text(purchase.message),
                          trailing: Text(
                            'x' + (purchase.quantity * 10).toString(),
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
