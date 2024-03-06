import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  Map<String, List<String>> provinceData = {
    "Banteay Meanchey": [
      "Mongkol Borei",
      "Phnom Srok",
      "Preah Netr Preah",
      "Ou Chrov",
      "Serei Saophoan",
      "Svay Chek",
      "Malai",
      "Sisophon",
      "Poipet",
      "Thmar Puok"
    ],
    "Battambang": [
      "Banan",
      "Thma Koul",
      "Bavel",
      "Ek Phnom",
      "Moung Ruessi",
      "Rotanak Mondol",
      "Sangkae",
      "Samlout",
      "Sampov Loun",
      "Phnum Proek",
      "Kamrieng",
      "Koas Krala",
      "RukhaKiri",
      "Battambang",
      "Thmar Kol",
      "Moung Ruessei",
      "Svay Don Kev"
    ],
    "Kampong Cham": [
      "Baatheay",
      "Chamkar Leu",
      "Cheung Prey",
      "Kampong Cham",
      "Kampong Siem",
      "Kang Meas",
      "Koh Sotin",
      "Prey Chhor",
      "Srey Santhor",
      "Stueng Trang",
      "Skuon"
    ],
    "Kampong Chhnang": [
      "Baribour",
      "Chol Kiri",
      "Kampong Chhnang",
      "Kampong Leaeng",
      "Kampong Tralach",
      "Rolea B'ier",
      "Sameakki Mean Chey",
      "Kampong Chhang",
      "Remeas",
      "Tuek Phos"
    ],
    "Kampong Speu": [
      "Basedth",
      "Chbar Mon",
      "Kong Pisei",
      "Aoral",
      "Odongk",
      "Phnom Sruoch",
      "Samraong Tong",
      "Thpong",
      "Amleang",
      "Oudong"
    ],
    "Kampong Thom": [
      "Baray",
      "Kampong Svay",
      "Stueng Saen",
      "Prasat Balangk",
      "Prasat Sambour",
      "Sandaan",
      "Santuk",
      "Stoung",
      "Kampong Thom"
    ],
    "Kampot": [
      "Angkor Chey",
      "Banteay Meas",
      "Chhuk",
      "Chum Kiri",
      "Dang Tong",
      "Kampong Trach",
      "Kampot",
      "Kampong Bay"
    ],
    "Kandal": [
      "Kandal Stueng",
      "Kien Svay",
      "Khsach Kandal",
      "Koh Thum",
      "Leuk Daek",
      "Lvea Aem",
      "Mukh Kamphool",
      "Angk Snuol",
      "Ponhea Leu",
      "S'ang",
      "Ta Khmau"
    ],
    "Koh Kong": [
      "Botum Sakor",
      "Kiri Sakor",
      "Koh Kong",
      "Smach Mean Chey",
      "Mondol Seima",
      "Srae Ambel",
      "Thma Bang"
    ],
    "Kratie": [
      "Chhloung",
      "Kracheh",
      "Preaek Prasab",
      "Sambour",
      "Snuol",
      "Kratie"
    ],
    "Mondulkiri": [
      "Kaev Seima",
      "Kaoh Nheaek",
      "Ou Reang",
      "Pechr Chenda",
      "Senmonorom"
    ],
    "Oddar Meancheay": [
      "Anlong Veaeng",
      "Banteay Ampil",
      "Chong Kal",
      "Samraong",
      "Trapeang Prasat",
      "Phanomsok"
    ],
    "Preah Vihear": [
      "Chey Saen",
      "Chhaeb",
      "Choam Khsant",
      "Kuleaen",
      "Rovieng",
      "Sangkom Thmei",
      "Tbaeng Mean Chey",
      "Phnom Tbeng Meanchey",
      "Cheom Ksan",
      "Koulen"
    ],
    "Pursat": [
      "Bakan",
      "Kandieng",
      "Krakor",
      "Phnum Kravanh",
      "Pursat",
      "Veal Veaeng"
    ],
    "Prey Veng": [
      "Ba Phnum",
      "Kamchay Mear",
      "Kampong Trabaek",
      "Kanhchriech",
      "Me Sang",
      "Peam Chor",
      "Peam Ro",
      "Pea Reang",
      "Preah Sdach",
      "Prey Veaeng",
      "Kampong Leav",
      "Sithor Kandal",
      "Por reang",
      "Neak Leung"
    ],
    "Ratanakiri": [
      "Andoung Meas",
      "Bar Kaev",
      "Koun Mom",
      "Lumphat",
      "Ou Chum",
      "Ou Ya Dav",
      "Ta Veaeng",
      "Veun Sai",
      "Banlung"
    ],
    "Siem Reap": [
      "Angkor Chum",
      "Angkor Thom",
      "Banteay Srei",
      "Chi Kraeng",
      "Kralanh",
      "Puok",
      "Prasat Bakong",
      "Siem Reap",
      "Sout Nikom",
      "Srei Snam",
      "Svay Leu",
      "Varin",
      "Roluos"
    ],
    "Stung Treng": [
      "Sesan",
      "Siem Bouk",
      "Siem Pang",
      "Thala Barivat",
      "Stung Treng"
    ],
    "Svay Rieng": [
      "Chantrea",
      "Kampong Rou",
      "Rumduol",
      "Romeas Haek",
      "Svay Chrum",
      "Svay Rieng",
      "Svay Teab",
      "Bavet"
    ],
    "Takeo": [
      "Angkor Borei",
      "Bati",
      "Bourei Cholsar",
      "Kiri Vong",
      "Kaoh Andaet",
      "Prey Kabbas",
      "Samraong",
      "Doun Kaev",
      "Tram Kak",
      "Treang",
      "Takeo"
    ],
    "Tboung Khmum": [
      "Dambae",
      "Krouch Chhma",
      "Memot",
      "Ou Reang Ov",
      "Ponhea Kraek",
      "Tbuong Khmum",
      "Suong City"
    ]
  }.obs;
  final province = [
    "Banteay Meanchey",
    "Battambang",
    "Kampong Cham",
    "Kampong Chhnang",
    "Kampong Speu",
    "Kampong Thom",
    "Kampot",
    "Kandal",
    "Kep",
    "Koh Kong",
    "Kratié",
    "Mondulkiri",
    "Oddar Meanchey",
    "Pailin",
    "Phnom Penh",
    "Preah Sihanouk",
    "Preah Vihear",
    "Prey Veng",
    "Pursat",
    "Ratanakiri",
    "Siem Reap",
    "Stung Treng",
    "Svay Rieng",
    "Takéo",
    "Tboung Khmum" "Banteay Meanchey",
    "Battambang",
    "Kampong Cham",
    "Kampong Chhnang",
    "Kampong Speu",
    "Kampong Thom",
    "Kampot",
    "Kandal",
    "Kep",
    "Koh Kong",
    "Kratié",
    "Mondulkiri",
    "Oddar Meanchey",
    "Pailin",
    "Phnom Penh",
    "Preah Sihanouk",
    "Preah Vihear",
    "Prey Veng",
    "Pursat",
    "Ratanakiri",
    "Siem Reap",
    "Stung Treng",
    "Svay Rieng",
    "Takéo",
    "Tboung Khmum"
  ].obs;
  List<String> district = [];
  final provinceController = TextEditingController();
  final districtController = TextEditingController();
  GlobalKey<FormState> locationFormKey = GlobalKey<FormState>();
  String? provinceSelectedValue;
  String? districtSelectedValue;
  void setDistrict(String value) {
    districtSelectedValue = value;
    update();
  }

  void setProvince(String value) {
    district = provinceData[value]!;
    provinceSelectedValue = value;
    update();
  }
}
