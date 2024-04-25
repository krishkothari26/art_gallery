import 'package:flutter/material.dart';

class SuggestionsTile extends StatefulWidget {
  const SuggestionsTile({super.key});

  @override
  State<SuggestionsTile> createState() => _SuggestionsTileState();
}

class _SuggestionsTileState extends State<SuggestionsTile> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: Container(
          color: Colors.green,
          height: 40,
          width: 40,
          alignment: Alignment.bottomRight,
        ),
        shape: Border(
          bottom: BorderSide(color: Colors.white),
        ),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey,
        ),
        title: Text('Title'),
        subtitle: Text('Subtitle'),
    );
  }
}
