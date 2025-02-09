import 'package:flutter/material.dart';
import 'package:post_management/models/post.dart';
import 'package:post_management/screens/post_form_screen.dart';
import 'package:post_management/widget/confirmation_dialog.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;

  const PostDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf4f6fa),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Post Details',
          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.blue,
                          child: Text(
                            post.title.isNotEmpty ? post.title[0].toUpperCase() : '',
                            style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            post.title,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Text(
                      post.body,
                      style: const TextStyle(fontSize: 14, color: Color(0xFFa4a4a4)),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostFormScreen(post: post),
                        ),
                      );
                    },
                    icon: const Icon(Icons.mode_edit_outline_outlined, color: Colors.blue),
                    label: const Text("Edit", style: TextStyle(color: Colors.blue)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmationDialog(post: post);
                        },
                      );
                    },
                    icon: const Icon(Icons.delete_outline_outlined, color: Colors.red),
                    label: const Text("Delete", style: TextStyle(color: Colors.red)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
