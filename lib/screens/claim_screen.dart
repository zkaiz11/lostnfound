import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lostnfound/core/loader.dart';
import 'package:lostnfound/models/claim_model.dart';
import 'package:lostnfound/models/post_model.dart';

class ClaimScreen extends StatefulWidget {
  const ClaimScreen({super.key});

  @override
  State<ClaimScreen> createState() => _ClaimScreenState();
}

class _ClaimScreenState extends State<ClaimScreen> {
  final Map<String, ClaimModel> claimDoc = Get.arguments;
  Future<PostModel> getPost() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('post')
        .doc(claimDoc.values.first.post.toString())
        .get();

    Map<String, dynamic> doc = snapshot.data() as Map<String, dynamic>;
    return PostModel.fromJson({
      "title": doc["title"].toString(),
      "created_at": doc['created_at'] as Timestamp,
      "created_by": doc["created_by"].toString(),
      "is_claimed": doc["is_claimed"],
      "location": doc["location"].toString(),
      "category": doc["category"].toString(),
      "img_url": doc["img_url"].toString(),
      "email": doc["email"].toString()
    });
  }

  void handleReject() async {
    try {
      await FirebaseFirestore.instance
          .collection('claim_request')
          .doc(claimDoc.keys.first.toString())
          .update({"is_rejected": true, "is_pending": false});
      print('Field updated successfully.');
      Loader.success(title: "Rejected");
    } catch (e) {
      print('Error updating field in document: $e');
      Loader.error(title: "Please try again");
    }
  }

  void handleConfirm() async {
    try {
      await FirebaseFirestore.instance
          .collection('post')
          .doc(claimDoc.values.first.post.toString())
          .update({"is_claimed": true});
      await FirebaseFirestore.instance
          .collection('claim_request')
          .doc(claimDoc.keys.first.toString())
          .update({"is_rejected": false, "is_pending": false});
      Loader.success(title: "Confirmed");
      print('Field updated successfully.');
    } catch (e) {
      print('Error updating field in document: $e');
      Loader.error(title: "Please try again");
    }
  }

  String getTimeDifference(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate(); // Convert Timestamp to DateTime
    DateTime now = DateTime.now(); // Get current time
    Duration difference = now.difference(dateTime); // Calculate the difference

    if (difference.inDays >= 365) {
      int years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      int days = difference.inDays;
      return '$days day${days > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      int hours = difference.inHours;
      return '$hours hour${hours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      int minutes = difference.inMinutes;
      return '$minutes minute${minutes > 1 ? 's' : ''} ago';
    } else {
      int seconds = difference.inSeconds;
      return '$seconds second${seconds > 1 ? 's' : ''} ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        centerTitle: true,
      ),
      body: FutureBuilder<PostModel>(
        future: getPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final post = snapshot.data!;
            return ListView(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  '${getTimeDifference(post.createdAt!)} - ${post.location} - by ${post.createdBy}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w200),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(post.title!),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.network(post.imgUrl!),
              ),
              Center(
                  child: claimDoc.values.first.isPending!
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: (){
                                handleReject();
                                Get.back();
                              },
                              child: const Text("Reject"),
                            ),
                            TextButton(
                              onPressed: (){
                                handleConfirm();
                                Get.back();
                                },
                              child: const Text("Confirm"),
                            )
                          ],
                        )
                      : Text(claimDoc.values.first.isRejected!
                          ? 'Rejected'
                          : 'Claimed'))
            ]);
          } else {
            return const Text("No data available");
          }
        },
      ),
    );
  }
}
