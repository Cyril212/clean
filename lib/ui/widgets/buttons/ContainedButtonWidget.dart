import 'package:clean/core/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:tch_common_widgets/tch_common_widgets.dart';

class ContainedButtonWidget extends StatelessWidget {
  final CommonButtonStyle? style;
  final String text;
  final String? prefixIconSvgAssetPath;
  final Widget? prefixIcon;
  final GestureTapCallback? onTap;
  final bool? isLoading;
  final bool widthWrapContent;
  final List<String> loadingTags;

  /// ButtonWidget initialization
  ContainedButtonWidget({
    this.style,
    required this.text,
    this.prefixIconSvgAssetPath,
    this.prefixIcon,
    this.onTap,
    this.isLoading,
    this.widthWrapContent = false,
    String? tag,
    List<String>? tags,
  }) : loadingTags = [
          if (tag != null) tag,
          if (tags != null) ...tags,
        ];

  @override
  Widget build(BuildContext context) {
    var _style = style ?? kFilledButtonsStyle;
    return ButtonWidget(
      text: text,
      prefixIconSvgAssetPath: prefixIconSvgAssetPath,
      prefixIcon: prefixIcon,
      onTap: onTap,
      style: _style.copyWith(widthWrapContent: widthWrapContent),
      isLoading: isLoading,
      tags: loadingTags,
    );
  }
}
