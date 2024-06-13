import 'package:cloud_firestore/cloud_firestore.dart';

class ClaimModel {
  bool? isPending;
  String? senderEmail;
  String? receiverEmail;
  Timestamp? createdAt;
  String? post;
  bool? isRejected;
  String? senderPfUrl;
  String? senderName;

  ClaimModel(
      {this.isPending,
      this.senderEmail,
      this.receiverEmail,
      this.createdAt,
      this.post,
      this.isRejected,
      this.senderName,
      this.senderPfUrl});

  ClaimModel.fromJson(Map<String, dynamic> json) {
    isPending = json['is_pending'];
    senderEmail = json['sender_email'];
    receiverEmail = json['receiver_email'];
    createdAt = json['created_at'];
    post = json['post'];
    isRejected = json['is_rejected'];
    senderPfUrl = json['sender_pf_url'];
    senderName = json['sender_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_pending'] = isPending;
    data['sender_email'] = senderEmail;
    data['receiver_email'] = receiverEmail;
    data['created_at'] = createdAt;
    data['post'] = post;
    data['is_rejected'] = isRejected;
    data['sender_pf_url'] = senderPfUrl;
     data['sender_name'] = senderName;
    return data;
  }
}
