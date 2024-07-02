import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostnfound/models/user_model.dart';
import 'package:lostnfound/repositories/user_repository.dart';

class AccountDetial extends StatefulWidget {
  const AccountDetial({super.key});

  @override
  State<AccountDetial> createState() => _AccountDetialState();
}

class _AccountDetialState extends State<AccountDetial> {
  User curUser = FirebaseAuth.instance.currentUser!;
  Future<UserModel> getUserProfile() async {
    UserModel user;
    user = await UserRepository.instance.getUserByEmail(curUser.email!);
    return user;
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Account Detial"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: FutureBuilder(
                future: getUserProfile(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: snapshot.hasData
                                ? NetworkImage(snapshot.data?.pfp
                                    as String) // Load user's profile picture from URL if available
                                : Image.asset('assets/img/black.png')
                                    .image, // Use fallback image if profile picture URL is not available
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    // Once the profile picture URL is fetched, display it in CircleAvatar
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(snapshot.data?.pfp
                                as String), // Load profile picture from URL
                          ),
                          Positioned(
                              bottom: -10,
                              left: 80,
                              child: IconButton(
                                icon: const Icon(Icons.add_a_photo),
                                onPressed: () {},
                              ))
                        ],
                      ),
                    );
                  }
                }),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Text(
              "Display Name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          FutureBuilder(
              future: getUserProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: TextField(
                      maxLines: 1,
                      enabled: false,
                      controller: _textEditingController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "",
                          fillColor: Colors.white70),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  // Once the profile picture URL is fetched, display it in CircleAvatar
                  _textEditingController.text = snapshot.data!.name!;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: TextField(
                      maxLines: 1,
                      controller: _textEditingController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Type in your text",
                          fillColor: Colors.white70),
                    ),
                  );
                }
              }),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              icon: const Icon(
                CupertinoIcons.add_circled,
                color: Colors.white,
                size: 30.0,
              ),
              label: const Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  side: BorderSide(
                      width: 1, color: Theme.of(context).primaryColor),
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            ),
          ),
        ],
      ),
    );
  }
}
