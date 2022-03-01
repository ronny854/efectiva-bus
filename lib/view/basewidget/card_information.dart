import 'package:activa_efectiva_bus/data/model/response/card_model.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/utill/utils.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

class CardInformation extends StatelessWidget {
  final CardModel card;

  CardInformation({
    this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
        left: 0,
        right: 0,
      ),
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorResources.COLOR_PRIMARY,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5)
          ]),
      child: Stack(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            flex: 4,
            child: Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                  color: ColorResources.getIconBg(context),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                ),
                child: FadeInImage.assetNetwork(
                  image: card.isPreferencial
                      ? card.metadata["photoUrl"]
                      : "https://dummyimage.com/300x300/E8E8E8/ffffff.jpg&text=A",
                  placeholder: cupertinoActivityIndicator,
                  fit: BoxFit.cover,
                  height: 100,
                )),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  // Card user names
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.person_pin_outlined,
                        color: ColorResources.getPrimaryInversed(context),
                        size: 26),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                      child: Text(
                        card.isPreferencial
                            ? card.metadata["names"] +
                                " " +
                                card.metadata["lastNames"]
                            : "",
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                            color: ColorResources.getPrimaryInversed(context)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  // Card code
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.qr_code,
                        color: ColorResources.getPrimaryInversed(context),
                        size: 26),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                      child: Text(
                        Utils.maskCode(card.code),
                        style: robotoBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                            color: ColorResources.getPrimaryInversed(context)),
                      ),
                    ),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  // Card balance
                  Row(children: [
                    Icon(Icons.attach_money, color: Colors.orange, size: 32),
                    Expanded(
                      child: Text(
                        card.balance.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: robotoSuperBold.copyWith(
                            color: Colors.orange, fontSize: 20),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ]),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 150,
            height: 25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorResources.getYellow(context),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            child: Text(
              card.isPreferencial ? card.preference : "NO PREFERENCIAL",
              style: robotoBold.copyWith(
                  color: ColorResources.WHITE,
                  fontSize: Dimensions.FONT_SIZE_DEFAULT),
            ),
          ),
        )
      ]),
    );
  }
}
