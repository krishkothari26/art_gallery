import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/suggestions_tile.dart';

import '../utils/colors.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Activity'),
      ),
      backgroundColor: mobileBackgroundColor,
      body: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blueGrey,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Suggestions',
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blueGrey,
                  // padding: const EdgeInsets.all(3),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Likes',
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blueGrey,
                  // padding: const EdgeInsets.all(3),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Followers',
                ),
              ),
            ],
          ),
          SuggestionsTile(),
        ],
      ),
    );
  }
}
