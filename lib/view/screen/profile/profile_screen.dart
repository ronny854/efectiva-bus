import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/helper/network_info.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/provider/profile_provider.dart';
import 'package:activa_efectiva_bus/provider/theme_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/utill/images.dart';
import 'package:activa_efectiva_bus/view/basewidget/button/custom_button.dart';
import 'package:activa_efectiva_bus/view/basewidget/textfield/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FocusNode _fNameFocus = FocusNode();
  final FocusNode _lNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  File file;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _choose() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _updateUserAccount() async {
    if (Provider.of<ProfileProvider>(context, listen: false).userData.names ==
            _firstNameController.text &&
        Provider.of<ProfileProvider>(context, listen: false)
                .userData
                .lastNames ==
            _lastNameController.text &&
        file == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No hay nueva información para guardar.'),
          backgroundColor: ColorResources.RED));
    } else if ((_passwordController.text.isNotEmpty &&
            _passwordController.text.length < 6) ||
        (_confirmPasswordController.text.isNotEmpty &&
            _confirmPasswordController.text.length < 6)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password should be getter than 6'),
          backgroundColor: ColorResources.RED));
    } else if (_confirmPasswordController.text.isNotEmpty &&
        _passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password does not matched'),
          backgroundColor: ColorResources.RED));
    } else {
      // UserData updateUserInfoModel =
      //     Provider.of<ProfileProvider>(context, listen: false).userData;
      // updateUserInfoModel.method = 'put';
      // updateUserInfoModel.fName = _firstNameController.text ?? "";
      // updateUserInfoModel.lName = _lastNameController.text ?? "";
      // updateUserInfoModel.phone = _phoneController.text ?? '';
      //
      // await Provider.of<ProfileProvider>(context, listen: false)
      //     .updateUserInfo(updateUserInfoModel);
      //Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('¡Datos actualizados!'),
          backgroundColor: ColorResources.GREEN));
      _passwordController.clear();
      _confirmPasswordController.clear();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
     NetworkInfo.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          _firstNameController.text = profile.userData.names;
          _lastNameController.text = profile.userData.lastNames;
          _emailController.text = profile.userData.email;
          //_phoneController.text = profile.userInfoModel.phone;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                Images.toolbar_background,
                fit: BoxFit.fill,
                height: 500,
                color: Provider.of<ThemeProvider>(context).darkTheme
                    ? Colors.black
                    : null,
              ),
              Container(
                padding: EdgeInsets.only(top: 35, left: 15),
                child: Row(children: [
                  CupertinoNavigationBarBackButton(
                    onPressed: () => Navigator.of(context).pop(),
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(getTranslated('PROFILE', context),
                      style: robotoRegular.copyWith(
                          fontSize: 20, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ]),
              ),
              Container(
                padding: EdgeInsets.only(top: 55),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: Dimensions.MARGIN_SIZE_EXTRA_LARGE),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            border: Border.all(color: Colors.white, width: 3),
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: file == null
                                    ? Image.network(
                                        profile.userData.photoURL,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.file(file,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill),
                              ),
                              Positioned(
                                bottom: 0,
                                right: -10,
                                child: CircleAvatar(
                                  backgroundColor:
                                      ColorResources.LIGHT_SKY_BLUE,
                                  radius: 14,
                                  child: IconButton(
                                    onPressed: _choose,
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(Icons.edit,
                                        color: ColorResources.WHITE, size: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          profile.userData.displayName,
                          style: robotoBold.copyWith(
                              color: ColorResources.WHITE, fontSize: 20.0),
                        )
                      ],
                    ),
                    SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorResources.getIconBg(context),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  Dimensions.MARGIN_SIZE_DEFAULT),
                              topRight: Radius.circular(
                                  Dimensions.MARGIN_SIZE_DEFAULT),
                            )),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person,
                                              color: ColorResources
                                                  .getLightSkyBlue(context),
                                              size: 20),
                                          SizedBox(
                                              width: Dimensions
                                                  .MARGIN_SIZE_EXTRA_SMALL),
                                          Text(
                                              getTranslated(
                                                  'FIRST_NAME', context),
                                              style: robotoRegular)
                                        ],
                                      ),
                                      SizedBox(
                                          height: Dimensions.MARGIN_SIZE_SMALL),
                                      CustomTextField(
                                        textInputType: TextInputType.name,
                                        focusNode: _fNameFocus,
                                        nextNode: _lNameFocus,
                                        hintText:
                                            profile.userData.names ?? '',
                                        controller: _firstNameController,
                                      ),
                                    ],
                                  )),
                                  SizedBox(width: 15),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person,
                                              color: ColorResources
                                                  .getLightSkyBlue(context),
                                              size: 20),
                                          SizedBox(
                                              width: Dimensions
                                                  .MARGIN_SIZE_EXTRA_SMALL),
                                          Text(
                                              getTranslated(
                                                  'LAST_NAME', context),
                                              style: robotoRegular)
                                        ],
                                      ),
                                      SizedBox(
                                          height: Dimensions.MARGIN_SIZE_SMALL),
                                      CustomTextField(
                                        textInputType: TextInputType.name,
                                        focusNode: _lNameFocus,
                                        nextNode: _emailFocus,
                                        hintText: profile.userData.lastNames,
                                        controller: _lastNameController,
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ),

                            // for Email
                            Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.MARGIN_SIZE_SMALL,
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.alternate_email,
                                          color: ColorResources.getLightSkyBlue(
                                              context),
                                          size: 20),
                                      SizedBox(
                                        width:
                                            Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                      ),
                                      Text(getTranslated('EMAIL', context),
                                          style: robotoRegular)
                                    ],
                                  ),
                                  SizedBox(
                                      height: Dimensions.MARGIN_SIZE_SMALL),
                                  CustomTextField(
                                    textInputType: TextInputType.emailAddress,
                                    focusNode: _emailFocus,
                                    nextNode: _phoneFocus,
                                    hintText: profile.userData.email ?? '',
                                    controller: _emailController,
                                  ),
                                ],
                              ),
                            ),

                            // for Phone No
                            // Container(
                            //   margin: EdgeInsets.only(
                            //       top: Dimensions.MARGIN_SIZE_SMALL,
                            //       left: Dimensions.MARGIN_SIZE_DEFAULT,
                            //       right: Dimensions.MARGIN_SIZE_DEFAULT),
                            //   child: Column(
                            //     children: [
                            //       Row(
                            //         children: [
                            //           Icon(Icons.dialpad,
                            //               color: ColorResources.getLightSkyBlue(
                            //                   context),
                            //               size: 20),
                            //           SizedBox(
                            //               width: Dimensions
                            //                   .MARGIN_SIZE_EXTRA_SMALL),
                            //           Text(getTranslated('PHONE_NO', context),
                            //               style: robotoRegular)
                            //         ],
                            //       ),
                            //       SizedBox(
                            //           height: Dimensions.MARGIN_SIZE_SMALL),
                            //       CustomTextField(
                            //         textInputType: TextInputType.number,
                            //         focusNode: _phoneFocus,
                            //         hintText: profile.userInfoModel.phone ?? "",
                            //         nextNode: _addressFocus,
                            //         controller: _phoneController,
                            //         isPhoneNumber: true,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.MARGIN_SIZE_LARGE,
                          vertical: Dimensions.MARGIN_SIZE_SMALL),
                      child: !Provider.of<ProfileProvider>(context).isLoading
                          ? CustomButton(
                              onTap: _updateUserAccount,
                              buttonText:
                                  getTranslated('UPDATE_ACCOUNT', context))
                          : Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor))),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
