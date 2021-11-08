import 'package:clean/core/AppTheme.dart';
import 'package:clean/model/dataTask/ForgotPasswordDataTask.dart';
import 'package:clean/model/request/ForgotPasswordRequest.dart';
import 'package:clean/ui/widgets/appbars/SecondaryAppBar.dart';
import 'package:clean/ui/widgets/buttons/ContainedButtonWidget.dart';
import 'package:clean/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';
import 'package:tch_common_widgets/tch_common_widgets.dart';

import '../AppScreenState.dart';

class ForgotPasswordScreen extends AppScreen {
  static const ROUTE = '/forgot_password';

  @override
  State<AppScreen> createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends AppScreenState<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  final FocusScopeNode buttonFocusNode = FocusScopeNode();


  @override
  void dispose() {
    emailFocusNode.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  AbstractScreenStateOptions get options => AbstractScreenStateOptions.basic(screenName: 'Zapomenuté heslo', title: 'Zapomenuté heslo');

  @override
  PreferredSizeWidget? createAppBar(BuildContext context) {
    return SecondaryAppBar(title: options.screenName);
  }

  @override
  Widget buildContent(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: kContentLargeHorizontalPadding,
        child: Column(
          children: [
            Form(
              key: formKey,
              child: TextFormFieldWidget(
                style: kEmailTextFormFieldStyle,
                controller: emailController,
                focusNode: emailFocusNode,
                autofocus: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (String string) => FocusScope.of(context).unfocus(),
              ),
            ),
            SizedBox(height: 18),
            Text(
              'Zadejte váš email a my vám na něj pošleme nové heslo.',
              textAlign: TextAlign.center,
              style: kText,
            ),
            SizedBox(height: 36),
            ContainedButtonWidget(
                isLoading: isLoading.value,
                text: 'Obnovit heslo',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    executeAsyncTask(() =>
                        MainDataProvider.instance!.executeDataTask(ForgotPasswordDataTask(data: ForgotPasswordRequest(emailController.text))).then((task) => {
                              if (task.result != null)
                                {popNotDisposed(context, mounted, true)}
                              else
                                {Utils.showDefaultError(context, task.error!.httpStatusCode!)}
                            }));
                  }
                })
          ],
        ),
      ),
    );
  }
}
