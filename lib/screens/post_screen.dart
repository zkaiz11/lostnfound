import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lostnfound/core/loader.dart';
import 'package:lostnfound/models/claim_model.dart';
import 'package:lostnfound/models/post_model.dart';
import 'package:lostnfound/models/user_model.dart';
import 'package:lostnfound/repositories/user_repository.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Map<String, PostModel> post = Get.arguments;
  final TextEditingController _textEditingController = TextEditingController();
  User user = FirebaseAuth.instance.currentUser!;
  Future<String> getUserProfile() async {
    UserModel user;
    user =
        await UserRepository.instance.getUserByEmail(post.values.first.email!);
    return user.pfp!;
  }

  bool chatVisibity = false;
  bool buttonEnable = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  Future<void> handleCliam() async {
    try {
      Loader.openLoading();
      // Get a reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get a reference to the specific document by ID
      // DocumentSnapshot referencedDoc =
      //     await firestore.collection('post').doc(post.keys.first.toString()).get();

      // Check if the document exists

      ClaimModel claimDoc = ClaimModel(
        senderEmail: user.email,
        receiverEmail: post.values.first.email,
        isPending: true,
        isRejected: false,
        createdAt: Timestamp.fromDate(DateTime.now()),
        post: post.keys.first.toString(),
        senderPfUrl: user.photoURL.toString(),
        senderName: user.displayName.toString(),
      );

      await firestore.collection('claim_request').add(claimDoc.toJson());
      Loader.closeLoading();
      Loader.success(title: "Request claim successfully");
    } catch (e) {
      Loader.closeLoading();
      print('Error fetching post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user.email == post.values.first.email) {
      chatVisibity = false;
      buttonEnable = false;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen by popping the current route
            // Navigator.of(context).pop();
            Get.back();
          },
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    post.values.first.createdBy!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                FutureBuilder(
                    future: getUserProfile(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: snapshot.hasData
                                ? NetworkImage(snapshot.data
                                    as String) // Load user's profile picture from URL if available
                                : Image.asset('assets/img/black.png')
                                    .image, // Use fallback image if profile picture URL is not available
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        // Once the profile picture URL is fetched, display it in CircleAvatar
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(snapshot.data
                                as String), // Load profile picture from URL
                          ),
                        );
                      }
                    })
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                '${getTimeDifference(post.values.first.createdAt!)} - ${post.values.first.location} - by ${post.values.first.createdBy}',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(post.values.first.title!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.network(post.values.first.imgUrl!),
            ),
            Visibility(
              visible: buttonEnable,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    CupertinoIcons.add_circled,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  label: const Text(
                    "Request to claim",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    // if (user.email == post.values.first.email) {
                    //   Loader.warning(
                    //       title: "You can not make claim on your own post.");
                    // }
                    handleCliam();
                    Get.back();
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
              ),
            )
          ]),
        ),
        Visibility(
          visible: chatVisibity,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: TextField(
              onSubmitted: (value) {
                print(value);
                _textEditingController.clear();
              },
              keyboardType: TextInputType.text,
              minLines: 1,
              maxLines: 1,
              controller: _textEditingController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      top: 0, bottom: 4, left: 8, right: 8),
                  suffix: IconButton(
                    icon: const Icon(
                      CupertinoIcons.paperplane,
                    ),
                    onPressed: () {
                      print(_textEditingController.text);
                      _textEditingController.clear();
                    },
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800], fontSize: 18),
                  hintText: "Type in your message ...",
                  fillColor: Colors.white70),
            ),
          ),
        ),
      ]),
    );
  }
}
