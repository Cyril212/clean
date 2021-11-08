import 'package:clean/core/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:tch_common_widgets/tch_common_widgets.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final CommonButtonStyle? style;
  final String text;
  final String? prefixIconSvgAssetPath;
  final Widget? prefixIcon;
  final GestureTapCallback? onTap;
  final bool? isLoading;
  final List<String> loadingTags;

  /// ButtonWidget initialization
  OutlinedButtonWidget({
    this.style,
    required this.text,
    this.prefixIconSvgAssetPath,
    this.prefixIcon,
    this.onTap,
    this.isLoading,
    String? tag,
    List<String>? tags,
  }) : loadingTags = [
          if (tag != null) tag,
          if (tags != null) ...tags,
        ];

  @override
  Widget build(BuildContext context) {
    final _style = style ?? kOutlinedButtonsStyle;
    return ButtonWidget(
      text: text,
      prefixIconSvgAssetPath: prefixIconSvgAssetPath,
      prefixIcon: prefixIcon,
      onTap: onTap,
      style: _style,
      isLoading: isLoading,
      tags: loadingTags,
    );
  }
}
