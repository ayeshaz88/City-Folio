import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetails extends StatefulWidget {
  final String placeImage1, placeImage2, cityname, placeName, placeDescription;

  PlaceDetails({
    Key? key,
    required this.cityname,
    required this.placeDescription,
    required this.placeImage1,
    required this.placeImage2,
    required this.placeName,
  }) : super(key: key);

  @override
  _PlaceDetailsState createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        widget.placeImage1,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: contentPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.placeName.tr,
                                style: headerText,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _openGoogleMaps(widget.placeName, widget.cityname);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.cityname.tr,
                            style: TextStyle(color: AppColors().border_color),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.placeDescription.tr,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openGoogleMaps(String placeName, String cityName) async {
    String query = "$placeName, $cityName";
    String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=${Uri.encodeQueryComponent(query)}";

    try {
      if (await canLaunch(googleMapsUrl)) {
        await launch(googleMapsUrl);
      } else {
        throw 'Could not launch Google Maps'.tr;
      }
    } catch (e) {
      print('Error opening Google Maps: $e'.tr);
    }
  }


}
