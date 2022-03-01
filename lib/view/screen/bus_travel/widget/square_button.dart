import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final String title;
  final Widget navigateTo;
  final IconData icon;
  final bool isDanger;
  final Function customNavigateTo;
  SquareButton(
      {@required this.title,
      @required this.icon,
      @required this.navigateTo,
      this.isDanger = false,
      this.customNavigateTo});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 160;
    return InkWell(
      onTap: customNavigateTo != null
          ? customNavigateTo
          : () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => navigateTo))
              },
      child: Column(children: [
        Container(
          width: width / 4,
          height: width / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDanger
                ? ColorResources.getRed(context)
                : ColorResources.getPrimary(context),
          ),
          child: Icon(
            icon,
            size: width / 5,
            color: isDanger
                ? ColorResources.HOME_BG
                : ColorResources.getPrimaryInversed(context),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(title, style: robotoRegular),
        ),
      ]),
    );
  }
}
