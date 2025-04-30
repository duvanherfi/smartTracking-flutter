import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:smart_tracking/utils/build_context.extension.dart';

class PiHtmlText extends StatelessWidget {
  final Color? mayusColor;
  final Color? textColor;
  final String content;
  final double? fontSize;
  final double? fontSizeMayus;
  final TextAlign? textAlign;
  final int? maxLines;
  final HtmlPaddings? padding;
  final Margins? margin;
  final String? fontFamily;
  final String? mayusFontFamily;
  final bool overrideNativeStyles;
  final void Function(String)? onLinkTap;

  const PiHtmlText({
    required this.content,
    this.mayusColor,
    this.textColor,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.padding,
    this.margin,
    this.fontSizeMayus,
    this.fontFamily,
    this.mayusFontFamily,
    this.overrideNativeStyles = false,
    this.onLinkTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Html(
        data: content,
        onLinkTap: (url, __, ___) {
          if (url?.isNotEmpty ?? false) {
            onLinkTap?.call(url!);
          }
        },
        style: overrideNativeStyles
            ? {
                '*': Style(
                  textAlign: textAlign,
                  color: textColor ?? context.currentTheme.primary,
                  fontSize: FontSize(fontSize ?? 16),
                  fontWeight: FontWeight.w500,
                  textDecoration: TextDecoration.none,
                  padding: padding,
                  margin: margin,
                  maxLines: maxLines,
                  textOverflow: TextOverflow.ellipsis,
                ),
                'b': Style(
                  textAlign: textAlign,
                  color: mayusColor ?? context.currentTheme.primary,
                  fontSize: FontSize(fontSizeMayus ?? fontSize ?? 16),
                  fontWeight: FontWeight.w800,
                  textDecoration: TextDecoration.none,
                  margin: margin,
                  padding: padding,
                  maxLines: maxLines,
                  textOverflow: TextOverflow.ellipsis,
                ),
              }
            : {},
      );
}
