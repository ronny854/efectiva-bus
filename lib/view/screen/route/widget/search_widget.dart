import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/view/screen/route/route_selection_screen.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;
  SearchWidget({this.hintText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RouteSelectionScreen())),
      child: Container(
        height: 55,
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          color: ColorResources.COLOR_Lavender,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(hintText??"",style: robotoRegular,),

            Icon(Icons.search,color: ColorResources.COLOR_PRIMARY,)
          ],
        ),
      ),
    );
  }
}
