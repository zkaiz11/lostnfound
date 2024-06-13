import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? title;
  Timestamp? createdAt;
  String? createdBy;
  bool? isClaimed;
  String? location;
  String? category;
  String? imgUrl;
  String? email;

  PostModel(
      {this.title,
      this.createdAt,
      this.createdBy,
      this.isClaimed,
      this.location,
      this.category,
      this.email,
      this.imgUrl});

  PostModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    isClaimed = json['is_claimed'];
    location = json['location'];
    category = json['category'];
    imgUrl = json['img_url'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['is_claimed'] = isClaimed;
    data['location'] = location;
    data['category'] = category;
    data['img_url'] = imgUrl;
    data['email'] = email;
    return data;
  }
}
