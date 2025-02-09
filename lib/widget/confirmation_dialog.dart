import 'package:flutter/material.dart';
import 'package:post_management/models/post.dart';
import 'package:post_management/providers/post_provider.dart';
import 'package:post_management/screens/home_screen.dart';
import 'package:provider/provider.dart';

class ConfirmationDialog extends StatelessWidget {
  final Post post;

  const ConfirmationDialog({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('Are you sure you want to delete this post?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
            Provider.of<PostProvider>(context, listen: false).deletePost(post.id);
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
