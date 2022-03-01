import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:activa_efectiva_bus/provider/driver_provider.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/utill/utils.dart';
import 'package:activa_efectiva_bus/view/basewidget/custom_app_bar.dart';
import 'package:activa_efectiva_bus/view/screen/driver_auth/widget/opt_widget.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/helper/network_info.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class DriverAuthScreen extends StatefulWidget {
  final bool redirect;

  const DriverAuthScreen({this.redirect = true});
  @override
  _DriverAuthScreenState createState() => _DriverAuthScreenState();
}

class _DriverAuthScreenState extends State<DriverAuthScreen> {
  String text = '';

  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
      if (text.length == 4) {
        EasyLoading.show(status: getTranslated('PLEASE_WAIT', context));
        PartnerInformationResponse partnerInfo =
            Provider.of<PartnerProvider>(context, listen: false)
                .selectedPartnerInformation;

        Provider.of<DriverProvider>(context, listen: false)
            .getDriverInformation(
                partnerInfo.bus.id, partnerInfo.bus.operator.id, text)
            .then((value) {
          EasyLoading.dismiss();
          Navigator.of(context).pop();
        }).catchError((Object error) {
           setState(() {
            text = "";
          });
          Utils.showErrorMessage(context, error);
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          CustomAppBar(
              title: getTranslated('DRIVER_CHANGE', context),
              isBackButtonExist: true),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0))),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.security,
                              size: 50,
                              color: ColorResources.getPrimary(context),
                            ),
                            title: Text(
                              'Autorización de conductor',
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              'Ingrese su PIN de autenticación.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                          thickness: 2, color: ColorResources.getChatIcon(context)),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_LARGE,
                      ),
                      Column(
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                otpNumberWidget(0),
                                otpNumberWidget(1),
                                otpNumberWidget(2),
                                otpNumberWidget(3),
                              ],
                            ),
                          ),
                          NumericKeyboard(
                            onKeyboardTap: _onKeyboardTap,
                            textColor: ColorResources.BLACK,
                            rightIcon: Icon(
                              Icons.backspace,
                              color: ColorResources.BLACK,
                            ),
                            rightButtonFn: () {
                              setState(() {
                                text = text.substring(0, text.length - 1);
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 73,
        width: 64,
        decoration: BoxDecoration(
            color: ColorResources.getFloatingBtn(context),
            border: Border.all(color: ColorResources.LIGHT_SKY_BLUE, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
          text[position],
          style: TextStyle(color: Colors.white, fontSize: 22),
        )),
      );
    } catch (e) {
      return Container(
        height: 73,
        width: 64,
        decoration: BoxDecoration(
            color: ColorResources.GAINS_BORO,
            border: Border.all(color: ColorResources.GAINS_BORO, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      );
    }
  }
}
