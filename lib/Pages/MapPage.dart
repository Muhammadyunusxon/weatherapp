import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:weather/Pages/HomePage.dart';
import 'package:weather/Repository/get_Information.dart';
import 'package:weather/Style/style.dart';
import '../store/local_store.dart';

class MapPage extends StatefulWidget {
  final double lat;
  final double lon;

  const MapPage({Key? key, required this.lat, required this.lon})
      : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.brandColor,
        title: const Text("Google map"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        onTap: (location) async {
          final reverseSearchResult = await Nominatim.reverseSearch(
              lat: location.latitude,
              lon: location.longitude,
              addressDetails: true,
              extraTags: true,
              nameDetails: true,
              language: "en"
          );
          print(reverseSearchResult.address);
          var data = await GetInformationRepository.getInformationWeather(reverseSearchResult.address?["country"]);
          if (data["error"] == null) {
            await LocalStore.setCountry(
                reverseSearchResult.address?["country"]);
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false);
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  data["error"].toString(),
                ),
              ),
            );
          }
        },
        initialCameraPosition:
        CameraPosition(target: LatLng(widget.lat, widget.lon)),
      ),
    );
  }
}