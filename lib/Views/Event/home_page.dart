import 'package:city_folio/Constants/text_style.dart';
import 'package:city_folio/Models/event_model.dart';
import 'package:city_folio/Utils/app_utils.dart';
import 'package:city_folio/Views/Event/event_detail_page.dart';
import 'package:city_folio/Widgets/Event%20Widgets/nearby_event_card.dart';
import 'package:city_folio/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventHomePage extends StatefulWidget {
  const EventHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EventHomePageState createState() => _EventHomePageState();
}

class _EventHomePageState extends State<EventHomePage>
    with TickerProviderStateMixin {
  late ScrollController scrollController = ScrollController();
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..forward();
  late AnimationController opacityController = AnimationController(
    vsync: this,
    duration: const Duration(microseconds: 1),
  );
  late Animation<double> opacity;

  void viewEventDetail(Event event) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, animation, __) {
          return FadeTransition(
            opacity: animation,
            child: EventDetailPage(event),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    opacity = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: opacityController,
    ));
    scrollController.addListener(() {
      opacityController.value = offsetToOpacity(
          currentOffset: scrollController.offset,
          maxOffset: scrollController.position.maxScrollExtent / 2);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECF4),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UIHelper.verticalSpace(16),
                buildNearbyConcerts(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNearbyConcerts() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: Color(0xFFE8ECF4),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Nearby Concerts".tr, style: headerStyle),
              const Spacer(),
              UIHelper.horizontalSpace(16),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            itemCount: nearbyEvents.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              final event = nearbyEvents[index];
              var animation = Tween<double>(begin: 800.0, end: 0.0).animate(
                CurvedAnimation(
                  parent: controller,
                  curve: Interval((1 / nearbyEvents.length) * index, 1.0,
                      curve: Curves.decelerate),
                ),
              );
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) => Transform.translate(
                  offset: Offset(animation.value, 0.0),
                  child: NearbyEventCard(
                    event: event,
                    onTap: () => viewEventDetail(event),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
