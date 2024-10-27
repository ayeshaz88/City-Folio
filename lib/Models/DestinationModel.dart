
// ignore_for_file: file_names

class DestinationModel {
  int? id;
  String? name;
  double? rating;
  bool? isFav;

  DestinationModel({this.id, this.name, this.rating, this.isFav});

  DestinationModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["rating"] is double) {
      rating = json["rating"];
    }
    if(json["isFav"] is bool) {
      isFav = json["isFav"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["rating"] = rating;
    data["isFav"] = isFav;
    return data;
  }
}