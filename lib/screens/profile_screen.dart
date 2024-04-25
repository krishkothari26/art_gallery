import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/screens/about_section.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      //post length
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();
      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        e.toString(),
        context,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                FirebaseAuth.instance.currentUser!.uid == widget.uid
                    ? IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: mobileBackgroundColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 240,
                                child: Column(
                                  children: [
                                    Container(
                                      // decoration: const BoxDecoration(
                                      //   color: mobileBackgroundColor,
                                      //   border: Border(
                                      //     bottom: BorderSide(
                                      //       color: Colors.grey,
                                      //     ),
                                      //   ),
                                      // ),
                                      child: Image.asset(
                                        'assets/artgallery_text.png',
                                        height: 100,
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.deepPurple,
                                      thickness: 3,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await AuthMethods().toString();
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                            const LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: mobileBackgroundColor,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        height: 50,
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: const Text(
                                          'Sign Out',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // InkWell(
                                    //   child: Container(
                                    //     decoration: const BoxDecoration(
                                    //       color: mobileBackgroundColor,
                                    //       border: Border(
                                    //         bottom: BorderSide(
                                    //           color: Colors.grey,
                                    //           width: 1,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     alignment: Alignment.centerLeft,
                                    //     height: 50,
                                    //     padding: const EdgeInsets.only(
                                    //       left: 10,
                                    //     ),
                                    //     child: const Text(
                                    //       'Saved Arts',
                                    //       style: TextStyle(
                                    //         fontSize: 20,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    InkWell(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: mobileBackgroundColor,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        height: 50,
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: const Text(
                                          'About',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AboutSection(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      )
                    : const SizedBox(),
              ],
              backgroundColor: Colors.deepPurple,
              title: Text(
                userData['username'],
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 7,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.7),
                              blurRadius: 20,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              userData['photoUrl'],
                            ),
                            radius: 50,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStatColumn(postLen, 'Art Works'),
                              buildStatColumn(followers, 'followers'),
                              buildStatColumn(following, 'following'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FirebaseAuth.instance.currentUser!.uid ==
                                      widget.uid
                                  ? const SizedBox(
                                height: 2,
                              )
                              // FollowButton(
                              //         text: 'Sign Out',
                              //         backgroundColor: mobileBackgroundColor,
                              //         textColor: primaryColor,
                              //         borderColor: Colors.grey,
                              //         function: () async {
                              //           await AuthMethods().toString();
                              //           Navigator.of(context).pushReplacement(
                              //             MaterialPageRoute(
                              //               builder: (context) =>
                              //                   const LoginScreen(),
                              //             ),
                              //           );
                              //         },
                              //       )
                                  : isFollowing
                                      ? FollowButton(
                                          text: 'Unfollow',
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black,
                                          borderColor: Colors.grey,
                                          function: () async {
                                            await FirestoreMethods().followUser(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              userData['uid'],
                                            );
                                            setState(() {
                                              isFollowing = false;
                                              followers--;
                                            });
                                          },
                                        )
                                      : FollowButton(
                                          text: 'Follow',
                                          backgroundColor: Colors.blue,
                                          textColor: Colors.white,
                                          borderColor: Colors.blue,
                                          function: () async {
                                            await FirestoreMethods().followUser(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              userData['uid'],
                                            );
                                            setState(() {
                                              isFollowing = true;
                                              followers++;
                                            });
                                          },
                                        ),
                            ],
                          ),
                        ],
                      ),

                      // profile description
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          userData['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          userData['bio'],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];
                        return Container(
                          child: Image(
                            image: NetworkImage(
                              (snap.data()! as dynamic)['postUrl'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                ),
              ],
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
