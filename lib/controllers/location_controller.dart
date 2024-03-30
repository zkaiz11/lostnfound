import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lostnfound/models/location_model.dart';
import 'package:http/http.dart' as http;

class LocationController extends GetxController {
  var isLoading = false.obs;
  var provinceList = <Location>[].obs;
  var districtList = <Location>[].obs;
  var provinces = <String?>[].obs;
  var districts = <String?>[].obs;
  var selectedProvince = ''.obs;
  final TextEditingController provinceTextEditingController = TextEditingController();
  var selectedDistrict = ''.obs;
  final TextEditingController districtTextEditingController = TextEditingController();
  
  Map<String, String> provinceMap = {};


  @override
  void onInit(){
    super.onInit();
    fetchData();
  }

  fetchData() async {
    try {
      String url = 'https://getprovinces-m3v26qb5jq-uc.a.run.app';
      isLoading(true);
      // http.Response response = await http.get(Uri.tryParse(
      //     'https://getprovinces-m3v26qb5jq-uc.a.run.app')!);
      print("pro");
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        provinceList.value = List.from(result).map((e) => Location.fromJson(e)).toList();
        provinces(provinceList.map((element) => element.name?.latin).toList());
        for (final item in provinceList) {
          var key = item.name?.latin;
          var value = item.id;
          if (key != null && value != null) {
            provinceMap[key] = value;
          }
        }
        update();
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  getDistrict(String id) async {
    try {
      String url = 'https://getdistrict-m3v26qb5jq-uc.a.run.app?provinceId=$id';
      isLoading(true);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        districtList(List.from(result).map((e) => Location.fromJson(e)).toList());
        districts(districtList.map((element) => element.name?.latin).toList());
        update();
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  setSelectedDistrict(String value) {
    selectedDistrict(value);
  }

}