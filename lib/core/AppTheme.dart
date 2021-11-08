import 'package:flutter_svg/flutter_svg.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';
import 'package:tch_common_widgets/tch_common_widgets.dart';

const kColorPrimary = kColorBlue;
const kColorSecondary = Colors.black;
const kColorShadow = const Color(0x50000000);

const kColorTextPrimary = Colors.black;
const kColorTextSecondary = Colors.white;

const kColorBlue = const Color(0xFF1DADFF);
const kColorGrey = const Color(0xFFDEE4EE);
const kColorRed = const Color(0xFFFF4504);
const kColorOrange = const Color(0xFFE27E35);
const kColorGreen = const Color(0xFF1eaf47);

const kFontFamilyRegular = 'Open Sans Regular';
const kFontFamilySemiBold = 'Open Sans SemiBold';
const kFontFamilySemiBoldItalic = 'Open Sans SemiBold Italic';
const kFontFamilyBold = 'Open Sans Bold';
const kFontFamilyBoldItalic = 'Open Sans Bold Italic';
const kFontFamilyExtraBold = 'Open Sans Extra Bold';
const kFontFamilyExtraBoldItalic = 'Open Sans Extra Bold Italic';
const kFontFamilyItalic = 'Open Sans Italic';
const kFontFamilyLight = 'Open Sans Light';
const kFontFamilyLightItalic = 'Open Sans Light Italic';
const kFontFamilyIterRegular = 'Inter';

const kText = const TextStyle(color: kColorTextPrimary, fontSize: 12, fontFamily: kFontFamilyRegular);
const kTextHeadline = const TextStyle(color: kColorTextPrimary, fontSize: 14, fontFamily: kFontFamilySemiBold);
const kTextButtonPrimary = const TextStyle(color: Colors.white, fontSize: 14, fontFamily: kFontFamilySemiBold);
const kTextButtonSecondary = const TextStyle(color: kColorPrimary, fontSize: 14, fontFamily: kFontFamilySemiBold);
const kTextTextField = const TextStyle(color: Colors.black, fontSize: 14, fontFamily: kFontFamilyRegular);

final kFilledButtonsStyle = CommonButtonStyle(
  borderRadius: BorderRadius.all(Radius.circular(6)),
  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
  color: kColorPrimary,
  iconColor: kColorTextSecondary,
  disabledColor: kColorPrimary.withOpacity(0.5),
  disabledIconColor: kColorTextSecondary,
  height: 46,
  variant: ButtonVariant.Filled,
  preffixIconHeight: 18,
  loadingIconHeight: 24,
  filledTextStyle: TextStyle(fontSize: 15, color: kColorTextSecondary, fontWeight: FontWeight.w600),
  textStyle: TextStyle(fontSize: 15, color: kColorPrimary, fontWeight: FontWeight.w600),
  disabledTextStyle: TextStyle(fontSize: 15, color: kColorTextSecondary, fontWeight: FontWeight.w600),
  loadingIcon: SvgPicture.asset('assets/icons/ios_spinner.svg', color: kColorTextSecondary),
);

final kOutlinedButtonsStyle = kFilledButtonsStyle.copyWith(
    variant: ButtonVariant.Outlined,
    iconColor: kColorPrimary,
    disabledTextStyle: TextStyle(fontSize: 15, color: kColorPrimary.withOpacity(0.5), fontWeight: FontWeight.w600),
    loadingIcon: SvgPicture.asset('assets/icons/ios_spinner.svg', color: kColorPrimary));

final kTextButtonStyle = CommonButtonStyle(
  borderRadius: BorderRadius.all(Radius.zero),
  contentPadding: const EdgeInsets.symmetric(horizontal: kCommonHorizontalMargin),
  widthWrapContent: true,
  color: kColorTextSecondary,
  height: 46,
  variant: ButtonVariant.TextOnly,
  textStyle: TextStyle(fontSize: 14, color: kColorTextPrimary),
);

