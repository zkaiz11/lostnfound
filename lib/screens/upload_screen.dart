import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostnfound/components/input_drop_down.dart';
import 'package:lostnfound/controllers/post_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lostnfound/core/loader.dart';
import 'package:lostnfound/models/post_model.dart';
import 'package:lostnfound/repositories/post_repository.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  // final PostController postController = Get.find<PostController>();
  final TextEditingController _textTitleEditingController =
      TextEditingController();
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

// StoragePhoto
  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();
  UploadTask? uploadTask;

  PlatformFile? pickedFile;

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // File file = File(result.files.single.path!);
      setState(() {
        pickedFile = result.files.single;
      });
    } else {
      return;
    }
  }

  Future uploadFileAndUploadPost() async {
    
    if (_textTitleEditingController.text.isEmpty || selectedCategory == null || selectedProvince == null || pickedFile == null) {
      Loader.warning(title: "All the field are required");
      return;
    }

    try {
      final path = 'files/${pickedFile!.name}';
      final file = File(pickedFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      // While the file names are the same, the references point to different files
      // assert(ref.fullPath != ref.fullPath);
      await ref.putFile(file);

      final imgUrl = await ref.getDownloadURL();

      String? name = FirebaseAuth.instance.currentUser!.displayName;

      PostModel post = PostModel(
        title: _textTitleEditingController.text,
        createdAt: Timestamp.fromDate(DateTime.now()),
        createdBy: name,
        email: FirebaseAuth.instance.currentUser!.email,
        location: selectedProvince,
        category: selectedCategory,
        isClaimed: false,
        imgUrl: imgUrl,
      );
      print("here");
      await PostRepository.instance.savePost(post);
      Loader.success(title: "Post Uploaded.");
      setState(() {
        _textTitleEditingController.clear();
        _locationEditingController.clear();
        _categoryEditingController.clear();
        selectedCategory = null;
        selectedProvince = null;
        pickedFile = null; // Reset pickedFile
      });
    } catch (e) {
      Loader.error(title: "Failed to upload please try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Make a post"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Title and Decription",
                style: TextStyle(fontSize: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  controller: _textTitleEditingController,
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
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: GestureDetector(
                  onTap: () {
                    selectFile();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Click to select a photo"),
                      Icon(CupertinoIcons.add),
                    ],
                  ),
                ),
              ),
              if (pickedFile != null) Image.file(File(pickedFile!.path!)),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    CupertinoIcons.add_circled,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  label: const Text(
                    "Post",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: uploadFileAndUploadPost,
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
          ),
        ]),
      ),
    );
  }
}
