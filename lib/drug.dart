import 'dart:ffi';

class drug {
  int? id;
  String? names;
  String? price;
  String? ing;
  String? uses;
  String? company;
  String? img;
  num? rx;

  drug(
      {required this.id,
        required this.names,
        required this.price,
        required this.ing,
        required this.uses,
        required this.company,
        required this.img,
        required this.rx});

  drug.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    names = json['names'];
    price = json['price'];
    ing = json['ing'];
    uses = json['uses'];
    company = json['company'];
    img = json['img'];
    rx = json['rx'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['names'] = this.names;
    data['price'] = this.price;
    data['ing'] = this.ing;
    data['uses'] = this.uses;
    data['company'] = this.company;
    data['img'] = this.img;
    data['rx'] = this.rx;
    return data;
  }
}