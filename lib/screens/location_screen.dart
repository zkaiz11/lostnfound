import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lostnfound/components/district_drop_down.dart';
import 'package:lostnfound/components/input_drop_down.dart';
import 'package:lostnfound/controllers/location_controller.dart';

class SetLocationScreen extends StatefulWidget {
  SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  final LocationController locationController = Get.find<LocationController>();
  String? selectedProvince;
  String? selectedDistrict;
  List<String?>? provinceList;
  Future<void> initProvince() async {
    provinceList = locationController.provinces;
  }

  setDistrictList(String id) async {
    await locationController.getDistrict(id);
  }

  @override
  void initState() {
    // Assign initial value from GetX to local state
    locationController.onInit();
    provinceList = locationController.provinces;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: FutureBuilder(
          future: Get.find<LocationController>().fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while waiting for data
              return const CircularProgressIndicator();
            } else {
              // Once data is fetched, render the ParentComponent
              return Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Location",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "So we can recommend posts that are in your locations",
                  ),
                  InputDropDown(
                    dropdownItems: locationController.provinces,
                    textEditingController:
                        locationController.provinceTextEditingController,
                    onChanged: (value) {
                      setState(() {
                        selectedProvince = value;
                        selectedDistrict = null;
                        setDistrictList(
                            locationController.provinceMap[selectedProvince]!);
                      });
                    },
                    value: selectedProvince,
                  ),
                  DistrictDropDown(
                    onChanged: (value) {
                      setState(() {
                        selectedDistrict = value;
                      });
                    },
                    value: selectedDistrict,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
