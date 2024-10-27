import 'package:get/get.dart';

class Event {
  String name;
  String description;
  DateTime eventDate;
  String image;
  String location;
  String organizer;
  num price;

  Event({
    required this.eventDate,
    required this.image,
    required this.location,
    required this.name,
    required this.organizer,
    required this.price,
    required this.description,
  });
}

final List<Event> upcomingEvents = [
  Event(
    name: "Food Festivals".tr,
    eventDate: DateTime.now().add(const Duration(days: 24)),
    image: 'https://images.pexels.com/photos/5638268/pexels-photo-5638268.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    description: "A food festival is a vibrant culinary event where various cuisines, flavors, and dishes come together in one place.".tr,
    location: "Taxila".tr,
    organizer: "Westfield Centre".tr,
    price: 30,
  ),
  Event(
    name: "Arts and Crafts Fairs".tr,
    eventDate: DateTime.now().add(const Duration(days: 33)),
    image: 'https://images.pexels.com/photos/5682326/pexels-photo-5682326.jpeg?auto=compress&cs=tinysrgb&w=600',
    description: "An arts and crafts fair is a vibrant gathering where artisans showcase their creativity.".tr,
    location: "Jaulian Buddhist Stupa & Monastery".tr,
    organizer: "Arts Agency".tr,
    price: 30,
  ),
  Event(
    name: "Sporting Events".tr,
    eventDate: DateTime.now().add(const Duration(days: 12)),
    image: 'https://images.pexels.com/photos/18853028/pexels-photo-18853028/free-photo-of-man-racing-on-a-harley-davidson-motorcycle.jpeg?auto=compress&cs=tinysrgb&w=600',
    description: "Sporting events are thrilling spectacles that bring together athletes and fans to witness the excitement of competition and celebrate the spirit of athleticism.".tr,
    location: "Taxila Meuseum".tr,
    organizer: "Sports Ground".tr,
    price: 30,
  ),
];

final List<Event> nearbyEvents = [
  Event(
    name: "Street Fairs".tr,
    eventDate: DateTime.now().add(const Duration(days: 1)),
    image: 'https://images.pexels.com/photos/3810967/pexels-photo-3810967.jpeg?auto=compress&cs=tinysrgb&w=600',
    description: "Street fairs captivate with their vibrant atmosphere, offering a mosaic of local culture through food, art, music, and community spirit.".tr,
    location: "UNESCO World Heritage Centre".tr,
    organizer: "Local Events".tr,
    price: 30,
  ),
  Event(
    name: "Community Parades".tr,
    eventDate: DateTime.now().add(const Duration(days: 4)),
    image: 'https://images.pexels.com/photos/4130926/pexels-photo-4130926.png?auto=compress&cs=tinysrgb&w=600',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The".tr,
    location: "David Geffen Hall".tr,
    organizer: "Westfield Centre".tr,
    price: 30,
  ),
  Event(
    name: "Songwriters in Concert".tr,
    eventDate: DateTime.now().add(const Duration(days: 2)),
    image: 'https://www.pexels.com/photo/brown-acoustic-guitar-on-brown-and-black-stripe-sofa-4708882/',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The".tr,
    location: "The Cutting room".tr,
    organizer: "Westfield Centre".tr,
    price: 30,
  ),
  Event(
    name: "Rock Concert".tr,
    eventDate: DateTime.now().add(const Duration(days: 21)),
    image: 'https://www.pexels.com/photo/group-of-four-men-rock-band-210887/',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The".tr,
    location: "The Cutting room".tr,
    organizer: "Westfield Centre".tr,
    price: 32,
  ),
  Event(
    name: "Songwriters in Concert".tr,
    eventDate: DateTime.now().add(const Duration(days: 16)),
    image: 'https://www.pexels.com/photo/man-playing-drum-set-5045874/',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The".tr,
    location: "David Field".tr,
    organizer: "Westfield Centre".tr,
    price: 14,
  ),
];
