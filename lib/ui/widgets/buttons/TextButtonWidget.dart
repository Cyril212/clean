import 'package:clean/core/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:tch_common_widgets/tch_common_widgets.dart';

enum TextButtonVariant { standard, underline }

class TextButtonWidget extends StatelessWidget {
  final CommonButtonStyle? style;
  final String text;
  final GestureTapCallback? onTap;
  final TextButtonVariant variant;

  /// ButtonWidget initialization
  TextButtonWidget({
    this.style,
    required this.text,
    this.onTap,
    this.variant = TextButtonVariant.standard,
  });

  @override
  Widget build(BuildContext context) {
    CommonButtonStyle _style = style ?? (variant == TextButtonVariant.standard ? kTextButtonStyle : kUnderlineTextButtonStyle);

    return ButtonWidget(
      isLoading: false,
      text: text,
      onTap: onTap,
      style: _style,
    );
  }
}