final kUnderlineTextButtonStyle = kTextButtonStyle.copyWith(
  textStyle: TextStyle(fontSize: 14, color: kColorTextPrimary, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
);

const kAppBarIconButtonStyle = const IconButtonStyle(variant: IconButtonVariant.IconOnly, color: kColorTextPrimary);

const kParallaxAppBarIconButtonStyle = const IconButtonStyle(
  variant: IconButtonVariant.Filled,
  iconColor: kColorSecondary,
  color: const Color(0xFFFFFFFF),
  borderRadius: BorderRadius.all(Radius.circular(36)),
  boxShadow: [
    BoxShadow(
      color: const Color(0x1A000000),
      spreadRadius: 1,
      blurRadius: 3,
      offset: Offset(0, 1), // changes position of shadow
    ),
  ],
  height: 36,
  width: 36,
  canBeStretched: true,
  iconWidth: 20,
  iconHeight: 20,
);

final kInputDecoration = TextFormFieldStyle().inputDecoration.copyWith(
  isDense: false,
  hintStyle: TextStyle(fontSize: 14, height: 1.42, color: kColorTextPrimary.withOpacity(0.5)),
  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
  errorStyle: TextStyle(fontSize: 11, height: 1.42, fontFamily: kFontFamilySemiBold, color: kColorRed) ,
  contentPadding: const EdgeInsets.symmetric(
    vertical: 16,
  ),
);

final kTextFormFieldStyle = TextFormFieldStyle(
  focusedBorderColor: kColorPrimary,
  iOSUseNativeTextField: true,
  borderColor: const Color(0x95AAB9D1),
  errorColor: kColorRed,
  inputStyle: TextStyle(fontSize: 14, height: 1.42, color: kColorTextPrimary),
  inputDecoration: kInputDecoration,
  fillColorDisabled: Colors.transparent
);

final kEmailTextFormFieldStyle = kTextFormFieldStyle.copyWith(
  inputDecoration: kInputDecoration.copyWith(
    hintText: 'Email',
    prefixIcon: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/icon_email.svg',
          color: kColorSecondary.withOpacity(0.6),
          height: 20,
        ),
      ],
    ),
  ),
  validations: [
    FormFieldValidation(validator: validateRequired, errorText: 'Invalid email address'),
    FormFieldValidation(validator: validateEmail, errorText: 'Invalid email address')
  ],
  keyboardType: TextInputType.emailAddress,
);

final kPasswordTextFormFieldStyle = kTextFormFieldStyle.copyWith(
  obscureText: true,
  inputDecoration: kInputDecoration.copyWith(
    hintText: 'Heslo',
    prefixIcon: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/icon_password.svg',
          color: kColorSecondary.withOpacity(0.6),
          height: 20,
        ),
      ],
    ),
  ),
  validations: [
    FormFieldValidation(validator: validateRequired, errorText: 'Password field is mandatory'),
  ],
);

const kCardHeight = 58.0;
const kButtonHeight = 46.0;
const kContentLargeHorizontalPadding = const EdgeInsets.symmetric(horizontal: 38);
const kContentHorizontalPadding = const EdgeInsets.symmetric(horizontal: 24);
const kJobDetailContentHorizontalPadding = const EdgeInsets.symmetric(horizontal: 30);

final kCardBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(
    Radius.circular(6),
  ),
  border: Border.all(color: Color(0xffDEE4EE)),
  boxShadow: [BoxShadow(blurRadius: 3, spreadRadius: 1, color: Color(0xff000000).withOpacity(0.05))],
  color: Colors.white,
);

final kCompleteCardBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(
    Radius.circular(6),
  ),
  boxShadow: [BoxShadow(blurRadius: 3, spreadRadius: 1, color: Color(0xff000000).withOpacity(0.05))],
  color: Color(0xffF1F3F8),
);

/// Customize CommonTheme for the app
Widget appThemeBuilder(BuildContext context, Widget child) {
  return CommonTheme(
    child: child,
    fontFamily: kFontFamilyRegular,
    formStyle: FormStyle(
      textFormFieldStyle: kTextFormFieldStyle,
    ),
  );
}
