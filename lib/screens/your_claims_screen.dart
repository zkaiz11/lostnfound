import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lostnfound/models/claim_model.dart';
import 'package:lostnfound/screens/claim_screen.dart';

class YourClaimsScreen extends StatefulWidget {
  const YourClaimsScreen({super.key});

  @override
  State<YourClaimsScreen> createState() => _YourClaimsScreenState();
}

class _YourClaimsScreenState extends State<YourClaimsScreen> {

  User user = FirebaseAuth.instance.currentUser!;
  Future<List<Map<String, ClaimModel>>> getClaimRequest() async {
    List<Map<String, ClaimModel>> claimDocs = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('claim_request')
          .where("sender_email", isEqualTo: user.email)
          .orderBy('created_at', descending: true)
          .get();

      claimDocs = querySnapshot.docs.map((doc) {
        String docId = doc.id;
        ClaimModel claimDoc = ClaimModel.fromJson({
          "sender_email": doc["sender_email"].toString(),
          "created_at": doc['created_at'] as Timestamp,
          "receiver_email": doc["receiver_email"].toString(),
          "is_pending": doc["is_pending"],
          "is_rejected": doc["is_rejected"],
          "sender_pf_url": doc["sender_pf_url"],
          "sender_name": doc["sender_name"].toString(),
          "post": doc["post"].toString()
        });
        return {docId: claimDoc};
      }).toList();
      print(claimDocs);
    } catch (e) {
      print('Error fetching posts: $e');
    }

    return claimDocs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Claim Requests"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, ClaimModel>>>(
        future: getClaimRequest(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final docs = snapshot.data!;
            return buildItems(docs);
          } else {
            return const Text("No data available");
          }
        },
      ),
    );
  }

  Widget buildItems(List<Map<String, ClaimModel>> claimDocs) {
    // ListView Builder to show data in a list
    return ListView.builder(
      itemCount: claimDocs.length,
      itemBuilder: (context, index) {
        final doc = claimDocs[index];
        return NotificationCard(
          claimDoc: doc,
        );
      },
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.claimDoc,
  });

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

  final Map<String, ClaimModel> claimDoc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => const ClaimScreen(), arguments: claimDoc);
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(claimDoc.values.first.senderPfUrl!),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${claimDoc.values.first.senderName!}(You)",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(getTimeDifference(claimDoc.values.first.createdAt!)),
                      ),
                    ],
                  ),
                  const Text("Requested to claim this belonging",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    claimDoc.values.first.isPending! ? "Status: Pending" : (claimDoc.values.first.isRejected! ? "Status: Rejected" : "Status: Claimed")
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}