import 'package:flutter/material.dart';
import 'package:fortune/src/features/seo/widgets/app_link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/flutter_gen/assets.gen.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          // gapH64,
          // const AppLogo(),
          // gapH8,
          // Text(
          //   'Copyright Fruitshop All Rights Reserved.',
          //   style: textTheme.labelMedium!.copyWith(
          //     color: theme.hintColor,
          //   ),
          // ),
          // gapH40,

          const FooterLinks(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class FooterLinks extends StatelessWidget {
  const FooterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    return Wrap(
      runSpacing: 4,
      spacing: 4,
      children: [
        AppLink(
          anchor: 'Fruitshop',
          href: 'https://fruitshop.app',
          child: FooterLink(
            child: Assets.icons.furitshopAppIcon.image(width: 24, height: 24),
            onPressed: () => launchUrl(
              Uri.parse('https://fruitshop.app'),
            ),
          ),
        ),
        ContactEmail(),
        // FooterLink(text: 'Twitter'),
        // SizedBox(width: 32),
        // FooterLink(text: 'Slack'),
        // SizedBox(width: 32),
        GitHub(),
        // SizedBox(width: 32),
        // FooterLink(text: 'RSS'),
        // SizedBox(width: 32),
        // FooterLink(text: 'Meta'),
      ],
    );
  }
}

class GitHub extends StatelessWidget {
  const GitHub({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLink(
      anchor: 'GitHub',
      href: 'https://github.com/ska2519',
      child: FooterLink(
        text: 'GitHub',
        onPressed: () => launchUrl(
          Uri.parse('https://github.com/ska2519'),
        ),
      ),
    );
  }
}

class ContactEmail extends StatelessWidget {
  const ContactEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLink(
      anchor: 'Contact Email',
      href: 'mailto:ska2519@gamil.com',
      child: FooterLink(
        text: 'Contact Email',
        onPressed: () => launchUrl(
          Uri(
            scheme: 'mailto',
            path: 'ska2519@gamil.com',
          ),
        ),
      ),
    );
  }
}

class FooterLink extends StatelessWidget {
  const FooterLink({super.key, this.text, this.onPressed, this.child});
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(8),
      ),
      child: child != null
          ? child!
          : Text(
              text ?? '',
              style: textTheme.labelMedium!.copyWith(
                color: Theme.of(context).hintColor,
              ),
            ),
    );
  }
}
