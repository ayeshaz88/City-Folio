import 'package:city_folio/Constants/color.dart';
import 'package:city_folio/Constants/text_style.dart';
import 'package:city_folio/Models/event_model.dart';
import 'package:city_folio/Utils/datetime_utils.dart';
import 'package:city_folio/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NearbyEventCard extends StatelessWidget {
  final Event event;

  final VoidCallback onTap;
  const NearbyEventCard({Key? key, required this.event, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            buildImage(),
            buildEventInfo(context),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: imgBG,
        width: 80,
        height: 100,
        child: Hero(
          tag: event.image,
          child: Image.network(
            event.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildEventInfo(context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(DateTimeUtils.getFullDate(event.eventDate).tr, style: monthStyle),
          UIHelper.verticalSpace(8),
          Text(event.name.tr, style: titleStyle),
          UIHelper.verticalSpace(8),
          Row(
            children: <Widget>[
              Icon(Icons.location_on,
                  size: 16, color: Theme.of(context).primaryColor),
              UIHelper.horizontalSpace(4),
              Text(event.location.tr.toUpperCase(), style: subtitleStyle),
            ],
          ),
        ],
      ),
    );
  }
}
