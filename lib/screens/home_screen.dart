import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lostnfound/models/post_model.dart';
import 'package:lostnfound/screens/post_screen.dart';
import 'package:lostnfound/services/firebase_fcm.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name = FirebaseAuth.instance.currentUser!.displayName;
  String timeOfDay = '';

  Future<List<Map<String, PostModel>>> fetchTenPostsWithId() async {
    List<Map<String, PostModel>> postsWithId = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('post')
          .where('is_claimed', isEqualTo: false)
          .orderBy('created_at', descending: true)
          .limit(10) // Fetch 10 posts
          .get();

      postsWithId = querySnapshot.docs.map((doc) {
        String docId = doc.id;
        PostModel post = PostModel.fromJson({
          "title": doc["title"].toString(),
          "created_at": doc['created_at'] as Timestamp,
          "created_by": doc["created_by"].toString(),
          "is_claimed": doc["is_claimed"],
          "location": doc["location"].toString(),
          "category": doc["category"].toString(),
          "img_url": doc["img_url"].toString(),
          "email": doc["email"].toString()
        });
        return {docId: post};
      }).toList();
    } catch (e) {
      print('Error fetching posts: $e');
    }

    return postsWithId;
  }

  List<PostModel> posts = [];

  void updateTimeOfDay() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    setState(() {
      if (hour >= 6 && hour < 12) {
        timeOfDay = 'Morning';
      } else if (hour >= 12 && hour < 17) {
        timeOfDay = 'Afternoon';
      } else {
        timeOfDay = 'Evening';
      }
    });
  }

  final ScrollController _scrollController = ScrollController();
  // final List<PostModel> _posts = [];
  // bool _isLoading = false;

  Future<void> _initFCM() async {
    await FirebaseFCM().initNotification();
  }

  @override
  void initState() {
    super.initState();
    // _loadPosts();
    _scrollController.addListener(_scrollListener);
    updateTimeOfDay();
    _initFCM();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      //loadmore
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d, y').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "Good $timeOfDay",
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                formattedDate,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(CupertinoIcons.chat_bubble_2_fill),
          //   onPressed: () {},
          // ),
          IconButton(
            icon: const Icon(CupertinoIcons.bell_fill),
            onPressed: () {
              Get.toNamed('notification');
            },
          )
        ],
      ),
      body: FutureBuilder<List<Map<String, PostModel>>>(
        future: fetchTenPostsWithId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
            return buildPosts(posts);
          } else {
            return const Text("No data available");
          }
        },
      ),
    );
  }

  // function to display fetched data on screen
  Widget buildPosts(List<Map<String, PostModel>> posts) {
    // ListView Builder to show data in a list
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostCard(
          post: post,
        );
      },
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  // final PostModel post;

  final Map<String, PostModel> post;

  String shortenString(String input) {
    if (input.length > 30) {
      return '${input.substring(0, 30)}...';
    } else {
      return input;
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: GestureDetector(
        onTap: () {
          Get.to(() => const PostScreen(), arguments: post);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.values.first.title!.length > 80
                  ? '${post.values.first.title!.substring(0, 80)}...'
                  : post.values.first.title!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                  '${getTimeDifference(post.values.first.createdAt!)} - ${post.values.first.location!} - by ${post.values.first.createdBy!}'),
            ),
            CachedNetworkImage(
              imageUrl: post.values.first.imgUrl!,
              placeholder: (context, url) => const CircularProgressIndicator(),
              imageBuilder: (context, imageProvider) {
                return Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill)),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
