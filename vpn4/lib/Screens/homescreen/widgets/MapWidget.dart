import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/MainModel.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 191,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Consumer<MainViewModel>(builder: (_, provider, child) {
          return GoogleMap(
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            myLocationButtonEnabled: false,
            markers: provider.mapMarkers,
            initialCameraPosition: provider.kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(provider.mapTheme);
              provider.mapController = controller;
              provider.updateMapPosition();
              // try {
              //   provider.mapController.complete(controller);
              // } catch (e) {
              //   provider.mapController.completeError(e);
              // }
            },
          );
        }),
      ),
    );
  }
}
