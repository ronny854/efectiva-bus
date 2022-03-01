import 'package:activa_efectiva_bus/api/exceptions/network_exceptions.dart';
import 'package:activa_efectiva_bus/data/enums/roles.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/utill/utils.dart';
import 'package:activa_efectiva_bus/view/screen/setup/setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/data/model/body/login_model.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/provider/auth_provider.dart';
import 'package:activa_efectiva_bus/provider/profile_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/view/basewidget/button/custom_button.dart';
import 'package:activa_efectiva_bus/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:activa_efectiva_bus/view/basewidget/textfield/custom_textfield.dart';
import 'package:activa_efectiva_bus/view/screen/auth/forget_password_screen.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignInPartnerWidget extends StatefulWidget {
  @override
  _SignInPartnerWidgetState createState() => _SignInPartnerWidgetState();
}

class _SignInPartnerWidgetState extends State<SignInPartnerWidget> {
  GlobalKey<FormState> _formKeyLogin;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();
  LoginModel loginBody = LoginModel();

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.text =
        Provider.of<AuthProvider>(context, listen: false).getUserEmail() ??
            null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String getFormErrors(String email, String password) {
    if (email.isEmpty || !isEmail(email)) {
      return getTranslated('EMAIL_MUST_BE_REQUIRED', context);
    } else if (password.isEmpty) {
      return getTranslated('PASSWORD_MUST_BE_REQUIRED', context);
    }

    return "";
  }

  void loginPartner() async {
    FocusScope.of(context).unfocus(); //To hide keyboard
    if (_formKeyLogin.currentState.validate()) {
      _formKeyLogin.currentState.save();

      var formErrors =
          getFormErrors(_emailController.text, _passwordController.text);

      if (formErrors.isEmpty) {
        await EasyLoading.show(status: getTranslated('PLEASE_WAIT', context));

        loginBody.email = _emailController.text;
        loginBody.password = _passwordController.text;

        Provider.of<AuthProvider>(context, listen: false)
            .login(loginBody)
            .then((rs) async {
          await Provider.of<ProfileProvider>(context, listen: false)
              .savePartnerProfile(rs.userData);
          Provider.of<PartnerProvider>(context, listen: false)
              .getPartnerInformation(rs.userData.uid)
              .then((value) async {
            Provider.of<AuthProvider>(context, listen: false)
                .setCurrentUserRole(UserRole.PARTNER);
            await Provider.of<PartnerProvider>(context, listen: false)
                .saveSelectedPartnerID(rs.userData.uid);
            EasyLoading.dismiss();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SetupScreen(
                      greet: getTranslated('WELCOME', context),
                      instruction: getTranslated(
                          'SELECT_TRANSPORT_INSTRUCTION', context),
                      buttonText: getTranslated('SKIP_SETUP', context),
                      showWarning: true,
                    )));
          }).catchError((Object error) {
            _passwordController.clear();
            Utils.showErrorMessage(context, error);
          });
        }).catchError((Object error) {
          _passwordController.clear();
          Utils.showErrorMessage(context, error);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(milliseconds: 800),
          content: Text(
            formErrors,
            style: TextStyle(color: ColorResources.WHITE),
          ),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyLogin,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
        children: [
          // for Email
          Container(
              margin: EdgeInsets.only(
                  left: Dimensions.MARGIN_SIZE_LARGE,
                  right: Dimensions.MARGIN_SIZE_LARGE,
                  bottom: Dimensions.MARGIN_SIZE_SMALL),
              child: CustomTextField(
                hintText: getTranslated('ENTER_YOUR_EMAIL', context),
                focusNode: _emailNode,
                nextNode: _passNode,
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
              )),

          // for Password
          Container(
              margin: EdgeInsets.only(
                  left: Dimensions.MARGIN_SIZE_LARGE,
                  right: Dimensions.MARGIN_SIZE_LARGE,
                  bottom: Dimensions.MARGIN_SIZE_DEFAULT),
              child: CustomPasswordTextField(
                hintTxt: getTranslated('ENTER_YOUR_PASSWORD', context),
                textInputAction: TextInputAction.done,
                focusNode: _passNode,
                controller: _passwordController,
                textInputType: TextInputType.text,
              )),
          Container(
            margin: EdgeInsets.only(
                left: Dimensions.MARGIN_SIZE_LARGE,
                right: Dimensions.MARGIN_SIZE_LARGE,
                bottom: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ForgetPasswordScreen())),
                  child: Text(getTranslated('FORGET_PASSWORD', context),
                      style: robotoRegular.copyWith(
                          color: ColorResources.getLightSkyBlue(context))),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
            child: CustomButton(
                onTap: loginPartner,
                buttonText: getTranslated('SIGN_IN', context)),
          ),
        ],
      ),
    );
  }
}
