class BookingRequest {
  String? dateCheckin;
  String? dateCheckout;
  String? description;
  Info? info;
  List<Rooms>? rooms;

  BookingRequest({this.dateCheckin, this.dateCheckout, this.description, this.info, this.rooms});

  BookingRequest.fromJson(Map<String, dynamic> json) {
    dateCheckin = json['dateCheckin'];
    dateCheckout = json['dateCheckout'];
    description = json['description'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(new Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateCheckin'] = this.dateCheckin;
    data['dateCheckout'] = this.dateCheckout;
    data['description'] = this.description;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  String? cardId;
  String? country;
  String? email;
  String? name;
  String? phone;

  Info({this.cardId, this.country, this.email, this.name, this.phone});

  Info.fromJson(Map<String, dynamic> json) {
    cardId = json['cardId'];
    country = json['country'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardId'] = this.cardId;
    data['country'] = this.country;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class Rooms {
  int? children;
  String? hotel;
  String? id;
  int? infants;
  int? price;
  String? roomType;

  Rooms({this.children, this.hotel, this.id, this.infants, this.price, this.roomType});

  Rooms.fromJson(Map<String, dynamic> json) {
    children = json['children'];
    hotel = json['hotel'];
    id = json['id'];
    infants = json['infants'];
    price = json['price'];
    roomType = json['roomType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['children'] = this.children;
    data['hotel'] = this.hotel;
    data['id'] = this.id;
    data['infants'] = this.infants;
    data['price'] = this.price;
    data['roomType'] = this.roomType;
    return data;
  }
}
