import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lostnfound/models/post_model.dart';
import 'package:lostnfound/models/user_model.dart';

class PostRepository extends GetxController {
  static PostRepository get instance => Get.find();
  final db = FirebaseFirestore.instance;

  //Save user
  Future<void> savePost(PostModel post) async {
    try {
      db.collection("post").add(post.toJson()).then((DocumentReference doc) =>
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

  Future<UserModel> getUserById(String id) async {
    try {
      final querySnapshot =
          await db.collection("user").where("google_uid", isEqualTo: id).get();
      if (querySnapshot.docs.isNotEmpty) {
        final userInfo =
            querySnapshot.docs.first.data();
        return UserModel.fromJson(userInfo);
      } else {
        throw Exception("User not found");
      }
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

  Future<void> updateUserDataByEmail(String email, Map<String, dynamic> updatedData) async {
    try {
      // Perform a query to find the document based on the email
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await db.collection('user').where('email', isEqualTo: email).get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Update the first document found
        String userId = querySnapshot.docs.first.id;
        await db.collection('user').doc(userId).update(updatedData);
        print('Document updated successfully.');
      } else {
        print('No user found with email: $email');
      }
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
