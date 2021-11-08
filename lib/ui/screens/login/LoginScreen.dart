import 'package:clean/core/AppTheme.dart';
import 'package:clean/ui/screens/dashboard/DashboardScreen.dart';
import 'package:clean/ui/screens/forgotPassword/ForgotPasswordScreen.dart';
import 'package:clean/ui/widgets/buttons/ContainedButtonWidget.dart';
import 'package:clean/ui/widgets/buttons/TextButtonWidget.dart';
import 'package:clean/ui/widgets/dialogs/DialogWidget.dart';
import 'package:clean/utils/Utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';
import 'package:tch_common_widgets/tch_common_widgets.dart';

import '../../../App.dart';
import '../AppScreenState.dart';

class LoginScreen extends AppScreen {
  static const String ROUTE = '/login';

  @override
  State<AppScreen> createState() => LoginScreenState();
}

class LoginScreenState extends AppScreenState<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      //TODO prefilled values to speed up development
      emailController.text = 'test@test.com';
      passwordController.text = 'asdf';
      //TODO comment out
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  firstBuildOnly(BuildContext context) {
    executeAsyncTask(() async {
      AppDataState.of<AppDataStateSnapshot>(context)!.loginManagerModule.autologin(context).then((result) {
        if (result == null) {
          // do nothing since user hasn't logged in yet
          return;
        } else if (result.result != null) {
          pushNamedNewStack(context, DashboardScreen.ROUTE);
        } else {
          _resolveError(context, result.error?.httpStatusCode);
        }
      });
    });

    super.firstBuildOnly(context);
  }

  @override
  AbstractScreenStateOptions get options => AbstractScreenStateOptions.basic(screenName: 'LoginScreen', title: 'Login');

  @override
  PreferredSizeWidget? createAppBar(BuildContext context) {}

  _resolveError(BuildContext context, int? httpStatusCode) {
    String _title = 'Špatné přihlašovací údaje';
    String _description = 'Zadali jste nesprávný email nebo heslo.';

    if (httpStatusCode == 401) {

    } else if (httpStatusCode == 500) {
      String _title = 'Chyba';
      String _description = 'Něco se pokazilo\n Prosím zkuste to znovu';
    }
    //TODO no internet connection error message
    // else if (loginTask.error?.originalException == 7) {
    //   _description = 'Please check your internet connection!';
    // }

    showDialog(
      context: context,
      builder: (context) => DialogWidget(
        title: _title,
        description: _description,
      ),
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: kContentLargeHorizontalPadding,
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/clean.svg',
              color: kColorSecondary,
              height: 30,
            ),
            SizedBox(height: 40),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormFieldWidget(
                    style: kEmailTextFormFieldStyle,
                    controller: emailController,
                    focusNode: emailFocusNode,
                    nextFocus: passwordFocusNode,
                  ),
                  SizedBox(height: 18),
                  TextFormFieldWidget(
                    style: kPasswordTextFormFieldStyle,
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    onFieldSubmitted: (String string) => FocusScope.of(context).unfocus(),
                  ),
                  SizedBox(height: 7),
                  TextButtonWidget(
                    text: 'Zapoměli jste heslo?',
                    variant: TextButtonVariant.underline,
                    onTap: () {
                      pushNamed(context, ForgotPasswordScreen.ROUTE).then((value) {
                        if (value == true) {
                          showDialog(
                            context: context,
                            builder: (context) => DialogWidget(
                              title: 'Odesláno',
                              description: 'Na email jsme vám poslali nové heslo.',
                            ),
                          );
                        }
                      });
                    },
                  ),
                  SizedBox(height: 7),
                  ContainedButtonWidget(
                      isLoading: isLoading.value,
                      text: 'Přihlásit se',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          executeAsyncTask(() => AppDataState.of<AppDataStateSnapshot>(context)!
                                  .loginManagerModule
                                  .login(context, emailController.text, passwordController.text)
                                  .then((loginTask) {
                                if (loginTask.result != null) {
                                  pushNamedNewStack(context, DashboardScreen.ROUTE);
                                } else {
                                  _resolveError(context, loginTask.error?.httpStatusCode);
                                }
                              }));
                        }
                      }),
                  SizedBox(height: 38),
                  TextButtonWidget(
                      text: 'Ochrana osobních údajů',
                      onTap: () {
                        Utils.navigateToUrl('http://clean.xyz/');
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
