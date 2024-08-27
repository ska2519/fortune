import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fortune/generated/flutter_gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';
import '../../constants/app_sizes.dart';
import '../seo/widgets/app_link.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          gapH8,
          Row(
            children: [
              Fruitshop(),
              gapW8,
              Text(
                'Copyright © 2021 fruitshop',
                textAlign: TextAlign.center,
                style: textTheme.labelMedium!.copyWith(),
              ),
            ],
          ),
          gapH16,
          const FooterLinks(),
          gapH48,
        ],
      ),
    );
  }
}

class FooterLinks extends StatelessWidget {
  const FooterLinks({super.key});

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: const Wrap(
        runSpacing: 16,
        spacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ContactEmail(),
          GitHub(),
          LinkedIn(),
          KakaoOpenChat(),
        ],
      ),
    );
  }
}

class Fruitshop extends StatelessWidget {
  const Fruitshop({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLink(
      anchor: 'fruitshop',
      href: 'https://fruitshop.app',
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          launchUrl(
            Uri.parse('https://fruitshop.app'),
          );
          if (kReleaseMode)
            analytics.logEvent(name: 'Click fruitshop.app footer link');
        },
        child: Assets.icons.furitshopAppIcon.image(height: 24),
      ),
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
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          launchUrl(
            Uri.parse('https://github.com/ska2519'),
          );
          if (kReleaseMode)
            analytics.logEvent(name: 'Click Github footer link');
        },
        child: Assets.icons.githubMark.svg(height: 24),
      ),
    );
  }
}

class KakaoOpenChat extends StatelessWidget {
  const KakaoOpenChat({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLink(
      anchor: 'KakaoTalk Open Chat',
      href: 'https://open.kakao.com/o/sapBuEKg',
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          launchUrl(
            Uri.parse('https://open.kakao.com/o/sapBuEKg'),
          );
          if (kReleaseMode)
            analytics.logEvent(name: 'Click KakaoTalk Open Chat footer link');
        },
        child: Assets.icons.kakao.svg(height: 32),
      ),
    );
  }
}

class LinkedIn extends StatelessWidget {
  const LinkedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLink(
      anchor: 'Linked in Profile',
      href: 'https://www.linkedin.com/in/ska2519',
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          launchUrl(
            Uri.parse('https://www.linkedin.com/in/ska2519'),
          );
          if (kReleaseMode)
            analytics.logEvent(name: 'Click Linked in Profile footer link');
        },
        child: Assets.icons.iconLinkedin.svg(height: 24),
      ),
    );
  }
}

class ContactEmail extends StatelessWidget {
  const ContactEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLink(
      anchor: 'Contact email',
      href: 'mailto:ska2519@gamil.com',
      child: FooterLink(
        text: 'Contact @',
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
  const FooterLink({super.key, required this.text, this.onPressed});
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(8),
      ),
      child: Text(
        text,
        style: textTheme.labelMedium!.copyWith(
            // color: Theme.of(context).hintColor,
            ),
      ),
    );
  }
}
