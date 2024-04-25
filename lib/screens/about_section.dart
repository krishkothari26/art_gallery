import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.deepPurple,
        title: const Text('About'),
      ),
      body: const Text(
        'Art Gallery is a social platform for artists and art lovers to connect, inspire, and create. This is a place you can connect with and grow alongside other artists. You’ll be able to share your art, get feedback and critiques, and create a portfolio to display to the world. \n \n Art Gallery:- Place to show your Artworks',
        style: TextStyle(
          fontSize: 20,
        ),
        textAlign: TextAlign.justify,
        softWrap: true,
      ),
    );
  }
}
