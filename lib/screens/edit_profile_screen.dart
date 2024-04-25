import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

import '../models/user.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  Future<void> updateUserRecord(User user) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update(user.toJson());
  }

  // void signUpUser() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   String res = await AuthMethods().signUpUser(
  //     email: _emailController.text,
  //     password: _passwordController.text,
  //     username: _usernameController.text,
  //     bio: _bioController.text,
  //     file: _image!,
  //   );
  //
  //   setState(() {
  //     _isLoading = false;
  //   });
  //
  //   if (res != 'success') {
  //     showSnackBar(res, context);
  //   } else {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => const ResponsiveLayout(
  //           webScreenLayout: WebScreenLayout(),
  //           mobileScreenLayout: MobileScreenLayout(),
  //         ),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.deepPurple,
        title: const Text('Edit Profile'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              //image
              Image.asset(
                'assets/artgallery_text.png',
                // color: primaryColor,
                height: 100,
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png',
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //text field username
              TextFieldInput(
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
                hintText: 'Enter your name',
              ),
              const SizedBox(height: 20),
              //text field email
              TextFieldInput(
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
                hintText: 'Enter your email',
              ),
              const SizedBox(height: 20),
              //text field password
              TextFieldInput(
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                isPass: true,
              ),
              const SizedBox(height: 20),
              //text field bio
              TextFieldInput(
                textInputType: TextInputType.text,
                textEditingController: _bioController,
                hintText: 'Enter your bio',
              ),
              Flexible(flex: 1, child: Container()),
              //button for login
              InkWell(
                // onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: Colors.deepPurple,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Done'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
