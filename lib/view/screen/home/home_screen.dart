import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/helper/network_info.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/utill/images.dart';
import 'package:activa_efectiva_bus/view/basewidget/title_row.dart';
import 'package:activa_efectiva_bus/view/screen/home/widget/banners_view.dart';
import '../../basewidget/transport_units_list.dart';

class HomePage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);

    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // App Bar
            SliverAppBar(
              floating: true,
              elevation: 0,
              centerTitle: false,
              automaticallyImplyLeading: false,
              pinned: true,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              title: Image.asset(Images.logo_with_name_image,
                  height: 50, color: ColorResources.getPrimary(context)),
            ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL,
                  //       20, Dimensions.PADDING_SIZE_SMALL, 0),
                  //   child: Row(children: [
                  //     Text(getTranslated('WELCOME', context),
                  //         style: robotoBold.copyWith(
                  //             color: ColorResources.getPrimary(context),
                  //             fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     Text("Steven Eduardo",
                  //         overflow: TextOverflow.ellipsis,
                  //         maxLines: 1,
                  //         style: robotoBold.copyWith(
                  //             color: ColorResources.getFloatingBtn(context),
                  //             fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
                  //   ]),
                  // ),
                  // Padding(
                  //   padding:
                  //       EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                  //   child: BannersView(),
                  // ),
                  // Latest Products
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Dimensions.PADDING_SIZE_SMALL,
                        20,
                        Dimensions.PADDING_SIZE_SMALL,
                        Dimensions.PADDING_SIZE_SMALL),
                    child: TitleRow(
                        title: getTranslated('MY_TRANSPORTS', context)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    child: TransportUnitsList(
                      checkConnection: false,
                        redirectScreen: "bus",
                        scrollController: _scrollController),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}
