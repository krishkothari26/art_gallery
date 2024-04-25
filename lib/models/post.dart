import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.postUrl,
    required this.datePublished,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'username': username,
        'uid': uid,
        'postId': postId,
        'postUrl': postUrl,
        'datePublished': datePublished,
        'profImage': profImage,
        'likes': likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot['description'],
      uid: snapshot['uid'],
      username: snapshot['username'],
      postUrl: snapshot['postUrl'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
    );
  }
}
