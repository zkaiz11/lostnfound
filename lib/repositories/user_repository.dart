import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lostnfound/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final db = FirebaseFirestore.instance;

  //Save user
  Future<void> saveUser(UserModel user) async {
    try {
      db.collection("user").add(user.toJson()).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } on FormatException catch (e) {
      throw Exception(e.message);
    } on PlatformException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw "something went wrong";
    }
  }
}
