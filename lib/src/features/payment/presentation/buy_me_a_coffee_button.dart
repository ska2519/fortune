import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fortune/main.dart';
import 'package:fortune/src/features/payment/presentation/themes.dart';
import 'package:url_launcher/url_launcher.dart';

/// Url to the buy me a coffee website
const String buyMeACoffeeUrl = "https://www.buymeacoffee.com/";

/// The [BuyMeACoffeeButton] is the widget. It has a tap event and will trigger as soon someone taps it.
/// It opens up a browser window in the default browser of the device and
/// navigates to the specified UserID on Buy me a coffee.
class BuyMeACoffeeButton extends StatelessWidget {
  /// Constructor of the BuyMeACoffee Widget
  const BuyMeACoffeeButton({
    super.key,
    String this.sponsorID = 'ska2519',
    String this.customText = 'Support Face Reading Opportunity x 10',
    this.textStyle,
    this.backgroundColor,
    this.theme,
    this.padding,
    this.isNewTab = true,
    this.shopID,
  }) : _isIconOnly = false;

  const BuyMeACoffeeButton.iconOnly({
    super.key,
    required this.sponsorID,
    this.backgroundColor,
    this.theme,
    this.padding,
    this.shopID,
    this.isNewTab = true,
  })  : _isIconOnly = false,
        customText = null,
        textStyle = null;

  final bool _isIconOnly;

  final EdgeInsets? padding;

  /// The id for the user where it should link to.
  final String sponsorID;
  final String? shopID;

  /// Custom text for the widget
  final String? customText;

  /// Overwrites the textStyle of the widget
  final TextStyle? textStyle;

  /// Color of the background if none is provided the [theme] background
  /// will be used or the fallback
  final Color? backgroundColor;

  /// The theme of the widget, it changes the appearence of the Button
  ///
  /// There are multiple themes provided
  /// - [OrangeTheme]
  /// - [YellowTheme]
  /// - [BlackTheme]
  /// - [BlueTheme]
  /// - [PurpleTheme]
  /// - [WhiteTheme]
  ///
  /// Find more [BuyMeACoffeeThemeData]
  final BuyMeACoffeeThemeData? theme;

  final bool isNewTab;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var backgroundColor = this.backgroundColor;
    final textStyle = this.textStyle;
    final customText = this.customText;
    if (theme == null && backgroundColor == null) {
      backgroundColor = const Color(0xFFFF813F);
    } else {
      backgroundColor = theme!.backgroundColor;
    }
    final iconWidget = SvgPicture.network(
      "https://cdn.buymeacoffee.com/buttons/bmc-new-btn-logo.svg",
      width: 35.0,
    );
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () async {
        final uri = Uri.parse(
          buyMeACoffeeUrl + sponsorID + (shopID != null ? "/e/$shopID" : ""),
        );

        await launchUrl(
          uri,
          webOnlyWindowName: isNewTab ? '_blank' : '_self',
        );
        if (kReleaseMode) analytics.logEvent(name: 'click_buymeacoffee_button');
      },
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(vertical: 4),
        decoration: const BoxDecoration(),
        child: _isIconOnly || customText == null || customText.isEmpty
            ? iconWidget
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconWidget,
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        customText,
                        textAlign: TextAlign.center,
                        style: textStyle ??
                            textTheme.bodyMedium!.copyWith(
                              // fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      // ),
    );
  }
}
