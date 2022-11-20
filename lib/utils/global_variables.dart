import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instabot/screens/add_post_screen.dart';
import 'package:instabot/screens/camera.dart';
import 'package:instabot/screens/feed_screen.dart';
import 'package:instabot/screens/profile_screen.dart';
import 'package:instabot/screens/search_screen.dart';

const webScreenSize = 600;
List<Widget> homeScreenItems = [
  // const Center(
  //   child: Text('No New Notification',style: TextStyle(
  //     fontSize: 20,
  //     fontWeight: FontWeight.bold
  //   ),),
  // ),
  const FeedScreen(),
  const SearchScreen(),
  CameraScreen(),
  const AddPostScreen(),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid)
];
