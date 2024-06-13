import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lostnfound/components/input_drop_down.dart';
import 'package:lostnfound/screens/search_result_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _locationEditingController =
      TextEditingController();
  final TextEditingController _categoryEditingController =
      TextEditingController();

  List<String> locationList = [
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
    "Kratie",
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
    "Takeo",
    "Tboung Khmum"
  ];
  List<String> categoryList = [
    "Personal Identification and Financial Items",
    "Electronics",
    "Keys",
    "Bags and Accessories",
    "Clothing Items",
    "Books and Documents",
    "Personal Care Items",
    "Jewelry and Accessories",
    "Recreational Items",
    "Miscellaneous Items",
    "Others"
  ];
  String? selectedProvince;
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Location",
                style: TextStyle(fontSize: 20),
              ),
              InputDropDown(
                dropdownItems: locationList,
                textEditingController: _locationEditingController,
                value: selectedProvince,
                onChanged: (value) => setState(() {
                  selectedProvince = value;
                }),
              ),
              const Text(
                "Category",
                style: TextStyle(fontSize: 20),
              ),
              InputDropDown(
                dropdownItems: categoryList,
                textEditingController: _categoryEditingController,
                value: selectedCategory,
                onChanged: (value) => setState(() {
                  selectedCategory = value;
                }),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 32),
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  label: const Text(
                    "Search",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    Get.toNamed('/result', arguments: [selectedCategory, selectedProvince]);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      side: BorderSide(
                          width: 1, color: Theme.of(context).primaryColor),
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15)),
                ),
              )
            ],
          ),]
        ),
      ),
    );
  }
}
