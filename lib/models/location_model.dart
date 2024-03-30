class Location {
  Name? name;
  String? id;
  Unit? unit;

  Location({this.name, this.id, this.unit});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    id = json['id'];
    unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.name != null) {
  //     data['name'] = this.name.toJson();
  //   }
  //   data['id'] = this.id;
  //   if (this.unit != null) {
  //     data['unit'] = this.unit.toJson();
  //   }
  //   return data;
  // }
}

class Name {
  String? km;
  String? latin;

  Name({this.km, this.latin});

  Name.fromJson(Map<String, dynamic> json) {
    km = json['km'];
    latin = json['latin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['km'] = this.km;
    data['latin'] = this.latin;
    return data;
  }
}

class Unit {
  String? km;
  String? latin;
  String? en;

  Unit({this.km, this.latin, this.en});

  Unit.fromJson(Map<String, dynamic> json) {
    km = json['km'];
    latin = json['latin'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['km'] = this.km;
    data['latin'] = this.latin;
    data['en'] = this.en;
    return data;
  }
}