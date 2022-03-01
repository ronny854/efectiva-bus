import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:flutter/material.dart';

class OtpWidget extends StatelessWidget {
  final Widget child;
  OtpWidget({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.WHITE,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: 270,
              color: Colors.grey.withOpacity(0.5),
            ),
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0))),
                child: child,
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Align(
                    alignment: Alignment.center,
                    child: Center(
                      child: Card(
                        child: Column(
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
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
