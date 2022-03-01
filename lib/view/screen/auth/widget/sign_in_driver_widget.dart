import 'package:activa_efectiva_bus/data/enums/roles.dart';
import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:activa_efectiva_bus/provider/auth_provider.dart';
import 'package:activa_efectiva_bus/provider/driver_provider.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/provider/route_provider.dart';
import 'package:activa_efectiva_bus/utill/utils.dart';
import 'package:activa_efectiva_bus/view/screen/auth/forget_pin_screen.dart';
import 'package:activa_efectiva_bus/view/screen/dashboard/dashboard_screen.dart';
import 'package:activa_efectiva_bus/view/screen/setup/setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/data/model/body/register_model.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/view/basewidget/button/custom_button.dart';
import 'package:activa_efectiva_bus/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class SignInDriverWidget extends StatefulWidget {
  @override
  _SignInDriverWidgetState createState() => _SignInDriverWidgetState();
}

class _SignInDriverWidgetState extends State<SignInDriverWidget> {
  TextEditingController _pinController;
  GlobalKey<FormState> _formKey;

  FocusNode _pinFocus = FocusNode();

  RegisterModel register = RegisterModel();
  bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _pinController = TextEditingController();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  String getFormErrors(String pin) {
    if (pin.isEmpty || !isNumeric(pin) || pin.length > 4) {
      return getTranslated('PIN_MUST_BE_REQUIRED', context);
    }

    return "";
  }

  // Driver can only access if:
  // * Belongs to same operator of last transport unit used.
  // * Is assigned as driver of last transport unit used.
  void loginDriver() async {
    FocusScope.of(context).unfocus(); //To hide keyboard
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      var formErrors = getFormErrors(_pinController.text);

      if (formErrors.isEmpty) {
        EasyLoading.show(status: getTranslated('PLEASE_WAIT', context));
        // Look for latest bus ID selected
        String busID = Provider.of<PartnerProvider>(context, listen: false)
            .getSelectedBusID();
        // Look for latest operator ID selected
        String operatorID = Provider.of<PartnerProvider>(context, listen: false)
            .getSelectedOperatorID();
        Provider.of<DriverProvider>(context, listen: false)
            .getDriverInformation(busID, operatorID, _pinController.text)
            .then((value) async {
          Provider.of<AuthProvider>(context, listen: false)
              .setCurrentUserRole(UserRole.DRIVER);
          await Provider.of<RouteProvider>(context, listen: false)
              .getOperatorRoutes(operatorID);
          EasyLoading.dismiss();
          // Redirects directly to dashboard
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => DashBoardScreen()));
        }).catchError((Object error) {
          _pinController.clear();
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
    return ListView(
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              // for password
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_LARGE,
                    right: Dimensions.MARGIN_SIZE_LARGE,
                    bottom: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomPasswordTextField(
                  hintTxt: getTranslated('DRIVER_PIN', context),
                  controller: _pinController,
                  focusNode: _pinFocus,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.MARGIN_SIZE_DEFAULT,
              right: Dimensions.MARGIN_SIZE_DEFAULT,
              top: Dimensions.MARGIN_SIZE_DEFAULT),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ForgetPinScreen())),
                child: Text(getTranslated('FORGET_PIN', context),
                    style: robotoRegular.copyWith(
                        color: ColorResources.getLightSkyBlue(context))),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
          child: CustomButton(
              onTap: loginDriver,
              buttonText: getTranslated('SIGN_IN', context)),
        ),
      ],
    );
  }
}
