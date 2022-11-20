import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String uid;
  final String bio;
  final String email;
  final List followers;
  final List following;
  final String photoUrl;

  const UserModel({
    required this.email,
    required this.uid,
    required this.bio,
    required this.photoUrl,
    required this.username,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'bio': bio,
        'email': email,
        'followers': [],
        'following': [],
        'photoUrl': photoUrl,
      };

  static UserModel fromsnap(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);

    return UserModel(
      email: snapshot['email'],
      uid: snapshot['uid'],
      bio: snapshot['bio'],
      photoUrl: snapshot['photoUrl'],
      username: snapshot['username'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
