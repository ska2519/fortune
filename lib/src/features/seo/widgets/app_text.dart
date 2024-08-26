import 'package:flutter/material.dart';
import 'package:seo/seo.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextTagStyle? tagStyle;

  final TextStyle? style;
  
  final TextAlign? textAlign;

  const AppText(
    this.text, {
    this.style,
    this.tagStyle,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Seo.text(
      text: text,
      style: tagStyle ?? TextTagStyle.p,
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}
