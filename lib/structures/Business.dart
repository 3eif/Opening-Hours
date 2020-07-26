class Business {
  String formattedAddress;
  String formattedPhoneNumber;
  String name;
  OpeningHours openingHours;
  List<dynamic> types;

  Business({
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.name,
    this.openingHours,
    this.types,
  });

  Business.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'] != null
        ? formattedAddress = json['formatted_address']
        : null;
    formattedPhoneNumber = json['formatted_phone_number'] != null
        ? formattedPhoneNumber = json['formatted_phone_number']
        : null;
    name = json['name'];
    openingHours = json['opening_hours'] != null
        ? new OpeningHours.fromJson(json['opening_hours'])
        : null;
    types = json['types'] != null ? types = json['types'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.formattedAddress != null) {
      data['formatted_address'] = this.formattedAddress;
    }
    if (this.formattedPhoneNumber != null) {
      data['formatted_phone_number'] = this.formattedPhoneNumber;
    }
    data['name'] = this.name;
    if (this.openingHours != null) {
      data['opening_hours'] = this.openingHours.toJson();
    }
    if (this.types != null) {
      data['types'] = this.types;
    }
    return data;
  }
}

class OpeningHours {
  bool openNow;
  List<String> weekdayText;

  OpeningHours({this.openNow, this.weekdayText});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'];
    weekdayText = json['weekday_text'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open_now'] = this.openNow;
    data['weekday_text'] = this.weekdayText;
    return data;
  }
}
