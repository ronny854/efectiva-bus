import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/view/basewidget/transport_unit_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransportUnitsList extends StatelessWidget {
  final ScrollController scrollController;
  final String redirectScreen;
  final bool checkConnection;
  TransportUnitsList(
      {this.scrollController,
      @required this.redirectScreen,
      @required this.checkConnection});

  @override
  Widget build(BuildContext context) {
    return Consumer<PartnerProvider>(
      builder: (context, partnerProvider, child) {
        List<PartnerInformationResponse> buses =
            partnerProvider.partnerInformation;

        return Column(children: [
          buses.length != 0
              ? StaggeredGridView.countBuilder(
                  itemCount: buses.length,
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                  itemBuilder: (BuildContext context, int index) {
                    return TransportUnitCard(
                      checkConnection: checkConnection,
                      partnerInformation: buses[index],
                      redirectScreen: redirectScreen,
                    );
                  },
                )
              : SizedBox.shrink(),
        ]);
      },
    );
  }
}
