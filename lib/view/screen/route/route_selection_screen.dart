import 'package:activa_efectiva_bus/provider/route_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/view/basewidget/custom_app_bar.dart';
import 'package:activa_efectiva_bus/view/screen/route/route_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RouteSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          CustomAppBar(title: "Rutas de transporte", isBackButtonExist: true),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 54,
                        decoration: BoxDecoration(
                            color: ColorResources.COLOR_GOOGLE,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Row(
                          children: [
                            Consumer<RouteProvider>(
                              builder: (context, routeProvider, child) =>
                                  Expanded(
                                child: TextField(
                                  style: robotoRegular.copyWith(
                                      color: ColorResources.BLACK),
                                  cursorColor: ColorResources.COLOR_PRIMARY,
                                  autofocus: false,
                                  //onChanged: searchProvider.searchProduct,
                                  decoration: InputDecoration(
                                    hintText: "Buscar",
                                    contentPadding: EdgeInsets.only(
                                        left: Dimensions.PADDING_SIZE_DEFAULT),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintStyle: robotoRegular,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.only(
                                  right: Dimensions.PADDING_SIZE_SMALL),
                              decoration: BoxDecoration(
                                  color: ColorResources.COLOR_PRIMARY,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                Icons.search,
                                color: ColorResources.WHITE,
                              ),
                            ),
                          ],
                        )),
                    Consumer<RouteProvider>(
                      builder: (context, routeProvider, child) =>
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: routeProvider.operatorRoutes.length,
                              itemBuilder: (BuildContext context, int index) {
                                return new GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => RouteScreen(
                                                  route: routeProvider
                                                      .operatorRoutes[index],
                                                )))
                                  },
                                  child: Container(
                                    height: 56,
                                    child: Card(
                                      elevation: 2,
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            routeProvider
                                                .operatorRoutes[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
